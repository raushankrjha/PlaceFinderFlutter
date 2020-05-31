import 'dart:async';
//import 'dart:html';

//import 'package:beer_list/Utils/network_util.dart';
//import 'package:beer_list/screens/home.dart';

import 'package:flutter/material.dart';

import 'package:flutter_app/Screen/main_screen.dart';
import 'package:flutter_app/Utils/AppConfig.dart';
import 'package:flutter_app/Validation/Login/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:beer_list/screens/login.dart';
//import 'package:shared_preferences/shared_preferences.dart';

// This is the Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*_animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 10));
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );*/


    _onChanged();
    initPlatformState();





  }



  Future tos()
  {
    return Fluttertoast.showToast(
        msg: "Please Allow GPS",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.teal,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  bool _permission = false;
  Location _locationService  = new Location();
  initPlatformState() async {
    await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {

        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if(serviceStatusResult){
          initPlatformState();
        }
      }
    } on Exception catch (e) {
      print(e);

      location = null;
    }
    if(_permission) {
      Timer(Duration(milliseconds: 5000), () {
        if (isfirst == null) {
          isfirst = true;
        } else {
          isfirst = false;
        }
        if (!isfirst) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => main_screen()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
          _onChanged();
        }

        /*    Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => main_screen()),
          ModalRoute.withName("/Register"));*/
      });
    }else{

      tos();
      return;
    }


  }



  bool isfirst = true;
  SharedPreferences sharedPreferences;
  String userid;
  _onChanged() async {
    sharedPreferences = await SharedPreferences.getInstance();
    isfirst = sharedPreferences.getBool("isfirst");
    AppConfig.userid = sharedPreferences.getString("setuserid");


  }
  @override
  Widget build(BuildContext context) {
//    getCredential();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
              child: Image.asset(
            'assets/splashscreen.png',
            fit: BoxFit.cover,
          )),
        ],
      ),
    );
  }
}
