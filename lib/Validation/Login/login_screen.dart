/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';*/
import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/AppConfig.dart';
import 'package:flutter_app/Utils/Dialogs.dart';
import 'package:flutter_app/Validation/Signup/signup_screen.dart';
import 'package:flutter_app/fetchdataapi/Model/RegisterMaps.dart';
import 'package:flutter_app/fetchdataapi/Model/RegisterModel.dart';
import 'package:flutter_app/fetchdataapi/NetwrokUtils.dart';
import 'package:flutter_app/fetchdataapi/SignupModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_app/Screen/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth _fAuth = FirebaseAuth.instance;



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

//  NetworkUtil _networkUtil;
  bool submitting = false;
  bool _autoValidate = false;
  SharedPreferences sharedPreferences;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<FirebaseUser> signIn(BuildContext context) async {

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

    submitgooglefb(user.email, user.displayName,user.photoUrl);

    return user;
  }

  Future<FirebaseUser> signInWithGoogle(BuildContext context) async {
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

    submitgooglefb(user.email, user.displayName,user.photoUrl);

    return user;
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  void signOutGoogle() async {

    await googleSignIn.signOut();
    print("User Sign Out");
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
   Future<Null> _signOut(BuildContext context) async {
    await facebookSignIn.logOut();
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('Sign out button clicked'),
    ));
    print('Signed out');
  }
  String name;
  String imgurl;
  String token = "hjnhjghjghjgh";
  NetworkUtil networkUtil;

  /* String _homeScreenText = "Waiting for token...";*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    networkUtil = new NetworkUtil();
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
  }
  String _homeScreenText = "Waiting for token...";




  void listenForRecentadd() async {

        await networkUtil.postlogin(_username.text, _password.text,"0");

if(RegisterMaps.list.length==0) {
  return;


}
    registers=RegisterMaps.list[0];





    AppConfig.userid=registers.id;

//    files.addAll(search.list);
//    setState(() {});
  }

  Future _validateInputs() async {

    Dialogs.showLoadingDialog(context, _keyLoader);
    if (_username.text.isEmpty && _password.text.isEmpty) {
      return Fluttertoast.showToast(
          msg: "Enter Email and Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    if (_validateEmail(_username.text) != null) {
      return Fluttertoast.showToast(
          msg: "Enter Valide Email ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    if (_validatepassword(_password.text) != null) {
      return Fluttertoast.showToast(
          msg: "Enter Valide  Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);
    }


    await  listenForRecentadd();





if(registers==null)
  {
    Navigator.pop(context);

    return Fluttertoast.showToast(
        msg: "Unregister User!!!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.teal,
        textColor: Colors.white,
        fontSize: 16.0);


  }



      await      _onChanged();


  }

  _onChanged() async {


    AppConfig.userid=registers.id;
    sharedPreferences = await SharedPreferences.getInstance();

      sharedPreferences.setString("setuserid", RegisterMaps.list[0].id.toString());
      sharedPreferences.setBool("isfirst", false);
      sharedPreferences.setString("name", RegisterMaps.list[0].name);
      sharedPreferences.setString("password", RegisterMaps.list[0].password);
      sharedPreferences.setString("email", RegisterMaps.list[0].email);
      sharedPreferences.setString("pnumber", RegisterMaps.list[0].phone);
      sharedPreferences.commit();

    Navigator.pop(context);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => main_screen()));







  }
  RegisterModel registers;
  String _base64;


  void submitgooglefb(String email, String name,String url) async {

    print(url);

    http.Response response = await http.get(
      url,
    );
    if (mounted) {

      _base64 =await base64.encode(response.bodyBytes);

    }


    print(_base64);
    await networkUtil.postloginfb(email, "1").then((value) {
    });
    registers = RegisterMaps.list[0];






    setState(() {
      print(registers.email);
    });



//    registers = NetworkUtil.rregisters;


    await _onChanged();






  }


  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

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
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return 'Email is not valid';
  }

  String _validatepassword(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter Password ";
    }

/*
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
  }*/
  }

  AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = new AppConfig(context);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        key: _keyLoader,
        body: Container(
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
              SizedBox(
                height: _appConfig.rHP(2),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  height: _appConfig.rHP(7),
                  child: TextFormField(
                    validator: _validateEmail,
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
                      hintText: 'Email',
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
                height: _appConfig.rH(3),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  height: _appConfig.rHP(7),
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: _password,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff20B196), width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff20B196), width: 1.0),
                        ),
                        hintText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        )
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _appConfig.rHP(3),
              ),
           /*   Container(
                margin: const EdgeInsets.only(right: 40.0),
                alignment: Alignment.topRight,
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: Color(0xff20B196), fontSize: 16),
                ),
              ),*/
              SizedBox(
                height: _appConfig.rHP(3),
              ),
              GestureDetector(
                /*onTap: () => submit(),*/
                child: Center(
                  child: GestureDetector(
                    onTap: () => _validateInputs(),
                    child: Container(
                      width: _appConfig.rW(90),
                      child: Image.asset(
                        "assets/log_in_btn.png",
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _appConfig.rHP(10),
              ),
//              Container(
//                width: double.infinity,
//                child: Text(
//                  "or Login with",
//                  style: TextStyle(color: Colors.grey, fontSize: 17),
//                  textAlign: TextAlign.center,
//                ),
//              ),
//              SizedBox(
//                height: _appConfig.rHP(5),
//              ),
//              Container(
//                width: double.infinity,
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    GestureDetector(
//                      onTap: () => signIn(context),
//                      child: Container(
//                          margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
//                          child: Image.asset(
//                            "assets/ic_fb.png",
//                            width: 50,
//                            height: 50,
//                            fit: BoxFit.fill,
//                          )),
//                    ),
//                    Container(
//                      width: 1,
//                      height: 55,
//                      color: Colors.white,
//                    ),
//                    GestureDetector(
//                      onTap: () => signInWithGoogle(context),
//                      child: Container(
//                          margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
//                          child: Image.asset(
//                            "assets/ic_google.png",
//                            width: 50,
//                            height: 50,
//                            fit: BoxFit.fill,
//                          )),
//                    ),
//                  ],
//                ),
//              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new Signup(),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Dont have an account yet? ",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontFamily: 'Righteous'),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "assets/sign_up.png",
                        height: 100,
                        width: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
