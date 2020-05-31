import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_app/Screen/home.dart';
import 'package:flutter_app/Screen/hotel_details/hotel_details_screen.dart';

import 'package:flutter_app/Screen/main_screen.dart';

import 'package:flutter_app/Utils/AppConfig.dart';
import 'package:flutter_app/Screen/theme.dart' as Theme;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: famousePlace_screen(),
      );
}

class famousePlace_screen extends StatefulWidget {
  @override
  _famousePlace_screenState createState() => _famousePlace_screenState();
}

AppConfig _appConfig;

class _famousePlace_screenState extends State<famousePlace_screen> {
  final fabc = 0xFFffb3b3;

  @override
  Widget build(BuildContext context) {
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
                'Famouse Place',
                style: prefix0.TextStyle(
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
              /*onPressed: () => Navigator.pop(context, false),*/
            )),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: _appConfig.rHP(83),
            width: double.infinity,
            child: ListView.builder(
              itemCount: 3,
              padding: EdgeInsets.all(0),
              itemBuilder: (context, position) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder<void>(
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return AnimatedBuilder(
                              animation: animation,
                              builder: (BuildContext context, Widget child) {
                                return DetailScreen(
                                  heroTag: "klsejfksefjeo",
                                  imageAsset: cardImageAsset(),
                                );
                              });
                        },
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    shape: Border.all(color: Colors.grey, width: 1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: _appConfig.rHP(20.5),
                            width: double.infinity,
                            child: Row(
                              children: <Widget>[
                                Container(
                                    height: _appConfig.rHP(20),
                                    width: _appConfig.rWP(35),
                                    child: Image.asset(
                                      "assets/hotel_bnner.jpg",
                                      fit: BoxFit.fill,
                                    )),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 0, 0),
                                          child: Container(
                                              child: Text(
                                            "Hotel Pacific ",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: _appConfig.rWP(4.5),
                                                fontWeight: FontWeight.w600),
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 17, 0, 0),
                                          child: Text(
                                            "OPEN",
                                            style: TextStyle(
                                                color: Color(0xff42D59F),
                                                fontSize: 11),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: _appConfig.rHP(1),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                                          Text(
                                            "location",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: _appConfig.rHP(1),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: _appConfig.rHP(4),
                                            height: _appConfig.rHP(4),
                                            decoration: new BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.all(
                                                      Radius.circular(30)),
                                              gradient: new LinearGradient(
                                                  colors: [
                                                    Theme.Colors
                                                        .thirdGradientStart,
                                                    Theme
                                                        .Colors.thirdGradientEnd
                                                  ],
                                                  begin: const FractionalOffset(
                                                      0.0, 0.0),
                                                  end: const FractionalOffset(
                                                      1.0, 1.0),
                                                  stops: [0.0, 1.0],
                                                  tileMode: TileMode.clamp),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "5.2",
                                                style: TextStyle(
                                                    fontSize:
                                                        _appConfig.rWP(2.5),
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: _appConfig.rHP(1),
                                          ),
                                          Icon(Icons.star_border),
                                          Icon(Icons.star_border),
                                          Icon(Icons.star_border),
                                          Icon(Icons.star_border),
                                          Icon(Icons.star_border),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: _appConfig.rHP(1.5),
                                    ),
                                    Container(
                                      margin: prefix0.EdgeInsets.fromLTRB(
                                          5, 0, 0, 0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: _appConfig.rWP(35),
                                            height: _appConfig.rHP(4.3),
                                            decoration: new BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.all(
                                                      Radius.circular(30)),
                                              gradient: new LinearGradient(
                                                  colors: [
                                                    Theme.Colors
                                                        .firstGradientStart,
                                                    Theme
                                                        .Colors.firstGradientEnd
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
                                                    "1234567890",
                                                    style: TextStyle(
                                                        fontSize:
                                                            _appConfig.rWP(3),
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ),
                                          SizedBox(
                                            width: _appConfig.rWP(2),
                                          ),
                                          Container(
                                            width: _appConfig.rWP(17),
                                            height: _appConfig.rHP(4.3),
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
                                                  10, 0, 0, 0),
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
                                                  Text(
                                                    "5KM",
                                                    style: TextStyle(
                                                        fontSize:
                                                            _appConfig.rW(2.5),
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
            ),
          )
        ],
      ),
    );
  }

  cardImageAsset() {}
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
