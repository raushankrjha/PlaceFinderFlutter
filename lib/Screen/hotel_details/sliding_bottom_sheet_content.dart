import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_app/Screen/hotel_details/comment_list.dart';
import 'package:flutter_app/Screen/hotel_details/icons.dart';
import 'package:flutter_app/Screen/hotel_details/map_open.dart';
import 'package:flutter_app/Screen/hotel_details/stub_data.dart';
import 'package:flutter_app/Screen/hotel_details/theme1.dart';
import 'package:flutter_app/Screen/hotel_details/parallax_page_view.dart';
import 'package:flutter_app/Screen/hotel_details/viewall_img.dart';
import 'package:flutter_app/Utils/AppConfig.dart';
import 'package:flutter_app/Utils/Dialogs.dart';
import 'package:flutter_app/fetchdataapi/Model/CommentModel.dart';
import 'package:flutter_app/fetchdataapi/Model/Getsinglecategory.dart';
import 'package:flutter_app/fetchdataapi/Model/PlaceImges.dart';
import 'package:flutter_app/fetchdataapi/Model/RegisterModel.dart';
import 'package:flutter_app/fetchdataapi/Model/searchcity.dart';
import 'package:flutter_app/fetchdataapi/NetwrokUtils.dart';
import 'package:flutter_app/maps/CommentMaps.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/Screen/theme.dart' as Theme;

AppConfig _appConfig;

class BottomSheetContent extends StatefulWidget {
  final AnimationController controller;
  GetsingleCatItem getsingleCatItem;
  List<GetPlaceImages> getplaceimages;

  RegisterModel registerModel;

  BottomSheetContent(
      {this.controller, this.getsingleCatItem, this.getplaceimages});

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  /* final List<String> images = [
    'assets/user_1.png',
    'assets/user_2.png',
    'assets/user_3.png',
    'assets/user_4.png',
    'assets/user_5.png',
    'assets/user_6.png',
  ];*/

  var _ratingController = TextEditingController();
  double _rating = 0;
  double _userRating = 3.0;
  int _ratingBarMode = 1;

  BuildContext con;
  bool islod = true;
  List<RegisterModel> _listcomments1 = new List();
  List<GetSearchList> searchlist = new List();

//  List<FavouriteartistItem> favlistartists = new List();

  GetsingleCatItem getsingleCatItem;
  @override
  void initState() {
    super.initState();
    networkUtil = NetworkUtil();
    _ratingController.text = "3.0";

    getsubcatdaata(widget.getsingleCatItem.place_id);


  }
  void getsubcatdaata(String pos) async {
//    print("cvcfcfcfc" + widget.index.toString());
    await networkUtil.viewplacesingle(AppConfig.userid,pos);

    getsingleCatItem = GetsingleCat.getsingleCatItem[0];

    listcpmments();
    getsearchdaata();
    setState(() {});
  }
  void getsearchdaata() async {
    await networkUtil.searchlist();
    islod = false;


    print("aaaa"+getsingleCatItem.is_liked.toString());
    if(getsingleCatItem.is_liked==0)
      {
        liked=false;
      }else
        {
          liked=true;
        }
    _rating=double.parse(getsingleCatItem.my_rate);


    searchlist = SearchList.searchlist;
    setState(() {});
  }

  NetworkUtil networkUtil;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  addcomments() async {



    Dialogs.showLoadingDialog(context, _keyLoader);





    await networkUtil.addcomment(
        getsingleCatItem.place_id, _textController.text);

    await listcpmments();



    Navigator.pop(
        context);

    setState(() {});




  }

  addrating() async {
    await networkUtil.rating(
        getsingleCatItem.place_id, _rating.toString());

    await listcpmments();
    setState(() {});
  }

  userlike() async {
    await networkUtil.liked(getsingleCatItem.place_id);

    await listcpmments();
    setState(() {});
  }

  userunlike() async {
    await networkUtil.unliked(getsingleCatItem.place_id);

    await listcpmments();
    setState(() {});
  }

  TextEditingController _textController = TextEditingController();
  bool liked = false;

  _pressed() {


print(liked.toString());



    if (liked) {
      userlike();
//      userunlike();
    } else {
      userunlike();
//      userlike();
    }


  }

  @override
  Widget build(BuildContext context) {
    _appConfig = new AppConfig(context);
    con = context;
    final themeData = HotelConceptThemeProvider.get();
    final double topPaddingMax = 44;
    final double topPaddingMin = MediaQuery.of(context).padding.top;
    double topMarginAnimatedValue =
        (1 - widget.controller.value) * topPaddingMax * 2;
    double topMarginUpdatedValue = topMarginAnimatedValue <= topPaddingMin
        ? topPaddingMin
        : topMarginAnimatedValue;
    return islod
        ? Container(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.tealAccent,
                strokeWidth: 2.0,
              ),
            ),
          )
        : AnimatedContainer(
            duration: Duration(milliseconds: 200),
            child: Padding(
              padding: EdgeInsets.only(top: topMarginUpdatedValue),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ScrollConfiguration(
                    behavior: OverScrollBehavior(),
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: IntrinsicHeight(
                          child: Container(
                            height: constraints.maxHeight,
                            child: SingleChildScrollView(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                  margin: prefix0.EdgeInsets.only(top: 5),
                                            width: _appConfig.rWP(75),
                                            child: Text(
                                              widget
                                                  .getsingleCatItem.place_name,
                                              style: TextStyle(
                                                  color: themeData
                                                      .primaryColorLight,
                                                  fontSize: 24),
                                            ),
                                          ),

                                        ],
                                      ),




                                      Container(

                                        child: Row(
                                          children: <Widget>[
                                            Container(

                                              height: _appConfig.rHP(3),
                                              child: RatingBarIndicator(
                                                itemPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 0),
                                                rating: double.parse(getsingleCatItem.rate),
                                                itemBuilder:
                                                    (context, index) =>
                                                    Icon(

                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                itemCount: 5,
                                                itemSize: 22.0,
                                                direction: Axis.horizontal,
                                              ),
                                            ),
                                            const SizedBox(width: 3),
                                            Text("("+
                                              getsingleCatItem
                                                  .rate_count+")",
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),



                                      Container(
                                        margin: prefix0.EdgeInsets.only(top: 5),
                                        child: Text(
                                          searchlist[0].place_city,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: themeData.primaryColorLight,
                                          ),

                                          /*getsingleCatItem
                                    .place_city,*/
                                        ),
                                      ),
                                      Container(
                                        margin: prefix0.EdgeInsets.only(top: 5),
                                        child: Text(
                                          getsingleCatItem.distance +
                                              " km",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blueAccent,
                                          ),

                                          /*getsingleCatItem
                                    .place_city,*/
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      /*  Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    Text("45 Curtain Road, London EC2A 3PT"),
                                  ],
                                ),*/
                                      const SizedBox(height: 18),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          map_open(double.parse(getsingleCatItem.place_lat),double.parse(getsingleCatItem.place_long))));
                                            },
                                            child: Container(
                                              width: _appConfig.rHP(7),
                                              height: _appConfig.rHP(7),
                                              decoration: new BoxDecoration(
                                                borderRadius:
                                                    new BorderRadius.all(
                                                        Radius.circular(30)),
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
                                                    end: const FractionalOffset(
                                                        1.0, 1.0),
                                                    stops: [0.0, 1.0],
                                                    tileMode: TileMode.clamp),
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/locationkm.png",
                                                  height: _appConfig.rHP(7),
                                                  width: _appConfig.rWP(7),
                                                ),
                                              ),
                                            ),
                                          ),
                                          /*getsingleCatItem.place_phone == ""
        ? Container()
        :*/
                                          GestureDetector(
                                            onTap: () {
                                              if (getsingleCatItem
                                                      .place_phone ==
                                                  "") {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "contact not available",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIos: 1,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              }
                                            },
                                            child: Container(
                                              width: _appConfig.rHP(7),
                                              height: _appConfig.rHP(7),
                                              decoration: new BoxDecoration(
                                                borderRadius:
                                                    new BorderRadius.all(
                                                        Radius.circular(30)),
                                                gradient: new LinearGradient(
                                                    colors: [
                                                      Theme.Colors
                                                          .firstGradientStart,
                                                      Theme.Colors
                                                          .firstGradientEnd
                                                    ],
                                                    begin:
                                                        const FractionalOffset(
                                                            0.0, 0.0),
                                                    end: const FractionalOffset(
                                                        1.0, 1.0),
                                                    stops: [0.0, 1.0],
                                                    tileMode: TileMode.clamp),
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/call.png",
                                                  height: _appConfig.rHP(7),
                                                  width: _appConfig.rWP(7),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(


                                            onTap: (){

                                                liked = !liked;

                                              _pressed();
                                              setState(() {

                                              });
                                            },
                                            child: Container(
                                              width: _appConfig.rHP(7),
                                              height: _appConfig.rHP(7),
                                      /*        decoration: new BoxDecoration(
                                                borderRadius:
                                                    new BorderRadius.all(
                                                        Radius.circular(30)),
                                                gradient: new LinearGradient(
                                                    colors: [
                                                      Theme.Colors
                                                          .thirdGradientStart,
                                                      Theme.Colors
                                                          .thirdGradientEnd
                                                    ],
                                                    begin:
                                                        const FractionalOffset(
                                                            0.0, 1.0),
                                                    end: const FractionalOffset(
                                                        1.0, 1.0),
                                                    stops: [0.0, 0.5],
                                                    tileMode: TileMode.clamp),
                                              ),*/
                                              child:liked?Image.asset("assets/btn_favorite_press.png"):
                                              Image.asset("assets/btn_favorite_unpress.png") /*IconButton(
                                                icon: Icon(
                                                    liked
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: liked
                                                        ? Colors.white
                                                        : Colors.white),
                                                onPressed: () => _pressed(),
                                              )*/,
                                            ),
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              width: _appConfig.rHP(7),
                                              height: _appConfig.rHP(7),
                                              decoration: new BoxDecoration(
                                                borderRadius:
                                                    new BorderRadius.all(
                                                        Radius.circular(30)),
                                                gradient: new LinearGradient(
                                                    colors: [
                                                      Theme.Colors
                                                          .fourGradientStart,
                                                      Theme.Colors
                                                          .fourGradientEnd
                                                    ],
                                                    begin:
                                                        const FractionalOffset(
                                                            0.0, 0.0),
                                                    end: const FractionalOffset(
                                                        1.0, 1.0),
                                                    stops: [0.0, 1.0],
                                                    tileMode: TileMode.clamp),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.share,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: _appConfig.rHP(3),
                                      ),
//                                      Container(
//                                        width: double.infinity,
//                                        height: 1,
//                                        color: Color(0xffDCDCDC),
//                                      ),
//                                      SizedBox(
//                                        height: _appConfig.rHP(3),
//                                      ),
//                                      Text(
//                                        "Simple quarters in a no-nonsense budget hotel offering free vegetarian breakfast.",
//                                        style: TextStyle(
//                                          fontSize: _appConfig.rHP(2),
//                                          fontFamily: 'LatoMedium',
//                                        ),
//                                        softWrap: true,
//                                      ),
                                      SizedBox(
                                        height: _appConfig.rHP(3),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 1,
                                        color: Color(0xffDCDCDC),
                                      ),
                                      SizedBox(
                                        height: _appConfig.rHP(3),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              width: _appConfig.rWP(8),
                                              child: Icon(
                                                Icons.location_on,
                                                color: Color(0xff47BFBD),
                                              )),
                                          Container(
                                            width: _appConfig.rWP(75),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 10, 0),
                                              child: RichText(
//                                    overflow: TextOverflow.ellipsis,
                                                strutStyle:
                                                    StrutStyle(fontSize: 12.0),
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'LatoMedium',
                                                    fontSize: _appConfig.rHP(2),
                                                  ),
                                                  text: getsingleCatItem
                                                      .place_address,
                                                ),
                                              ),

                                              /*   Text(
                                          getsingleCatItem.place_address,
                                          softWrap: true,
                                          style: TextStyle(
                                            fontSize: _appConfig.rHP(2),
                                            fontFamily: 'LatoMedium',
                                          ),
                                        ),*/
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: _appConfig.rHP(3),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 1,
                                        color: Color(0xffDCDCDC),
                                      ),
                                      SizedBox(
                                        height: _appConfig.rHP(3),
                                      ),
                                      getsingleCatItem.place_website ==
                                              ""
                                          ? Container()
                                          : Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                        width:
                                                            _appConfig.rWP(8),
                                                        child: Icon(
                                                          Icons.language,
                                                          color:
                                                              Color(0xff47BFBD),
                                                        )),
                                                    Container(
                                                      width: _appConfig.rWP(75),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 10, 0),
                                                        child: RichText(
//                                    overflow: TextOverflow.ellipsis,
                                                          strutStyle:
                                                              StrutStyle(
                                                                  fontSize:
                                                                      12.0),
                                                          text: TextSpan(
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'LatoMedium',
                                                              fontSize:
                                                                  _appConfig
                                                                      .rHP(2),
                                                            ),
                                                            text: widget
                                                                .getsingleCatItem
                                                                .place_website,
                                                          ),
                                                        ),

                                                        /*   Text(
                                              getsingleCatItem.place_address,
                                              softWrap: true,
                                              style: TextStyle(
                                                fontSize: _appConfig.rHP(2),
                                                fontFamily: 'LatoMedium',
                                              ),
                                            ),*/
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: _appConfig.rHP(3),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 1,
                                                  color: Color(0xffDCDCDC),
                                                ),
                                                SizedBox(
                                                  height: _appConfig.rHP(3),
                                                ),
                                              ],
                                            ),
                                      getsingleCatItem.place_phone == ""
                                          ? Container()
                                          : Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                        width:
                                                            _appConfig.rWP(8),
                                                        child: Icon(
                                                          Icons.call,
                                                          color:
                                                              Color(0xff47BFBD),
                                                        )),
                                                    Container(
                                                      width: _appConfig.rWP(75),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 10, 0),
                                                        child: RichText(
//                                    overflow: TextOverflow.ellipsis,
                                                          strutStyle:
                                                              StrutStyle(
                                                                  fontSize:
                                                                      12.0),
                                                          text: TextSpan(
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'LatoMedium',
                                                              fontSize:
                                                                  _appConfig
                                                                      .rHP(2),
                                                            ),
                                                            text: widget
                                                                .getsingleCatItem
                                                                .place_phone,
                                                          ),
                                                        ),

                                                        /*   Text(
                                              getsingleCatItem.place_address,
                                              softWrap: true,
                                              style: TextStyle(
                                                fontSize: _appConfig.rHP(2),
                                                fontFamily: 'LatoMedium',
                                              ),
                                            ),*/
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: _appConfig.rHP(3),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 1,
                                                  color: Color(0xffDCDCDC),
                                                ),
                                                SizedBox(
                                                  height: _appConfig.rHP(3),
                                                ),
                                              ],
                                            ),
                                      getsingleCatItem.place_city == ""
                                          ? Container()
                                          : Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                        width:
                                                            _appConfig.rWP(8),
                                                        child: Icon(
                                                          Icons.location_city,
                                                          color:
                                                              Color(0xff47BFBD),
                                                        )),
                                                    Container(
                                                      width: _appConfig.rWP(75),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 10, 0),
                                                        child: RichText(
//                                    overflow: TextOverflow.ellipsis,
                                                          strutStyle:
                                                              StrutStyle(
                                                                  fontSize:
                                                                      12.0),
                                                          text: TextSpan(
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'LatoMedium',
                                                              fontSize:
                                                                  _appConfig
                                                                      .rHP(2),
                                                            ),
                                                            text: widget
                                                                .getsingleCatItem
                                                                .place_city,
                                                          ),
                                                        ),

                                                        /*   Text(
                                              getsingleCatItem.place_address,
                                              softWrap: true,
                                              style: TextStyle(
                                                fontSize: _appConfig.rHP(2),
                                                fontFamily: 'LatoMedium',
                                              ),
                                            ),*/
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: _appConfig.rHP(3),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 1,
                                                  color: Color(0xffDCDCDC),
                                                ),
                                                SizedBox(
                                                  height: _appConfig.rHP(3),
                                                ),
                                              ],
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Rate",
                                          style: TextStyle(
                                              fontSize: _appConfig.rHP(3),
                                              fontFamily: 'LatoBold ',
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff5D5D5D)),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      SizedBox(
                                        height: _appConfig.rHP(3),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: RatingBar(
                                          initialRating: _rating,
//              direction: _isVertical ? Axis.vertical : Axis.horizontal,
                                          itemCount: 5,
                                          itemSize: _appConfig.rWP(13),
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          itemBuilder: (context, index) {
                                            switch (index) {
                                              case 0:
                                                return Icon(
                                                  Icons
                                                      .sentiment_very_dissatisfied,
                                                  color: Colors.red,
                                                );
                                              case 1:
                                                return Icon(
                                                  Icons.sentiment_dissatisfied,
                                                  color: Colors.redAccent,
                                                );
                                              case 2:
                                                return Icon(
                                                  Icons.sentiment_neutral,
                                                  color: Colors.amber,
                                                );
                                              case 3:
                                                return Icon(
                                                  Icons.sentiment_satisfied,
                                                  color: Colors.lightGreen,
                                                );
                                              case 4:
                                                return Icon(
                                                  Icons
                                                      .sentiment_very_satisfied,
                                                  color: Colors.green,
                                                );
                                              default:
                                                return Container();
                                            }
                                          },

                                          onRatingUpdate: (rating) {
                                            setState(() {
                                              _rating = rating;
                                              addrating();
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: _appConfig.rHP(3),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                "Review",
                                                style: TextStyle(
                                                    fontSize: _appConfig.rHP(3),
                                                    fontFamily: 'LatoBold ',
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff5D5D5D)),
                                              ),
                                                 GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CommentList(widget
                                                            .getsingleCatItem)));
                                          },
                                          child: Text(
                                            "View ALL",
                                            style: TextStyle(
                                              color: Color(0xff47BFBD),
                                            ),
                                          ),
                                        ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: TextField(
                                          style: TextStyle(color: Colors.black),
                                          controller: _textController,
                                          decoration: InputDecoration(
                                            hintText:
                                                "Share your experience to help others",
                                            hintStyle: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                            suffixIcon: GestureDetector(
                                                onTap: () {
                                                  this.setState(() {

                                                    addcomments();

//                                         Text(_center.toString());
//                                         print(_center);
                                                    _textController.clear();
                                                  });
                                                },
                                                child: Icon(Icons.send)),
                                          ),
                                        ),
                                      ),
                                      listviewCommente(),
                                      listcomments.length > 3
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CommentList(widget
                                                                .getsingleCatItem)));
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text("",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.blue,
                                                      )),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "Photos",
                                              style: TextStyle(
                                                  fontSize: _appConfig.rHP(3),
                                                  fontFamily: 'LatoBold ',
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff5D5D5D)),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Viewallimg(widget
                                                                .getplaceimages)));
                                              },
                                              child: Text(
                                                "View ALL",
                                                style: TextStyle(
                                                  color: Color(0xff47BFBD),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          height: _appConfig.rHP(20),
                                          child: mostplay())
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }

  Widget mostplay() {
    return Container(
      height: _appConfig.rH(20),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.getplaceimages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) {
                    return new Material(
                      color: Colors.black54,
                      child: Container(
                        padding: EdgeInsets.all(30.0),
                        child: InkWell(
                          child: Hero(
                              tag:
                                  "hero-grid-${widget.getplaceimages[index].hashCode}",
                              child: Image.network(
                                NetworkUtil.BASE_URL1 +
                                    widget.getplaceimages[index].place_image,
                                width: 300.0,
                                height: 300.0,
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                              )),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                  transitionDuration: Duration(milliseconds: 500)));
            },
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
                width: _appConfig.rW(35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: _appConfig.rH(15),
                      padding: EdgeInsets.all(0.8),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: Colors.black,
                          //                   <--- border color
                          width: 0.1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: FadeInImage.assetNetwork(
                          // here `bytes` is a Uint8List containing the bytes for the in-memory image
                          placeholder: "assets/loading.gif",

                          image: (NetworkUtil.BASE_URL1 +
                              widget.getplaceimages[index].place_image),
                        ),
                        /*Image.network(
                          NetworkUtil.BASE_URL1 +
                              widget.getplaceimages[index].place_image,
                          //last listvew img

                          fit: BoxFit.fill,
                        ),*/
                      ),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }

  bool isloading = false;

  List<CommentModel> listcomments = new List();

  Future<void> listcpmments() async {
    await networkUtil.getCommentid(getsingleCatItem.place_id);

    listcomments = CommentMaps.list;

    setState(() {
      isloadcomment = true;
    });
  }

  bool isloadcomment = false;

  Widget childcomment(int index) {
    print("hsdfjsdfhjsdhf" + index.toString());

    return Container(
      height: _appConfig.rW(20),
      margin: EdgeInsets.all(5.0),
      child: Card(
        color: Colors.white,
        elevation: 2,
          semanticContainer: true,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        child: Container(

          color: Color(0xffFfffff),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: _appConfig.rW(20),
                  child: Image.network(NetworkUtil.BASE_URL1 +
                      listcomments[index].user_profile_pic),
                ),
                Container(
                  width: _appConfig.rW(60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                          listcomments[index].user_name,
                          style: TextStyle(
                              color: Color(0xff146BB1),
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                      ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(
                          listcomments[index].review_text,
                          style: TextStyle(
                              color: Color(0xffAFB1B3),
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double height(int lenh) {
    print("mk,omkomk" + lenh.toString());
    if (lenh == 1) {
      return _appConfig.rHP(14);
    } else if (lenh == 2) {
      return _appConfig.rHP(24);
    } else {
      return _appConfig.rHP(34);
    }
  }

  Widget listviewCommente() {
    return Container(
      width: double.infinity,
      child: listcomments.length > 0
          ? Container(
              height: height(listcomments.length),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: listcomments.length,
                  itemBuilder: (context, position) {
                    return childcomment(position);
                  }),
            )
          : Container(),
    );
  }


}

/*Widget childcomment(int index) {
  return Container(
    height: _appConfig.rHP(15),
    margin: EdgeInsets.all(5.0),
    child: Container(
      child: Container(
        color: Color(0xffF6F6F6),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: _appConfig.rW(20),
                child: Image.asset('assets/user_1.png'),
              ),
              Container(
                width: _appConfig.rW(55),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "abc",
                      style: TextStyle(
                          color: Color(0xff146BB1),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "nicevvvvvvvvvvvvvvvvvvvvv",
                        style: TextStyle(
                            color: Color(0xffAFB1B3),
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}*/

final List<String> images = [
  'assets/user_1.png',
  'assets/user_2.png',
  'assets/user_3.png',
  'assets/user_4.png',
  'assets/user_5.png',
  'assets/user_6.png',
];

double heihtcount(int lenth) {
  if (lenth == 1) {
    return _appConfig.rH(20);
  } else if (lenth == 2) {
    return _appConfig.rH(40);
  } else if (lenth == 3) {
    return _appConfig.rH(60);
  }
}
