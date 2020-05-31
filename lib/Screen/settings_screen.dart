import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:flutter_app/Screen/home.dart';
import 'package:flutter_app/Screen/profile.dart';
//import 'package:flutter_app/Screen/profile.dart';
import 'package:flutter_app/Utils/AppConfig.dart';
/*import 'package:flutter_app/Widgets/flutter_seekbar.dart'
    show SectionTextModel, SeekBar;*/
import 'package:flutter_app/Validation/Login/login_screen.dart';
import 'package:flutter_app/Widgets/seekbar/seekbar.dart';
import 'package:flutter_app/fetchdataapi/NetwrokUtils.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:flutter_app/Screen/theme.dart' as Theme;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

//final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//    FlutterLocalNotificationsPlugin();



class settings_screen extends StatefulWidget {
  @override
  _settings_screenState createState() => _settings_screenState();
}

AppConfig _appConfig;

class _settings_screenState extends State<settings_screen> {
  final MethodChannel _channel = const MethodChannel('flutter_share_me');
  var value;
  bool isExpanded = false;
  bool isSwitched = true;
  int vau = int.parse(AppConfig.distcance);
  NetworkUtil networkUtil;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onChanged();

    networkUtil = new NetworkUtil();
  }
  SharedPreferences sharedPreferences;
 String user_notification_status="true";

  _onChanged() async {
//    AppConfig.userid=registers.user_id;
    sharedPreferences = await SharedPreferences.getInstance();


    user_notification_status=  sharedPreferences.getString("user_notification_status");



    if(user_notification_status=="true")
      {
        isSwitched=true;
      }else
        {
          isSwitched=false;
        }

    setState(() {

    });
  }


  _onset(bool value) async {
//    AppConfig.userid=registers.user_id;
    sharedPreferences = await SharedPreferences.getInstance();






    if(isSwitched)
    {
      sharedPreferences.setString("user_notification_status","true");
      getprofiledata("ENABLE");
    }else
    {
      sharedPreferences.setString("user_notification_status","false");
      getprofiledata("DISABLE");
    }
    sharedPreferences.commit();



    setState(() {

    });
  }


  void getprofiledata(user_notification) async {
    await networkUtil.setnotification(user_notification);

//    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    YYDialog.init(context);
    _appConfig = new AppConfig(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_appConfig.rHP(7)),
        child: Container(
          height: _appConfig.rHP(12),
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
              title: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Center(
                  child: Container(
                    height: _appConfig.rHP(6.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            'Settings',
                            style: TextStyle(
                                fontSize: _appConfig.rHP(3),
                                fontFamily: 'LatoBold'),
                          ),
                        ),
                     /*   Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: GestureDetector(

                            onTap: (){



                            },
                            child: Container(
                              height: _appConfig.rHP(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/ic_logout.png",
                                    height: _appConfig.rHP(5),
                                    width: _appConfig.rWP(6),
                                  ),
                                  Text(
                                    "Log Out",
                                    style: TextStyle(fontSize: 8),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )*/
                      ],
                    ),
                  ),
                ),
              ),
              leading: Container(
                child: IconButton(
                  icon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => home(context)));
                        },
                        child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                  ),
                  /* onPressed: () => Navigator.pop(context, false),*/
                ),
              )),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
              child: Container(
                height: _appConfig.rHP(10),
                width: _appConfig.rWP(90),
                child: Card(
                  child: Row(
                    mainAxisAlignment: prefix0.MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: _appConfig.rWP(3),
                      ),
                      Container(
                        width: _appConfig.rHP(5),
                        height: _appConfig.rHP(5),

                        child: Center(
                          child: Image.asset(
                            "assets/ic_profile1.png",
                            height: _appConfig.rHP(4.7),
                            width: _appConfig.rHP(4.7),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: _appConfig.rWP(5),
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(fontFamily: 'LatoMedium'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: _appConfig.rHP(1),
          ),
          /*Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    "Max. Distance",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text('$vau km',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          ),*/
         /* Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                    width: 280,
                    child: SeekBar(
                      progresseight: 6,
                      progressColor: Color(0xFF3CD3AD),
                      value: vau.toDouble(),
                      bubbleHeight: 50,
                      indicatorColor: Colors.teal,
                      backgroundColor: Color(0xFFdbe9e9),
                      sectionRadius: 2,

//                      min: 15,

                      onValueChanged: (value) {
                        setState(() {
                          vau = value.value.toInt();
                        });
                      },
                    )),
              ],
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: _appConfig.rHP(10),
                width: _appConfig.rWP(90),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: prefix0.MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: _appConfig.rHP(5),
                          height: _appConfig.rHP(5),
                          decoration: new BoxDecoration(
                            borderRadius:
                                new BorderRadius.all(Radius.circular(30)),
                            gradient: new LinearGradient(
                                colors: [
                                  Theme.Colors.headerGradientStart,
                                  Theme.Colors.headerGradientEnd
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 1.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          "Enable Push Notification",
                          style: TextStyle(fontFamily: 'LatoMedium'),
                        ),
                        SizedBox(
                          width: _appConfig.rWP(10),
                        ),
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            isSwitched = value;

                            _onset(isSwitched);
                            setState(() {
                              if (isSwitched) {
//                                _scheduleNotification();
                                print("bjbjh");
                              } else {
//                                _cancelNotification();
                              }
                            });
                          },
                          activeTrackColor: Color(0xff3CD3AD),
                          activeColor: Colors.teal,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: _appConfig.rHP(1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 0, 5),
                child: Text(
                  "About Us",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(
            height: _appConfig.rHP(1),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: GestureDetector(
              child: Container(
                height: _appConfig.rHP(10),
                width: _appConfig.rWP(90),
                child: Card(
                  child: Row(
                    mainAxisAlignment: prefix0.MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: _appConfig.rWP(3),
                      ),
                      Container(
                        width: _appConfig.rHP(5),
                        height: _appConfig.rHP(5),
                        decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(Radius.circular(30)),
                          gradient: new LinearGradient(
                              colors: [
                                Theme.Colors.headerGradientStart,
                                Theme.Colors.headerGradientEnd
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: Center(
                            child: Icon(
                          Icons.content_paste,
                          color: Colors.white,
                        )),
                      ),
                      SizedBox(
                        width: _appConfig.rWP(5),
                      ),
                      Text(
                        "Terms of Service",
                        style: TextStyle(fontFamily: 'LatoMedium'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: _appConfig.rHP(1),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: GestureDetector(
              onTap: () {
                Future<String> shareToSystem({String msg}) async {
                  Map<String, Object> arguments = Map<String, dynamic>();
                  arguments.putIfAbsent('msg', () => msg);
                  dynamic result;
                  try {
                    result =
                        await _channel.invokeMethod('system', {'msg': msg});
                  } catch (e) {
                    return "false";
                  }
                  return result;
                }
              },
              child: Container(
                height: _appConfig.rHP(10),
                width: _appConfig.rWP(90),
                child: Card(
                  child: Row(
                    mainAxisAlignment: prefix0.MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: _appConfig.rWP(3),
                      ),
                      Container(
                        width: _appConfig.rHP(5),
                        height: _appConfig.rHP(5),
                        decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(Radius.circular(30)),
                          gradient: new LinearGradient(
                              colors: [
                                Theme.Colors.headerGradientStart,
                                Theme.Colors.headerGradientEnd
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: Center(
                            child: Icon(
                          Icons.contacts,
                          color: Colors.white,
                        )),
                      ),
                      SizedBox(
                        width: _appConfig.rWP(5),
                      ),
                      Text(
                        "Contact Us",
                        style: TextStyle(fontFamily: 'LatoMedium'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: _appConfig.rHP(1),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: GestureDetector(
              child: Container(
                height: _appConfig.rHP(10),
                width: _appConfig.rWP(90),
                child: Card(
                  child: Row(
                    mainAxisAlignment: prefix0.MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: _appConfig.rWP(3),
                      ),
                      Container(
                        width: _appConfig.rHP(5),
                        height: _appConfig.rHP(5),
                        decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(Radius.circular(30)),
                          gradient: new LinearGradient(
                              colors: [
                                Theme.Colors.headerGradientStart,
                                Theme.Colors.headerGradientEnd
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/ic_privacy.png",
                            height: _appConfig.rHP(5),
                            width: _appConfig.rWP(5),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: _appConfig.rWP(5),
                      ),
                      Text(
                        "Privacy Policy",
                        style: TextStyle(fontFamily: 'LatoMedium'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//  Future<void> _scheduleNotification() async {
//    var scheduledNotificationDateTime =
//        DateTime.now().add(Duration(seconds: 3));
//    var vibrationPattern = Int64List(4);
//    vibrationPattern[0] = 0;
//    vibrationPattern[1] = 1000;
//    vibrationPattern[2] = 5000;
//    vibrationPattern[3] = 2000;
//
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'your other channel id',
//        'your other channel name',
//        'your other channel description',
//        icon: 'secondary_icon',
//        sound: 'slow_spring_board',
//        largeIcon: 'sample_large_icon',
//        largeIconBitmapSource: BitmapSource.Drawable,
//        vibrationPattern: vibrationPattern,
//        enableLights: true,
//        color: const Color.fromARGB(255, 255, 0, 0),
//        ledColor: const Color.fromARGB(255, 255, 0, 0),
//        ledOnMs: 1000,
//        ledOffMs: 500);
//
//    var iOSPlatformChannelSpecifics =
//        IOSNotificationDetails(sound: "slow_spring_board.aiff");
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.schedule(
//        0,
//        'scheduled title',
//        'scheduled body',
//        scheduledNotificationDateTime,
//        platformChannelSpecifics);
//  }
//
//  Future<void> _cancelNotification() async {
//    await flutterLocalNotificationsPlugin.cancel(0);
//  }

  YYDialog YYAlertDialogWithCustomIn() {
    return YYDialog().build()
      ..width = _appConfig.rWP(70)
      ..height = _appConfig.rHP((150))
      ..height = _appConfig.rHP(40)
      ..borderRadius = 4.0
      ..duration = Duration(milliseconds: 500)
      ..animatedFunc = (child, animation) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..translate(
              0.0,
              Tween<double>(begin: -50.0, end: 50.0)
                  .animate(
                    CurvedAnimation(
                        curve: Interval(0.1, 0.5), parent: animation),
                  )
                  .value,
            )
            ..scale(
              Tween<double>(begin: 0.5, end: 1.0)
                  .animate(
                    CurvedAnimation(
                        curve: Interval(0.5, 0.9), parent: animation),
                  )
                  .value,
            ),
          child: child,
        );
      }
      ..text(
        padding: EdgeInsets.all(18.0),
        text: "Edit Profile",
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      )
      ..widget(Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Container(
          child: TextField(
            decoration: InputDecoration(hintText: "Edit name"),
          ),
        ),
      ))
      /*..text(
        padding: EdgeInsets.only(left: 18.0, right: 18.0),
        text: "Dialog body text",
        color: Colors.grey[500],
      )*/

      ..widget(Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Container(
          height: _appConfig.rHP(18),
          width: double.infinity,
          child: Center(
            child: Container(
              height: _appConfig.rHP(15),
              width: _appConfig.rHP(15),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/profile.png",
                ),
                child: Container(
                    child: Stack(
                  children: <Widget>[
                    _previewImage(),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // _onImageButtonPressed(ImageSource.gallery);
                        },
                        child: Container(
                          height: _appConfig.rHP(6.5),
                          width: _appConfig.rWP(8),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 15,
                                  spreadRadius: 0,
                                  offset: Offset(0.0, 16.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 1,
                        child: GestureDetector(
                          onTap: () {
                            _onImageButtonPressed(ImageSource.gallery);
                          },
                          child: Container(
                            height: _appConfig.rHP(6.5),
                            width: _appConfig.rWP(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  begin: FractionalOffset.bottomRight,
// Add one stop for each color. Stops should increase from 0 to 1
                                  stops: [
                                    0.3,
                                    1
                                  ],
                                  colors: [
                                    Color(0xff3CD3AD),
                                    Color(0xff4CB8C4),
                                  ]),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ))
                  ],
                )),
              ),
            ),
          ),
          /*       width: double.infinity,*/
        ),

        /*Container(
          height: _appConfig.rHP(12),
          width: _appConfig.rHP(12),

          child: CircleAvatar(

            backgroundImage: AssetImage("assets/profile.png"),

          ),
        ),*/
      ))
      ..doubleButton(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        gravity: Gravity.center,
        text1: "SAVE",
        onTap1: () {},
        color1: Colors.teal,
        fontSize1: 14.0,
        onTap2: () {},
        text2: "CANCEL",
        color2: Colors.teal,
        fontSize2: 14.0,
      )
      ..show();
  }

  bool ischange = false;
  File _imageFile;
  dynamic _pickImageError;

  void _onImageButtonPressed(ImageSource source) async {
    try {
      _imageFile = await ImagePicker.pickImage(source: source);

      setState(() {
        if (_imageFile != null) _cropImage(_imageFile);
        print("shjsdhsagjwe" + _imageFile.path);
        ischange = true;
      });
    } catch (e) {
      _pickImageError = e;
    }
  }

  String _retrieveDataError;

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      return Image.file(
        _imageFile,
        height: _appConfig.rWP(20),
        width: _appConfig.rWP(20),
        fit: BoxFit.fill,
      );
    } else if (_pickImageError != null) {
      return Text(
        '',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<Null> _cropImage(File imageFile) async {
    _imageFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        /* ratioX: 2.0,
      ratioY: 2.0,*/
        maxWidth: 512,
        maxHeight: 512,
        cropStyle: CropStyle.circle);
    setState(() {});
  }
}
