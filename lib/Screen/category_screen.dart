import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_app/Screen/hotel_details/hotel_details_screen.dart';

import 'package:flutter_app/Screen/main_screen.dart';

import 'package:flutter_app/Utils/AppConfig.dart';
import 'package:flutter_app/Screen/theme.dart' as Theme;
import 'package:flutter_app/fetchdataapi/Model/Getcategory.dart';
import 'package:flutter_app/fetchdataapi/Model/Getsinglecategory.dart';
import 'package:flutter_app/fetchdataapi/NetwrokUtils.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class category_screen extends StatefulWidget {
  category_screen(this.child, @required this.index);

  String index;
  BuildContext context;
  final Widget child;

  @override
  _category_screenState createState() => _category_screenState();
}

AppConfig _appConfig;

class _category_screenState extends State<category_screen> {
  List searchresult = new List();
  bool _isSearching;
  final TextEditingController _searchQuery = new TextEditingController();
  List<dynamic> _list;
  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  Widget appBarTitle = new Text(
    "Search Example",
    style: new TextStyle(color: Colors.white),
  );
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _list.length; i++) {
        String data = _list[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }

  final fabc = 0xFFffb3b3;
  NetworkUtil networkUtil;
  double _userRating = 3.0;
  IconData _selectedIcon;
  bool _isVertical = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    networkUtil = new NetworkUtil();
    getcatdaata();
    getsubcatdaata(); _isSearching = false;
  }

  List<GetCatItem> catgorylist = new List();
  final TextEditingController _controller = new TextEditingController();
  List<GetsingleCatItem> getsingleCatItem = new List();

  void getcatdaata() async {
    await networkUtil.homegetcat();

    catgorylist = GetCat.homeGetCatlist;
    setState(() {});
  }

  void getsubcatdaata() async {
    print("cvcfcfcfc" + widget.index.toString());
    await networkUtil.singlecat(AppConfig.userid, widget.index);

    getsingleCatItem = GetsingleCat.getsingleCatItem;
    setState(() {});
  }
String appbarname="Category";
  @override
  Widget build(BuildContext context) {
    void _handleSearchStart() {
      setState(() {
        _isSearching = true;
      });
    }

    void _handleSearchEnd() {
      setState(() {
        this.actionIcon = new Icon(Icons.search, color: Colors.white,);
        this.appBarTitle =
        new Text("Search Sample", style: new TextStyle(color: Colors.white),);
        _isSearching = false;
        _searchQuery.clear();
      });
    }

    _appConfig = new AppConfig(context);
    return Scaffold(
      /*AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
        new IconButton(
          icon: icon,
          onPressed: () {
            setState(() {
              if (this.icon.icon == Icons.search) {
                this.icon = new Icon(
                  Icons.close,
                  color: Colors.white,
                );
                this.appBarTitle = new TextField(
                  controller: _controller,
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: new TextStyle(color: Colors.white)),
                  onChanged: searchOperation,
                );
                _handleSearchStart();
              } else {
                _handleSearchEnd();
              }
            }
            );
          },
        ),
      ]
      )*/
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.greenAccent,
            height: _appConfig.rHP(27.5),
            child: Stack(
              children: <Widget>[
                Container(
                    height: _appConfig.rHP(32),
                    width: double.infinity,
                    child: Image.asset(
                      "assets/header_bg.png",
                      fit: BoxFit.cover,
                    )
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: _appConfig.rHP(5),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: _appConfig.rWP(7),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                            child: Text(
                              appbarname,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: _appConfig.rWP(6),

                                  fontFamily: 'LatoBold'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          /*  child: GestureDetector(
                                child: IconButton(
                              icon: icon,
                              onPressed: () {
                                setState(() {
                                  if (this.actionIcon.icon == Icons.search) {
                                    this.actionIcon = new Icon(Icons.close, color: Colors.white,);
                                    this.appBarTitle = new TextField(
                                      controller: _searchQuery,
                                      style: new TextStyle(
                                        color: Colors.white,

                                      ),
                                      decoration: new InputDecoration(
                                          prefixIcon: new Icon(Icons.search, color: Colors.white),
                                          hintText: "Search...",
                                          hintStyle: new TextStyle(color: Colors.white)
                                      ),
                                    );
                                    _handleSearchStart();
                                  }
                                  else {
                                    _handleSearchEnd();
                                  }
                                });
                              },
                            )),*/
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: _appConfig.rHP(14),
                      child: catgorylist.length == 0
                          ? Container(
                              child: Center(child: CircularProgressIndicator(  backgroundColor: Colors.tealAccent,
                                strokeWidth: 2.0,)),
                            )
                          : Container(
                        height: _appConfig.rHP(6.5),
                            width: double.infinity,

                            child: ListView(
                                /*    physics: NeverScrollableScrollPhysics(),*/
                                padding: EdgeInsets.fromLTRB(0,0,0,0),

                                shrinkWrap: true,

                                scrollDirection: Axis.horizontal,
                                children: List<Widget>.generate(

                                  catgorylist.length,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      widget.index =
                                          catgorylist[index].category_id;
                                      getsingleCatItem.clear();
                                      appbarname=catgorylist[index].category_name;
                                      getsubcatdaata();
                                      setState(() {});
                                    }

                                    /*Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => category_screen(
                                        ImageWithLabel(index,catgorylist),
                                        catgorylist[index].category_id)),
                              )*/
                                    ,
                                    child: ImageWithLabel(index, catgorylist),
                                  ),
                                ),
                              ),
                          ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: _appConfig.rHP(76),
            width: double.infinity,
            child: getsingleCatItem.length == 0
                ? Container(
                    child: Center(child: CircularProgressIndicator(  backgroundColor: Colors.tealAccent,
                      strokeWidth: 2.0,)),
                  )
                : subcatlist(),
          )
        ],
      ),
    );
  }

  /// sub cat listview

  Widget subcatlist() {
    return ListView.builder(
      itemCount: getsingleCatItem.length,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, position) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder<void>(
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return AnimatedBuilder(
                      animation: animation,
                      builder: (BuildContext context, Widget child) {
                        return DetailScreen(
                          heroTag: "klsejfksefjeo",
                          imageAsset: cardImageAsset(),
                          getsingleCatItem: getsingleCatItem[position],
                        );
                      }
                      );
                },
              ),
            );
          },
          child: Card(
            elevation: 2,
            shape: Border.all(color: Colors.grey, width: 0.7),
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
                                    new BorderRadius.all(Radius.circular(0)),
                                    border: new Border.all(color: Colors.black),



                               ),

                            child:FadeInImage.assetNetwork(
                              // here `bytes` is a Uint8List containing the bytes for the in-memory image
                              placeholder: "assets/loading.gif",

                              image: ( NetworkUtil.BASE_URL1 +
                                  getsingleCatItem[position].place_image
                              ),
                            )
                          /*Image.network(
                              NetworkUtil.BASE_URL1 +..........
                                  getsingleCatItem[position].place_image, height: _appConfig.rHP(10),
                              width: _appConfig.rWP(30),
                              fit: BoxFit.cover,
                            )*/
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Container(
                                    width: _appConfig.rW(39),
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      strutStyle: StrutStyle(fontSize: 12.0),
                                      text: TextSpan(
                                        style: TextStyle(color: Colors.black),
                                        text: getsingleCatItem[position]
                                            .place_name,
                                      ),
                                    ),

                                    /*        Text(
                                    getsingleCatItem[position].place_name,
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
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 17, 0, 0),
                                  child: Text(
                                    getsingleCatItem[position].place_status,
                                    style: TextStyle(
                                        color: Color(0xff42D59F), fontSize: 11),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: _appConfig.rHP(1),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/ic_location.png",
                                    height: 25,
                                    width: 25,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: _appConfig.rWP(40),
                                    child: Text(
                                      getsingleCatItem[position].place_city,
                                      style: TextStyle(color: Colors.grey),
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
                              padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: _appConfig.rHP(4),
                                    height: _appConfig.rHP(4),
                                    decoration: new BoxDecoration(
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(30)),
                                      gradient: new LinearGradient(
                                          colors: [
                                            Theme.Colors.thirdGradientStart,
                                            Theme.Colors.thirdGradientEnd
                                          ],
                                          begin:
                                              const FractionalOffset(0.0, 0.0),
                                          end: const FractionalOffset(1.0, 1.0),
                                          stops: [0.0, 1.0],
                                          tileMode: TileMode.clamp),
                                    ),
                                    child: Center(
                                      child: Text(
                                        getsingleCatItem[position]
                                            .rate
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: _appConfig.rWP(2.5),
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
                                          EdgeInsets.symmetric(horizontal: 0),
                                      rating: double.parse(getsingleCatItem[position]
                                          .rate),
                                      itemBuilder: (context, index) => Icon(
                                        _selectedIcon ?? Icons.star,
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
                              margin: prefix0.EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: _appConfig.rWP(17),
                                    height: _appConfig.rHP(4.3),
                                    decoration: new BoxDecoration(
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(30)),
                                      gradient: new LinearGradient(
                                          colors: [
                                            Theme.Colors.locationGradientStart,
                                            Theme.Colors.locationGradientEnd
                                          ],
                                          begin:
                                              const FractionalOffset(0.0, 0.0),
                                          end: const FractionalOffset(1.0, 1.0),
                                          stops: [0.0, 1.0],
                                          tileMode: TileMode.clamp),
                                    ),
                                    child: Center(
                                        child: Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Row(
                                        children: <Widget>[
                                          Image.asset(
                                            "assets/locationkm.png",
                                            height: _appConfig.rHP(5),
                                            width: _appConfig.rWP(5),
                                          ),
                                          SizedBox(
                                            width: _appConfig.rWP(1),
                                          ),
                                          Container(
                                            width: _appConfig.rWP(7),
                                            child: Text(
                                              getsingleCatItem[position]
                                                  .distance,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: _appConfig.rW(2.5),
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ),
                                  SizedBox(
                                    width: _appConfig.rWP(2),
                                  ),
                                  getsingleCatItem[position].place_phone == ""
                                      ? Container()
                                      : Container(
                                          width: _appConfig.rWP(35),
                                          height: _appConfig.rHP(4.3),
                                          decoration: new BoxDecoration(
                                            borderRadius: new BorderRadius.all(
                                                Radius.circular(30)),
                                            gradient: new LinearGradient(
                                                colors: [
                                                  Theme.Colors
                                                      .firstGradientStart,
                                                  Theme.Colors.firstGradientEnd
                                                ],
                                                begin: const FractionalOffset(
                                                    0.0, 0.0),
                                                end: const FractionalOffset(
                                                    1.0, 1.0),
                                                stops: [0.0, 1.0],
                                                tileMode: TileMode.clamp),
                                          ),
                                          child: Center(
                                              child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 0, 0, 0),
                                            child: Row(
                                              children: <Widget>[
                                                Image.asset(
                                                  "assets/call.png",
                                                  height: _appConfig.rHP(5),
                                                  width: _appConfig.rWP(5),
                                                ),
                                                SizedBox(
                                                  width: _appConfig.rWP(2),
                                                ),
                                                Text(
                                                  getsingleCatItem[position]
                                                      .place_phone,
                                                  style: TextStyle(
                                                      fontSize:
                                                          _appConfig.rWP(3),
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          )),
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
    );
  }

  cardImageAsset() {}
}

class ImageWithLabel extends StatelessWidget {
  ImageWithLabel(this.index, this.catgorylist);

  final int index;
  List<GetCatItem> catgorylist = new List();

  @override
  Widget build(BuildContext context) => Container(
        width: _appConfig.rWP(28),
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
                      Image.network(
                        NetworkUtil.BASE_URL1 +
                            catgorylist[index].category_image,
                        height: 50,
                      ),
                      SizedBox(
                        height: _appConfig.rHP(1),
                      ),
                      Text(catgorylist[index].category_name,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Lato')),
                    ],
                  )),
            ),
          ),
        ),
      );
}
