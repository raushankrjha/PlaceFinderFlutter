import 'dart:async';
import 'dart:convert';

import 'package:flutter_app/Utils/AppConfig.dart';
import 'package:flutter_app/comments/Strings.dart';
import 'package:flutter_app/fetchdataapi/Model/CitysSelect.dart';
import 'package:flutter_app/fetchdataapi/Model/CommentModel.dart';
import 'package:flutter_app/fetchdataapi/Model/Getcategory.dart';
import 'package:flutter_app/fetchdataapi/Model/Getsinglecategory.dart';
import 'package:flutter_app/fetchdataapi/Model/PlaceImges.dart';
import 'package:flutter_app/fetchdataapi/Model/RegisterMaps.dart';
import 'package:flutter_app/fetchdataapi/Model/RegisterModel.dart';
import 'package:flutter_app/fetchdataapi/Model/ViewPlace.dart';
import 'package:flutter_app/fetchdataapi/Model/fullsearch.dart';
import 'package:flutter_app/fetchdataapi/Model/likelist.dart';
import 'package:flutter_app/fetchdataapi/Model/profileedit.dart';
import 'package:flutter_app/fetchdataapi/Model/searchcity.dart';
import 'package:flutter_app/fetchdataapi/SignupModel.dart';
import 'package:flutter_app/maps/CommentMaps.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkUtil {
  static final BASE_URL = "http://sagarapps.xyz/admin/API/";

  static final BASE_URL1 = "http://sagarapps.xyz/admin/";
  static String userid;

  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url) {
    return http.get(url).then((http.Response response) {
      String res = response.body;
      int statusCode = response.statusCode;
      print("API Response: " + res);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        res = "{\"status\":" +
            statusCode.toString() +
            ",\"message\":\"error\",\"response\":" +
            res +
            "}";
        throw new Exception(statusCode);
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url,
      {Map<String, String> headers, body, encoding}) {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      String res = response.body;
      int statusCode = response.statusCode;
      print("API Response: " + res);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        res = "{\"status\":" +
            statusCode.toString() +
            ",\"message\":\"error\",\"response\":" +
            res +
            "}";
        throw new Exception(statusCode);
      }
      return _decoder.convert(res);
    });
  }

  RegisterModel loginsdata;
  Future<RegisterModel> postlogin(String email, String pass,String is_social_login) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "signin";
   await post(BASE_TOKEN_URL, body: {
      "user_email": email,
      "user_password": pass,
      "is_social_login": is_social_login
    }).then((dynamic res) async {
      var results = await new RegisterMaps.getuserid(res);
      return results;
    });
  }



  Future<RegisterModel> postloginfb(String email, String pass) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "signin";
   await post(BASE_TOKEN_URL, body: {
      "user_email": email,
      "is_social_login": pass,
//      "token": querry2
    }).then((dynamic res) async {
      var results = await  RegisterMaps.getuserid(res);
      return results;
    });
  }

/*

  static Getcat rregisters;

  Future<Getcat> postgetcategory() async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "getAllCategories";
    await post(BASE_TOKEN_URL, body: {

    }).then((dynamic res) {
      rregisters = new Getcat.fromJson(res);
      return rregisters;
    });
  }


*/

  Future<List<GetCatItem>> homegetcat() async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "getAllCategories";
    await post(BASE_TOKEN_URL, body: {}).then((dynamic res) async {
      var results = GetCat.getuserid(res);

      return results;
    });
  }

  Future<GetsingleCat> singlecat(String user_id, String category_id) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "singleCategory";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "category_id": category_id,
    }).then((dynamic res) async {
      var a = await new GetsingleCat.getuserid(res);

      return a;
    });
  }

  Future<PlaceImages> viewplace(String user_id, String place_id) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "viewPlace";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "place_id": place_id,
    }).then((dynamic res) async {
      var a = await new ViewPlace.getuserid(res);
      return a;
    });
  }


  Future<GetsingleCatItem> viewplacesingle(String user_id, String place_id) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "viewPlace";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "place_id": place_id,
    }).then((dynamic res) async {
      var a = await new GetsingleCat.getuserid(res);
      return a;
    });
  }

  Future<PlaceImages> getallplace(String user_id, String place_id) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "getPlaceImages";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "place_id": place_id,
    }).then((dynamic res) async {
      var a = await new PlaceImages.getuserid(res);
      return a;
    });
  }

  Future<CommentModel> getCommentid(String query) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "getReviews";
    await post(BASE_TOKEN_URL, body: {"place_id": query, "user_id": AppConfig.userid})
        .then((dynamic res) async {
      var results = await new CommentMaps.getuserid(res);
      return results;
    });
  }

  Future addcomment(String place_id, String review_text) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "addReview";
    await post(BASE_TOKEN_URL, body: {
      "user_id": AppConfig.userid,
      "place_id": place_id,
      "review_text": review_text
    }).then((dynamic res) {});
  }

  Future liked(String query) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "like";
    await post(BASE_TOKEN_URL, body: {"place_id": query, "user_id": AppConfig.userid})
        .then((dynamic res) async {
//      var results = await new CommentMaps.getuserid(res);
//      return results;
    });
  }

  Future unliked(String query) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "unlike";
    await post(BASE_TOKEN_URL, body: {"place_id": query, "user_id": AppConfig.userid})
        .then((dynamic res) async {
//      var results = await new CommentMaps.getuserid(res);
//      return results;
    });
  }

  Future rating(String place_id, String rate) {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "addRating";
    post(BASE_TOKEN_URL,
            body: {
      "user_id": AppConfig.userid, "place_id": place_id, "rate": rate})
        .then((dynamic res) {});
  }

  static EditProfile editProfile;

  Future<EditProfile> editprofile(
      String user_id,
      String user_name,
      String user_phone,
      String user_address,
      String user_profile_pic,

    ) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "editProfile";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "user_name": user_name,
      "user_profile_pic": user_profile_pic,
      "user_phone": user_phone,
      "user_address": user_address,
//      "user_city": user_city,

//      "user_max_distance": user_max_distance,
//      "user_notification_status": user_notification_status,
//      "user_token": user_token
    }).then((dynamic res) async {
   var   editProfile = await  EditProfile.getuserid(res);
      return editProfile;
    });
  }



  Future<EditProfile> editprofile1(
      String user_id,
      String user_name,
      String user_phone,
      String user_address,
//      String user_profile_pic,
      ) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "editProfile";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "user_name": user_name,
//      "user_profile_pic": user_profile_pic,
      "user_phone": user_phone,
      "user_address": user_address,
//      "user_city": user_city,
//      "user_lat": user_lat,
//      "user_long": user_long,
//      "user_max_distance": user_max_distance,
//      "user_notification_status": user_notification_status,
//      "user_token": user_token
    }).then((dynamic res) async {
     var editProfile = await  EditProfile.getuserid(res);
      return editProfile;
    });
  }


  Future<EditProfile> getprofile(
     ) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "editProfile";
    await post(BASE_TOKEN_URL, body: {
      "user_id": AppConfig.userid,

    }).then((dynamic res) async {
      editProfile = await  EditProfile.getuserid(res);
      return editProfile;
    });
  }




  Future<EditProfile> setnotification(String user_notification_status
      ) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "editProfile";
    await post(BASE_TOKEN_URL, body: {
      "user_id": AppConfig.userid,
      "user_notification_status":user_notification_status

    }).then((dynamic res) async {
      editProfile = await  EditProfile.getuserid(res);
      return editProfile;
    });
  }






  Future<List<SearchList>> searchlist() async {


    print("aaaaaa"+AppConfig.userid);
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "search";
    await post(BASE_TOKEN_URL, body: {

      "user_id": AppConfig.userid,
      "distance": AppConfig.distcance,
      "category_id":AppConfig.cate,
          "city":AppConfig.citys,

    }).then((dynamic res) async {
      var results = SearchList.getuserid(res);

      return results;
    });
  }
  Future<List<CitysSelect>> searchcitylist() async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "cityList";
    await post(BASE_TOKEN_URL, body: { }).then((dynamic res) async {
      var results = CitysSelect.getuserid(res);

      return results;
    });
  }
  Future<List<GetLikeList>> likelist(String user_id, String start, String end) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "getLikeList";
   await post(BASE_TOKEN_URL, body: {"user_id": AppConfig.userid, "start": start, "end": end})
        .then((dynamic res) async {
      var results = await LikeList.getuserid(res);

      return results;
    });
  }

  Future<List<Fullsearch>> fullsearch(String user_id, String search, String category_id,String distance,String city) {

    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "search";
    post(BASE_TOKEN_URL, body: {
      "user_id": AppConfig.userid,
      "search": search,
      "category_id": category_id,
      "distance":distance,
      "city":city
    })
        .then((dynamic res) async {
      var results = await LikeList.getuserid(res);

      return results;
    });
  }
  static Registers rregisters;
  Future<Registers> postregisterfb(String email, String password, String token,
      String profile, String name,String is_social_login,String user_lat,String user_long,String user_address,String user_city) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "signup";
    await post(BASE_TOKEN_URL, body: {
      "user_email": email,
      "user_password": password,
      "user_token": token,
      "user_profile_pic": profile,
      "user_name": name,
      "is_social_login":is_social_login,
      "user_lat":user_lat,
      "user_long":user_long,
      "user_address":user_address,
      "user_city":user_city
    }).then((dynamic res) async {
      results  = await User.fromJson(res);
      return results;
    });
  }



  Future<Registers> postregister(String email, String password, String token,
      String profile, String name,String user_lat,String user_long,String user_address,
      String user_city,String user_profile_pic) async
  {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "signup";
    await post(BASE_TOKEN_URL, body: {
      "user_email": email,
      "user_password": password,
      "user_token": token,
      "user_phone": profile,
      "user_name": name,
      "user_lat":user_lat,
      "user_long":user_long,
      "user_address":user_address,
      "user_city":user_city,
      "user_profile_pic":user_profile_pic
    }).then((dynamic res) async {
      results  = await User.fromJson(res);

      return results;
    });
  }
 static User results;
}
/*Future<List<Myownfavmusic>> myfavownmusic(
    String user_id) async {
  String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "home";
  await post(BASE_TOKEN_URL, body: {
    "user_id": user_id,
    "is_myProfile":AppConfig.userid,
    "home_components_name": "Recommended Music",
  }).then((dynamic res) async {


    var results=await Myownfavmusic.getuserid(res);


    return results;
  });
}*/
/*  Future<Registers> signin(String email, String password, String token) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "signin";
    await post(BASE_TOKEN_URL, body: {
      "user_email": email,
      "user_password": password,
      "user_token": token,
    }).then((dynamic res) async {
      rregisters = await new Registers.fromJson(res[0]);

      print(rregisters.user_email);
      return rregisters;
    });
  }

  Future<List<Recentplay>> recentplay(
      String user_id) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "home";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "home_components_name": "Recently Played",
    }).then((dynamic res) async {


      var results=RecentplayList.getuserid(res);


      return results;
    });
  }

  static Registers rregisters;




  Future<List<Favouriteartist>> favoriteartist(
      String user_id) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "home";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "home_components_name": "Favourite Artists",
    }).then((dynamic res) async {


      var results=Favouriteartist.getuserid(res);


      return results;
    });
  }



  Future<List<USerplaylist>> ownplaylist(
      String user_id) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "getPlaylists";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,

    }).then((dynamic res) async {


      var results=USerplaylist.getuserid(res);


      return results;
    });
  }


  Future<List<Myownfavmusic>> myfavownmusic(
      String user_id) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "home";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "home_components_name": "Recommended Music",
    }).then((dynamic res) async {


      var results=Myownfavmusic.getuserid(res);


      return results;
    });
  }

  Future<List<Myownfavalbum>> myfavowalbum(
      String user_id) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "home";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "home_components_name": "Recommended Album",
    }).then((dynamic res) async {


      var results=Myownfavalbum.getuserid(res);


      return results;
    });
  }


  Future<List<Homecopnetslist>> homecompent()async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "home_components";
    await post(BASE_TOKEN_URL, body: {}).then((dynamic res) async {


      var results=Homecopnetslist.getuserid(res);


      return results;
    });
  }



  Future<List<BannerSide>> homebannersliderlist(String user_id)async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "home";
    await post(BASE_TOKEN_URL, body: {
    "user_id": user_id,
    "home_components_name": "Banner Slider"}).then((dynamic res) async {


      var results=BannerSide.getuserid(res);


      return results;
    });
  }


  Future<List<HomeMOstPlayed>> homemostplayelist(String user_id)async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "home";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "home_components_name": "Most Played"}).then((dynamic res) async {


      var results=HomeMOstPlayed.getuserid(res);


      return results;
    });
  }





  Future<List<HomePopularAlbums>> homepopulralbumlist(String user_id)async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "home";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "home_components_name": "Popular Albums"}).then((dynamic res) async {


      var results=HomePopularAlbums.getuserid(res);


      return results;
    });
  }



  Future<List<HomeRPopularMovie>> homepopulrmoviewlist(String user_id)async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "home";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "home_components_name": "Popular Movies"}).then((dynamic res) async {


      var results=HomeRPopularMovie.getuserid(res);


      return results;
    });
  }




  Future<List<HomeRecommendedMovie>> homeprecmdedmoviewlist(String user_id)async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "home";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "home_components_name": "Recommended Movies"}).then((dynamic res) async {


      var results=HomeRecommendedMovie.getuserid(res);


      return results;
    });
  }




  Future<List<HomeRecommendedAlbum>> homeprecmdedalbumlist(String user_id)async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "home";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "home_components_name": "Recommended Album"}).then((dynamic res) async {


      var results=HomeRecommendedAlbum.getuserid(res);


      return results;
    });
  }




  Future<List<HomeRecommendedMusic>> homeprecmdedmusiclist(String user_id)async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "home";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "home_components_name": "Recommended Music"}).then((dynamic res) async {


      var results=HomeRecommendedMusic.getuserid(res);


      return results;
    });
  }











  Future<bool> islike(
      String user_id,String type,String music_id) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "like";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "like_type": type,
      "like_type_id":music_id,
    }).then((dynamic res) async {




      return true;
    });
  }


  Future<bool> isunlike(
      String user_id,String type,String music_id) async {
    String BASE_TOKEN_URL = NetworkUtil.BASE_URL + "unlike";
    await post(BASE_TOKEN_URL, body: {
      "user_id": user_id,
      "like_type": type,
      "like_type_id":music_id,
    }).then((dynamic res) async {




      return true;
    });
  }*/
