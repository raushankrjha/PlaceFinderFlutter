import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_app/Screen/fabbottom.dart';
import 'package:flutter_app/Screen/famousePlace_screen.dart';
import 'package:flutter_app/Screen/favorite_screen.dart';
import 'package:flutter_app/Screen/home.dart';
import 'package:flutter_app/Screen/home.dart' as prefix1;
import 'package:flutter_app/Screen/nearby_place.dart';
import 'package:flutter_app/Screen/settings_screen.dart';
import 'package:flutter_app/Utils/AppConfig.dart';
import 'package:flutter_app/Screen/theme.dart' as Theme;
import 'package:flutter_app/Screen/category_screen.dart';
import 'package:flutter_app/fetchdataapi/Model/Getcategory.dart';
import 'package:flutter_app/fetchdataapi/NetwrokUtils.dart';

class main_screen extends StatefulWidget {
  @override
  _main_screenState createState() => _main_screenState();
}

AppConfig _appConfig;

class _main_screenState extends State<main_screen> {
  final fabc = 0xFFffb3b3;
  String _lastSelected = 'TAB: 0';
  int currentIndex = 0;

  void _selectedTab(int index) {

      setState(() {
        currentIndex = index;
        navigatorKeys[0].currentState.pushReplacement(
            MaterialPageRoute(builder: (context) => screens[index]));
      });
  }

  // Main_screen({Key key}) : super(key: key);
  NetworkUtil networkUtil;

  List<Widget> screens = [];
  List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void screensPop() {
    if (currentIndex == 0) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Do you want to exit?"),
              actions: <Widget>[
                FlatButton(
                  child: new Text(
                    "Cancel",
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: new Text(
                    "Ok",
                  ),
                  onPressed: () {
                    exit(0);
                  },
                ),
              ],
            );
          });
    } else {
      setState(() {
        currentIndex = 2;
      });
      navigatorKeys[0].currentState.pushReplacement(
          MaterialPageRoute(builder: (context) => screens[currentIndex]));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    networkUtil = new NetworkUtil();
/*
    screens.add(nearby_place());
    screens.add(famousePlace_screen());*/
    screens.add(favorite_screen(context));

    screens.add(settings_screen());
    screens.add(home(context));
    screens = screens
        .map((screen) => WillPopScope(
              onWillPop: () {
                screensPop();
              },
              child: screen,
            ))
        .toList();
  }

  Navigator createScreen(int index, Widget screen) {
    return Navigator(
      key: navigatorKeys[index],
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            print("2");
            // Assume CollectPersonalInfoPage collects personal info and then
            // navigates to 'siComgnup/choose_credentials'.
            builder = (BuildContext _) => screen;
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(
          builder: builder,
          settings: settings,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = new AppConfig(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: WillPopScope(
        onWillPop: () {
          if (navigatorKeys[0].currentState.canPop())
            navigatorKeys[0].currentState.maybePop();
          else {
            screensPop();
          }
        },
        child: createScreen(0, screens[2]),
      ),
      bottomNavigationBar: FABBottomAppBar(
        color: Color(0xff4CB8C4),
        selectedColor: Colors.indigo,
        centerItemText: "Home",
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        /* items: [
          FABBottomAppBarItem(
            iconData: Icons.location_on,
              text: 'This'
          ),
          FABBottomAppBarItem(iconData: Icons.school),
          FABBottomAppBarItem(iconData: Icons.favorite_border),
          FABBottomAppBarItem(iconData: Icons.settings),
        ],*/
        items: [
          /*FABBottomAppBarItem(iconData: "assets/nearby.png", text: 'Nearby'),
          FABBottomAppBarItem(iconData: "assets/famous.png", text: 'Famous'),*/

          FABBottomAppBarItem(
            iconData: "assets/fav.png",
            text: 'Favorite',
          ),
          FABBottomAppBarItem(
            iconData: "assets/ic_settings.png",
            text: 'Settings',
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
          focusColor: Colors.black,
          backgroundColor: Color(0xff4CB8C4),
          splashColor: Colors.blueAccent,
          onPressed: () {
            currentIndex=2;

                navigatorKeys[0].currentState.pushReplacement(
                    MaterialPageRoute(builder: (context) => screens[2]));
              },
          elevation: 0,
          child: Card(
            elevation: 0,
            borderOnForeground: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Container(
              width: _appConfig.rWP(21),
              height: _appConfig.rWP(21),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(25),
                color: Color(0xff4CB8C4),
                /*  gradient: new LinearGradient(
                    colors: [
                      Theme.Colors.signupGradientStart,
                      Theme.Colors.signupGradientEnd
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),*/
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.home,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          )),
    );
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
        height: _appConfig.rHP(18),
        width: _appConfig.rWP(30),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      images[index % images.length],
                      height: 50,
                    ),
                    Text(categories[index],
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Lato')),
                  ],
                )),
          ),
        ),
      );
}
