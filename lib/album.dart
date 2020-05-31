import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_app/Utils/AppConfig.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:flutter_app/Screen/theme.dart' as Theme;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        //brightness: Brightness.dark
      ),
      home: nearby_place(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class nearby_place extends StatefulWidget {
  @override
  _nearby_placeState createState() => _nearby_placeState();
}

AppConfig _appConfig;

class _nearby_placeState extends State<nearby_place> {
  var value;
  bool isExpanded = false;
bool islist=false;
  @override
  Widget build(BuildContext context) {
    _appConfig = new AppConfig(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_appConfig.rHP(6.5)),
        child: AppBar(

          /*automaticallyImplyLeading: true,*/
           /* flexibleSpace: Container(
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
            ),*/
            title: Container(
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'album',
                    style: TextStyle(
                        fontSize: _appConfig.rHP(3), fontFamily: 'LatoBold'),
                  ),
                  prefix0.GestureDetector(

                      onTap: (){

                        if(islist)
                          {
                            islist=false;
                          }
                        else
                          {
                            islist=true;


                          }
                        setState(() {

                        });
                      },
                      child:islist?Icon(Icons.grid_on): Icon(Icons.view_list))
                ],
              ),
            ),

            /**/

            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
              onPressed: () => Navigator.pop(context, false),
            )),
      ),
        body:islist?
            Container(
              color: Colors.white,

              width: double.infinity,
              child: ListView.builder(
                itemCount: 5,
                padding: EdgeInsets.all(0),
                itemBuilder: (context, position) {
                  return GestureDetector(
                    onTap: () {

                    },
                    child: Card(
                      elevation: 1,

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
                                        "assets/coffee.png",
                                        fit: BoxFit.fill,
                                      )),
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

            :Container(
          child: GridView.builder(
            //physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            shrinkWrap: true,
            itemCount: 7,
            itemBuilder: (BuildContext context, int index) => Container(
              height: _appConfig.rH(35),
              child: Card(
                child: GestureDetector(
                  onTap: () => {},
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: GestureDetector(

                              child: Image.asset(
                                "assets/coffee.png",
                                height: _appConfig.rH(10),
                                width: _appConfig.rH(10),
                                fit: BoxFit.fill,
                              ),
                            )),
                        SizedBox(height: _appConfig.rHP(5),),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Center(
                              child: Text(
                                "album 1",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600
                                ),
                              )
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              )

            ),
          ),
        ),
    );
  }
}
