/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';*/
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Screen/main_screen.dart';
import 'package:flutter_app/Utils/AppConfig.dart';
import 'package:flutter_app/Utils/Dialogs.dart';
import 'package:flutter_app/Validation/Login/login_screen.dart';
import 'package:flutter_app/fetchdataapi/Model/RegisterMaps.dart';
import 'package:flutter_app/fetchdataapi/NetwrokUtils.dart';
import 'package:flutter_app/fetchdataapi/NetwrokUtils.dart' as prefix0;
import 'package:flutter_app/fetchdataapi/SignupModel.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:flutter_html/flutter_html.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:musicapp/fetchdataapi/Model/Getcategory.dart';
//import 'package:musicapp/fetchdataapi/NetwrokUtils.dart';
//import 'package:musicapp/ui/login/login.dart';

/*import 'package:musicapp/utils/Dialogs.dart';*/
import 'package:http/http.dart' as http;
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth _fAuth = FirebaseAuth.instance;



class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  double _destLatitude = 21.2378788, _destLongitude = 72.8633633;
  String googleAPiKey = "Your api key";
  StreamSubscription<LocationData> _locationSubscription;
  CameraPosition _currentCameraPosition;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  GoogleMap googleMap;
  Completer<GoogleMapController> _controller = Completer();
  Location _locationService  = new Location();
  bool _permission = false;
  String error;
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  bool currentWidget = true;
  LocationData _startLocation;
  LocationData _currentLocation;
  String name;
  String imgurl;
/*
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();*/
  String token = "";
  String profile_pic="";
  String user_lat="";
  String user_long="";
  String city="";
  String address="";

  String _homeScreenText = "Waiting for token...";
  @override

  String _base64;
  void submitgooglefb(String email, String name, String url) async {



    http.Response response = await http.get(
      url,
    );
    if (mounted) {
      _base64 = await base64.encode(response.bodyBytes);
    }

    print(_base64);
    await networkUtil
        .postregisterfb(email, "", token, _base64, name,"1",user_lat,user_long,address,city)
        .then((value) {});
      registers =prefix0.NetworkUtil.results.userlist[0];;
    setState(() {
//      print(registers.user_email);
    });

    await _onChanged();

  }




  final GlobalKey<State> _keyLoader = new GlobalKey<State>();


  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }


  _addPolyLine()
  {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red, points: polylineCoordinates
    );
    polylines[id] = polyline;
    setState(() {
    });
  }
  _getPolyline()async
  {
    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(googleAPiKey,
        _originLatitude, _originLongitude, _destLatitude, _destLongitude);
    if(result.isNotEmpty){
      result.forEach((PointLatLng point){
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
  @override
  void initState() {
    super.initState();
    networkUtil = new prefix0.NetworkUtil();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        this.token = token;
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
    });

    initPlatformState();
    slowRefresh();
  }

  prefix0.NetworkUtil networkUtil;
  slowRefresh() async {
//    _locationSubscription.cancel();
    await _locationService.changeSettings(accuracy: LocationAccuracy.BALANCED, interval: 10000);
    _locationSubscription = _locationService.onLocationChanged().listen((LocationData result) async {

      _originLatitude=result.latitude;
      _originLongitude=result.longitude;
      user_lat=_originLatitude.toString();
      user_long=_originLongitude.toString();

      final coordinates = new Coordinates(_originLatitude, _originLongitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);

      address =await addresses.first.addressLine.toString();
      city=await addresses.first.locality.toString();




      print("sdddddddddddddddd: $user_lat"+address+city+user_long);
      if(mounted){
        setState(() {
          _currentLocation = result;
        });
      }
    });
  }
  GetRegisters registers;
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
          location = await _locationService.getLocation();

          _locationSubscription = _locationService.onLocationChanged().listen((LocationData result) async {
            _currentCameraPosition = CameraPosition(
                target: LatLng(result.latitude, result.longitude),
                zoom: 16
            );

            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(_currentCameraPosition));

            _originLatitude=result.latitude;
            _originLongitude=result.longitude;
            user_lat=await _originLatitude.toString();
            user_long=await _originLongitude.toString();

            print("sdddddddddddddddd: $user_lat");
            final coordinates = new Coordinates(_originLatitude, _originLongitude);
            var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);

            address =await addresses.first.toString();
            city=await addresses.first.locality.toString();


            if(mounted){
              setState(() {
                _currentLocation = result;


              });
            }
          }
          );
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

    setState(() {
      _startLocation = location;
    });

  }



  AppConfig _appConfig;
  SharedPreferences sharedPreferences;
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _useremail = TextEditingController();
  TextEditingController _phno = TextEditingController();

  bool submitting = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String _validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter email address";
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return "";
    }

    // The pattern of the email didn't match the regex above.
    return 'Email is not valid';
  }

  Future _validateInputs() async {

    if(_username.text=="")
    {
      return  Fluttertoast.showToast(
          msg: "Enter UserName",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    if(_validateEmail(_useremail.text)!="")
    {
      return  Fluttertoast.showToast(
          msg: "Enter Valid Email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    if(_password.text=="")
    {
      return  Fluttertoast.showToast(
          msg: "Enter Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    if(_phno.text=="")
    {
      return  Fluttertoast.showToast(
          msg: "Enter Phone Number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }


    setState(() {
      submitting = true;
    });
    await submit();


      listenForRecentadd();
//  print('file size===========$files.length');

      //

    return CircularProgressIndicator(
      backgroundColor: Colors.tealAccent,
      strokeWidth: 2.0,
    );
  }
  void submit() async {

    Dialogs.showLoadingDialog(context, _keyLoader);
    ByteData audioByteData = await rootBundle.load('assets/profile.png');

//    Uint8List byte = bytes.buffer;

//    String audioString = base64.encoder.;
    Uint8List audioUint8List = audioByteData.buffer.asUint8List(audioByteData.offsetInBytes, audioByteData.lengthInBytes);
    List<int> audioListInt = audioUint8List.cast<int>();
//    List<int> test = bytes.;



    _base64 = await base64.encode(audioListInt);





     //inv
    await networkUtil
        .postregister(_useremail.text, _password.text, token, _phno.text,
        _username.text,user_lat,user_long,address,city,_base64)
        .then((value) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    });
    registers = prefix0.NetworkUtil.results.userlist[0];
    print(registers.user_email);
    await _onChanged();

  }



  Future<FirebaseUser> signIn(BuildContext context) async {

    Dialogs.showLoadingDialog(context, _keyLoader);



    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    FacebookAccessToken myToken = result.accessToken;

    ///assuming sucess in FacebookLoginStatus.loggedIn
    /// we use FacebookAuthProvider class to get a credential from accessToken
    /// this will return an AuthCredential object that we will use to auth in firebase
    AuthCredential credential =
    FacebookAuthProvider.getCredential(accessToken: myToken.token);

// this line do auth in firebase with your facebook credential.
    FirebaseUser user = (await _fAuth.signInWithCredential(credential)).user;

    //Token: ${accessToken.token}

    submitgooglefb(user.email, user.displayName, user.photoUrl);

    return user;
  }

  Future<FirebaseUser> signInWithGoogle(BuildContext context) async {

    Dialogs.showLoadingDialog(context, _keyLoader);
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    submitgooglefb(user.email, user.displayName, user.photoUrl);

    return user;
  }

  _onChanged() async {



    AppConfig.userid=registers.user_id;
    sharedPreferences = await SharedPreferences.getInstance();

      sharedPreferences.setString("setuserid", registers.user_id);
      sharedPreferences.setBool("isfirst", false);
      sharedPreferences.setString("name", _username.text);
      sharedPreferences.setString("password", _password.text);
      sharedPreferences.setString("email", _useremail.text);
      sharedPreferences.setString("pnumber",_phno.text);
      sharedPreferences.setString("user_notification_status",registers.user_notification_status);
      sharedPreferences.commit();

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => main_screen()));

  }
  var search;

  void listenForRecentadd() async {

  //  search = await _networkUtil.postregister(_username.text,_phno.text,_useremail.text,_password.text, token,profile_pic,user_lat,user_long,city,address);
//    files.addAll(search.list);
//    setState(() {});
  }

//  prefix0.NetworkUtil _networkUtil;
  @override
  Widget build(BuildContext context) {

    _appConfig = new AppConfig(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/loginscreen.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: _appConfig.rH(6),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  width: _appConfig.rWP(55),
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    "assets/PlaceFinder.png",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  height: _appConfig.rHP(10),
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Sign in to continue",
                        style: TextStyle(
                            fontSize: _appConfig.rWP(4),
                            color: Colors.white,
                            fontFamily: 'Righteous'),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: _appConfig.rHP(3),
                  width: double.infinity,
                ),
                /* Container(
                  width: double.infinity,
                  child: Image.asset(
                    "assets/banner.png",
                    width: double.infinity,
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    height: _appConfig.rHP(7),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        decorationColor: Colors.white,
                        fontFamily: 'Montserrat',
                      ),

                      controller: _username,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff20B196), width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff20B196), width: 1.0),
                        ),
                        hintText: 'Name',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _appConfig.rH(2),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    height: _appConfig.rHP(7),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        decorationColor: Colors.white,
                        fontFamily: 'Montserrat',
                      ),

                      controller: _useremail,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff20B196), width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff20B196), width: 1.0),
                        ),
                        hintText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _appConfig.rH(2),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    height: _appConfig.rHP(7),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        decorationColor: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                      obscureText: true,
                      controller: _password,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff20B196), width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff20B196), width: 1.0),
                        ),
                        hintText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _appConfig.rH(2),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    height: _appConfig.rHP(7),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        decorationColor: Colors.white,
                        fontFamily: 'Montserrat',
                      ),

                      controller: _phno,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff20B196), width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff20B196), width: 1.0),
                        ),
                        hintText: 'Phone',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _appConfig.rHP(5),
                ),
                GestureDetector(
//                onTap: () => submit(),

                  onTap: () => _validateInputs(),
                  child: Center(
                    child: Container(
                      width: _appConfig.rW(90),
                      child: Image.asset(
                        "assets/register.png",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _appConfig.rHP(4),
                ),
//                Container(
//                  width: double.infinity,
//                  child: Text(
//                    "or signup with",
//                    style: TextStyle(color: Colors.white70, fontSize: 17),
//                    textAlign: TextAlign.center,
//                  ),
//                ),
//                SizedBox(
//                  height: _appConfig.rHP(4),
//                ),
//                Container(
//                  width: double.infinity,
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      GestureDetector(
//                        onTap: ()=>signIn(context),
//                        child: Container(
//                            margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
//                            child: Image.asset(
//                              "assets/ic_fb.png",
//                              width: 50,
//                              height: 50,
//                              fit: BoxFit.fill,
//                            )),
//                      ),
//                      Container(
//                        width: 1,
//                        height: 55,
//                        color: Colors.white,
//                      ),
//                      GestureDetector(
//                        onTap: () => signInWithGoogle(context),
//                        child: Container(
//                            margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
//                            child: Image.asset(
//                              "assets/ic_google.png",
//                              width: 50,
//                              height: 50,
//                              fit: BoxFit.fill,
//                            )),
//                      ),
//                    ],
//                  ),
//                ),
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new Login(),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontFamily: 'Righteous'),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: _appConfig.rHP(2),
                        ),
                        Image.asset(
                          "assets/log_in.png",
                          height: _appConfig.rHP(10),
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

 }

