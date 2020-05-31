import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/AppConfig.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'MediaQuery Demo',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new ProfileTwoPage(),
    );
  }
}

class ProfileTwoPage extends StatelessWidget {
  AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = new AppConfig(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: _appConfig.rHP(30),
            width: double.infinity,
            child: Image.asset(
              "assets/profile_banner.png",
              fit: BoxFit.fill,
            ),
          ),
          ListView.builder(
            itemCount: 7,
            itemBuilder: _mainListBuilder,
          ),
        ],
      ),
    );
  }

  Widget _mainListBuilder(BuildContext context, int index) {
    if (index == 0) return _buildHeader(context);
    if (index == 1) return _buildSectionHeader(context);
    if (index == 2) return _buildCollectionsRow();
    if (index == 3)
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset(
                "assets/favorite_pressed.png",
                height: 25,
                width: 30,
              ),
            ),
            /* SizedBox(width: 10,),*/
            Text(
              "Favorite",
              style: TextStyle(fontSize: 18, fontFamily: 'BerkshireSwash'),
            ),
          ],
        ),
      );
    return _buildListItem();
  }

  Widget _buildListItem() {
    return Container(
        /*child: GridView.builder(
          scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context,index)=>
        Container(
          child: Card(
            child: Container(
              child: Row(

                children: <Widget>[
                  Container(
                      child: Image.asset(
                        "assets/img4.jpg",
                        height: _appConfig.rH(10),
                        width: _appConfig.rW(20),
                        fit: BoxFit.fill,
                      )
                  ),

                ],
              ),
            ),
          ),

        )

        )*/
        /*GridView.builder(
       */ /* physics: const NeverScrollableScrollPhysics(),*/ /*
        scrollDirection: Axis.horizontal,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
      */ /*  shrinkWrap: true,*/ /*
        */ /* itemCount: images.length,*/ /*
        itemBuilder: (BuildContext context, int index) =>
            Container(
              height: _appConfig.rH(20),
              child: GestureDetector(

                child: Card(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: Image.asset(
                              "assets/img4.jpg",
                              height: _appConfig.rH(15),
                              width: _appConfig.rW(35),
                              fit: BoxFit.fill,
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              0, 0, 0, 5),
                          child: Center(
                              child: Text(
                                "floewer",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ),*/

        );
  }

  Container _buildSectionHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Material(
            elevation: 2.0,
            shape: CircleBorder(),
            child: Container(
              height: 40,
              width: 40,
              child: CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/ic_own_playlist.png'),
              ),
            ),
          ),
          Text(
            "Own Playlist",
            style: TextStyle(fontSize: 18, fontFamily: 'BerkshireSwash'),
          ),
          /*   FlatButton(
            onPressed: (){},
            child: Text("Create new", style: TextStyle(color: Colors.blue),),
          )*/
        ],
      ),
    );
  }

  Container _buildCollectionsRow() {
    return Container(
      color: Colors.white,
      height: 200.0,
      padding: EdgeInsets.symmetric(horizontal: 1.0),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
              width: 150.0,
              height: 180.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                      child: Image.asset(
                    "assets/Rectangle 3082.png",
                    fit: BoxFit.fill,
                    height: _appConfig.rHP(20),
                  )),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("Pop Acoustic",
                      style: Theme.of(context)
                          .textTheme
                          .subhead
                          .merge(TextStyle(color: Colors.grey.shade600)))
                ],
              ));
        },
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 130.0,
            width: _appConfig.rW(80),
            margin: EdgeInsets.only(
                top: 50.0, left: 40.0, right: 40.0, bottom: 0.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0))),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 80.0,
                  ),
                  Text("Maria Elliott",
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'JosefinSans')),
                  /*     SizedBox(height: 5.0,),

                  SizedBox(height: 16.0,),*/
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/img5.jpg'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage('assets/ic_edit.png'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
