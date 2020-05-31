import 'package:flutter/material.dart';
import 'package:flutter/material.dart' ;
import 'package:flutter_app/Screen/home.dart';
import 'package:flutter_app/Screen/hotel_details/hotel_details_screen.dart';

//import 'package:flutter_app/Screen/main_screen.dart';

import 'package:flutter_app/Utils/AppConfig.dart';
import 'package:flutter_app/Screen/theme.dart' as Theme;
import 'package:flutter_app/fetchdataapi/Model/Getsinglecategory.dart';
import 'package:flutter_app/fetchdataapi/Model/likelist.dart';
import 'package:flutter_app/fetchdataapi/NetwrokUtils.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';



class favorite_screen extends StatefulWidget {
//  GetsingleCatItem getsingleCatItem;

BuildContext contxt;



  favorite_screen(@required this.contxt);
  @override
  _favorite_screenState createState() => _favorite_screenState();
}

AppConfig _appConfig;

class _favorite_screenState extends State<favorite_screen> {
  GetsingleCatItem getsingleCatItem =new GetsingleCatItem();
  List<GetLikeList> getLikeList = new List();
  final fabc = 0xFFffb3b3;
  bool _isVertical = false;
  NetworkUtil networkUtil;
  double _userRating = 3.0;
  IconData _selectedIcon;
  bool islod = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    networkUtil = new NetworkUtil();
    getfavmusiclist();
//    getsubcatdaata();
  }

  void getfavmusiclist() async {
    //  Dialogs.showLoadingDialog(context, _keyLoader);//inv
    await networkUtil.likelist(AppConfig.userid, "", "").then((value) {});
    getLikeList = LikeList.getLikeList;
    islod = false;
//    myownfavmusiclistLIst = Myownfavmusic.myownfavmusiclistLIst;

    setState(() {
//      print(myownfavmusiclistLIst[0].music_file);
    });
  }



  void getsubcatdaata(String pos) async {
//    print("cvcfcfcfc" + widget.index.toString());
     await networkUtil.viewplacesingle(AppConfig.userid,pos);

    getsingleCatItem =await GetsingleCat.getsingleCatItem[0];
    setState(() {});
  }

//
//  Future<void> listcpmments() async {
//    await networkUtil.getCommentid(widget.getsingleCatItem.place_id);
//
//    listcomments = CommentMaps.list;
//
//    setState(() {
//      isloadcomment = true;
//    }
//    );
//  }
  /*likelist() async {
    await networkUtil.addcomment(
        widget.getsingleCatItem.place_id, _textController.text);


    await listcpmments();
    setState(() {

    });
  }*/

  BuildContext context1;
  @override
  Widget build(BuildContext context) {
    context1=context;
    _appConfig = new AppConfig(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_appConfig.rHP(6.5)),
        child: AppBar(

            /*automaticallyImplyLeading: true,*/
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Color(0xFF4CB8C4),
                    Color(0xFF3CD3AD),
                  ],
                ),
              ),
            ),
            title: Container(
              child: Text(
                'Favorite Place',
                style: TextStyle(
                    fontSize: _appConfig.rHP(3), fontFamily: 'LatoBold'),
              ),
            ),
            /**/

            leading: IconButton(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => home(context)));
                  },
                  child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
            )),
      ),
      body: islod
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.tealAccent,
                  strokeWidth: 2.0,
                ),
              ),
            )
          : Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  height: _appConfig.rHP(83.3),
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: getLikeList.length,
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        onTap: () async {


                          await getsubcatdaata(getLikeList[position].place_id);






                          Navigator.of(widget.contxt).push(
                            PageRouteBuilder<void>(
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return AnimatedBuilder(
                                    animation: animation,
                                    builder:
                                        (BuildContext context, Widget child) {
                                      return DetailScreen(
                                        heroTag: "klsejfksefjeo",
                                        imageAsset: cardImageAsset(),
                                        getsingleCatItem:
                                            getsingleCatItem,
                                      );
                                    }
                                    );
                              },
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          shape: Border.all(color: Colors.grey, width: 1),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: _appConfig.rHP(20.5),
                                  width: double.infinity,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                          height: _appConfig.rHP(20),
                                          width: _appConfig.rWP(38),
                                          padding: EdgeInsets.all(0.5),
                                          decoration: new BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.all(
                                                      Radius.circular(0)),
                                              border: new Border.all(
                                                  color: Colors.black)),
                                          child: FadeInImage.assetNetwork(
                                            // here `bytes` is a Uint8List containing the bytes for the in-memory image
                                            placeholder: "assets/loading.gif",

                                            image: (NetworkUtil.BASE_URL1 +
                                                getLikeList[position]
                                                    .place_image),
                                          )
                                          /*Image.network(
                              NetworkUtil.BASE_URL1 +..........
                                  getLikeList[position].place_image, height: _appConfig.rHP(10),
                              width: _appConfig.rWP(30),
                              fit: BoxFit.cover,
                            )*/
                                          ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 0, 0),
                                                child: Container(
                                                  width: _appConfig.rW(39),
                                                  child: RichText(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    strutStyle: StrutStyle(
                                                        fontSize: 12.0),
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                      text:
                                                          getLikeList[position]
                                                              .place_name,
                                                    ),
                                                  ),

                                                  /*        Text(
                                    getLikeList[position].place_name,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: _appConfig.rWP(4.5),
                                        fontWeight: FontWeight.w600),
                                  )
                                  */
                                                ),
                                              ),
                                              SizedBox(
                                                height: _appConfig.rWP(2),
                                              ),
                                              /* Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(0, 17, 0, 0),
                                          child: Text(
                                            getLikeList[position].place_status,
                                            style: TextStyle(
                                                color: Color(0xff42D59F), fontSize: 11),
                                          ),
                                        ),*/
                                            ],
                                          ),
                                          SizedBox(
                                            height: _appConfig.rHP(1),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                7, 0, 0, 0),
                                            child: Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  width: _appConfig.rWP(40),
                                                  child: Text(
                                                    getLikeList[position]
                                                        .category_name,
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: _appConfig.rHP(1),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 5, 0, 0),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  width: _appConfig.rHP(4),
                                                  height: _appConfig.rHP(4),
                                                  decoration: new BoxDecoration(
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    gradient: new LinearGradient(
                                                        colors: [
                                                          Theme.Colors
                                                              .thirdGradientStart,
                                                          Theme.Colors
                                                              .thirdGradientEnd
                                                        ],
                                                        begin:
                                                            const FractionalOffset(
                                                                0.0, 0.0),
                                                        end:
                                                            const FractionalOffset(
                                                                1.0, 1.0),
                                                        stops: [0.0, 1.0],
                                                        tileMode:
                                                            TileMode.clamp),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      getLikeList[position]
                                                          .rate
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: _appConfig
                                                              .rWP(2.5),
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: _appConfig.rHP(1),
                                                ),
                                                Container(
                                                  width: _appConfig.rWP(44),
                                                  height: _appConfig.rHP(3),
                                                  child: RatingBarIndicator(
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0),
                                                    rating: double.parse(getLikeList[position]
                                                        .rate),
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Icon(
                                                      _selectedIcon ??
                                                          Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    itemCount: 5,
                                                    itemSize: 31.0,
                                                    direction: _isVertical
                                                        ? Axis.vertical
                                                        : Axis.horizontal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: _appConfig.rHP(1.5),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                8, 0, 0, 0),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  width: _appConfig.rWP(17),
                                                  height: _appConfig.rHP(4.3),
                                                  decoration: new BoxDecoration(
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    gradient: new LinearGradient(
                                                        colors: [
                                                          Theme.Colors
                                                              .locationGradientStart,
                                                          Theme.Colors
                                                              .locationGradientEnd
                                                        ],
                                                        begin:
                                                            const FractionalOffset(
                                                                0.0, 0.0),
                                                        end:
                                                            const FractionalOffset(
                                                                1.0, 1.0),
                                                        stops: [0.0, 1.0],
                                                        tileMode:
                                                            TileMode.clamp),
                                                  ),
                                                  child: Center(
                                                      child: Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 0, 0, 0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Image.asset(
                                                          "assets/locationkm.png",
                                                          height:
                                                              _appConfig.rHP(5),
                                                          width:
                                                              _appConfig.rWP(5),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              _appConfig.rWP(1),
                                                        ),
                                                        Container(
                                                          width:
                                                              _appConfig.rWP(7),
                                                          child: Text(
                                                            getLikeList[
                                                                    position]
                                                                .distance,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    _appConfig
                                                                        .rW(
                                                                            2.5),
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                                ),
                                                SizedBox(
                                                  width: _appConfig.rWP(2),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }

  cardImageAsset() {

  }
}

class ImageWithLabel extends StatelessWidget {
  final List<String> categories = [
    'ATM',
    'BANKS',
    'BAR',
    'BEACH',
    'CINEMA',
    'COFFEE',
    'EDUCATION',
    'HOTELS',
    'MALL',
    'MEDICAL',
    'RESAURANT',
    'TEMPLE',
    'ZOO'
  ];

  final List<String> images = [
    'assets/ic_atm.png',
    'assets/ic_bank.png',
    'assets/ic_bar.png',
    'assets/ic_beach.png',
    'assets/ic_cinema.png',
    'assets/ic_coffee.png',
    'assets/ic_library.png',
    'assets/ic_hotel.png',
    'assets/ic_mall.png',
    'assets/ic_pharmacy.png',
    'assets/ic_food.png',
    'assets/ic_temple.png',
    'assets/ic_zoo.png'
  ];

  ImageWithLabel(this.index);

  final int index;

  @override
  Widget build(BuildContext context) => Container(
        width: _appConfig.rWP(26),
        height: _appConfig.rHP(14.5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        images[index % images.length],
                        height: _appConfig.rHP(6.5),
                      ),
                      SizedBox(
                        height: _appConfig.rHP(1),
                      ),
                      Text(categories[index],
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff8E8E8E))),
                    ],
                  )),
            ),
          ),
        ),
      );
}
