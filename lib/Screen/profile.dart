import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:flutter_app/Screen/home.dart';
import 'package:flutter_app/Screen/settings_screen.dart';
import 'package:flutter_app/Utils/AppConfig.dart';
import 'package:flutter_app/Validation/Login/login_screen.dart';
import 'package:flutter_app/Validation/Signup/signup_screen.dart';
import 'package:flutter_app/fetchdataapi/Model/profileedit.dart';
import 'package:flutter_app/fetchdataapi/NetwrokUtils.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:flutter_app/Screen/theme.dart' as Theme;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

//final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//    FlutterLocalNotificationsPlugin();



class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}


class _ProfileState extends State<Profile> with WidgetsBindingObserver {
  final MethodChannel _channel = const MethodChannel('flutter_share_me');
  var value;
  String name = "Maria Elliott";
  String add=" ",phonenumber="";
  bool isExpanded = false;
  bool isSwitched = true;
  bool isaddedit = false;
  bool isphnoedit = false;
  List<GetEditProfile> geteditprofile = new List();

  TextEditingController _username = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phno = TextEditingController();


  AppConfig _appConfig;
  NetworkUtil networkUtil;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
    super.initState();

    networkUtil = new NetworkUtil();
    getdata();
    getprofiledata();

    _username.text = name;
  }

  void getprofiledata() async {
    await networkUtil.getprofile();

    geteditprofile = EditProfile.geteditprofile;

    name = geteditprofile[0].user_name;
    _username.text = name;

    phonenumber = geteditprofile[0].user_phone;
    add = geteditprofile[0].user_address;
    address.text = add;

    if(phonenumber==null)
      {
        phno.text = "add phone number";
      }else {
      phno.text = phonenumber;
    }
    islod = false;
    setState(() {});
  }
  Future<String>  baseencode()
  async {

    List<int> imageBytes = await _imageFile.readAsBytesSync();
    return base64.encode(imageBytes);
  }
  bool islod = true;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void getdata() async {
    await networkUtil.homegetcat();

    geteditprofile = EditProfile.geteditprofile;
    setState(() {});
  }




  void saveprofileeditdata() async {

    if(issave) {

     String a= await baseencode();
     print(a);

      await networkUtil.editprofile(
          AppConfig.userid, name, phno.text, address.text,  a );
     iscrop=false;
      _imageFile=null;

    }else
      {
        await networkUtil.editprofile1(
            AppConfig.userid, name, phno.text, address.text  );

      }
    geteditprofile = EditProfile.geteditprofile;
    setState(() {});
  }















  @override
  Widget build(BuildContext context) {
    YYDialog.init(context);
    _appConfig = new AppConfig(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_appConfig.rHP(6.5)),
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
                            'Profile',
                            style: TextStyle(
                                fontSize: _appConfig.rHP(3),
                                fontFamily: 'LatoBold'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: GestureDetector(
                            child: Container(),
                          ),
                        )
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
                                  builder: (context) => settings_screen()));
                        },
                        child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                  ),
                  /* onPressed: () => Navigator.pop(context, false),*/
                ),
              )),
        ),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Card(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      height: _appConfig.rHP(15),
                      child: Container(
                        /*    color: Colors.indigo,*/
                        width: double.infinity,
                        child: Stack(fit: StackFit.loose, children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 10, 0),
                                    child: new Container(
                                        width: _appConfig.rHP(9),
                                        height: _appConfig.rHP(9),
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black,
                                            image: new DecorationImage(
                                              image:geteditprofile.length > 0
                                                      ? new NetworkImage(NetworkUtil
                                                              .BASE_URL1 +
                                                          geteditprofile[0]
                                                              .user_profile_pic)
                                                      : new AssetImage(
                                                          'assets/profile.png')
                                                  ,
                                              fit: BoxFit.cover,
                                            ))),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      name,
                                      style: TextStyle(
                                          color: Color(0xff464646),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'JosefinSans'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: _appConfig.rWP(10),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("dgfdgfdtf");
//                                  issave=false;
                                  YYAlertDialogWithCustomIn();
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Image.asset(
                                    "assets/ic_edit2.png",
                                    height: _appConfig.rHP(9),
                                    width: _appConfig.rWP(9),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: GestureDetector(
                    onTap: () {},
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
                                (Icons.mail_outline),
                                color: Colors.white,
                              )),
                            ),
                            SizedBox(
                              width: _appConfig.rWP(5),
                            ),
                            Text(
                              geteditprofile[0].user_email,
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
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: _appConfig.rWP(90),
                      /*        height: _appConfig.rHP(15),
                width: _appConfig.rWP(90),*/
                      child: Card(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[


                              Container(
                                width: _appConfig.rHP(5),
                                height: _appConfig.rHP(5),

                                margin: prefix0.EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Center(
                                  child: Image.asset(
                                    "assets/ic_address.png",
                                    height: _appConfig.rHP(4.7),
                                    width: _appConfig.rHP(4.7),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),





                              Container(
                                width: _appConfig.rWP(55),
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: TextField(
                                  enabled: isaddedit,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  controller: address,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  isaddedit = !isaddedit;
                                  setState(() {});
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: isaddedit
                                      ? Icon(Icons.check)
                                      : Image.asset(
                                          "assets/ic_edit2.png",
                                          height: _appConfig.rHP(9),
                                          width: _appConfig.rWP(9),
                                        ),
                                ),
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

/// /////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: _appConfig.rWP(90),
                      /*        height: _appConfig.rHP(15),
                width: _appConfig.rWP(90),*/
                      child: Card(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[


                              Container(
                                width: _appConfig.rHP(5),
                                height: _appConfig.rHP(5),

                                margin: prefix0.EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Center(
                                  child: Image.asset(
                                    "assets/ic_call.png",
                                    height: _appConfig.rHP(4.7),
                                    width: _appConfig.rHP(4.7),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),





                              Container(
                                width: _appConfig.rWP(55),
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: TextField(
                                  enabled: isphnoedit,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  controller: phno,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  isphnoedit = !isphnoedit;
                                  setState(() {});
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: isphnoedit
                                      ? Icon(Icons.check)
                                      : Image.asset(
                                    "assets/ic_edit2.png",
                                    height: _appConfig.rHP(9),
                                    width: _appConfig.rWP(9),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                /*  Padding(
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
                          borderRadius: new BorderRadius.all(Radius.circular(30)),
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
          ),*/     SizedBox(
                  height: _appConfig.rHP(1),
                ),
              ],
            ),
    );
  }



  String tempname;
  YYDialog dialog1;

  YYDialog YYAlertDialogWithCustomIn() {
    dialog1 = YYDialog().build()
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
            controller: _username,
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
                    !iscrop
                        ? _previewImage()
                        : new ClipRRect(
                            borderRadius: new BorderRadius.circular(50.0),
                            child: Image.file(
                              _imageFile,
                              height: _appConfig.rHP(15),
                              width: _appConfig.rHP(15),
                              fit: BoxFit.fill,
                            ),
                          ),
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

                            dialog1.dismiss();
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
        onTap1: () {
          if (_imageFile == null) {

//            saveprofileeditdata();
          } else {
            issave = true;
//            saveprofileeditdata();

          }

          tempname = _username.text;


          setState(() {
            name = tempname;
            saveprofileeditdata();
          });
        },
        color1: Colors.teal,
        fontSize1: 14.0,
        onTap2: () {},
        text2: "CANCEL",
        color2: Colors.teal,
        fontSize2: 14.0,
      )
      ..show();

    return dialog1;
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
    if (_imageFile != null) {
      return Image.file(
        _imageFile,
        height: _appConfig.rWP(20),
        width: _appConfig.rWP(20),
        fit: BoxFit.fill,
      );
    }
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    } else if (_pickImageError != null) {
      return Text(
        '',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        '',
        textAlign: TextAlign.center,
      );
    }
  }

  bool issave = false;
  bool iscrop = false;

  Future<Null> _cropImage(File imageFile) async {
    _imageFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        /* ratioX: 2.0,
      ratioY: 2.0,*/
        maxWidth: 512,
        maxHeight: 512,
        cropStyle: CropStyle.circle);
    setState(() {
      iscrop = true;
      YYAlertDialogWithCustomIn();
    });
  }
}
