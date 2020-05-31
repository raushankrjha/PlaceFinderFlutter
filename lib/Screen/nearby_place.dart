import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_app/Screen/home.dart';
import 'package:flutter_app/Utils/AppConfig.dart';
import 'package:flutter_app/Widgets/seekbar/seekbar.dart';
import 'package:flutter_app/fetchdataapi/Model/CitysSelect.dart';
import 'package:flutter_app/fetchdataapi/Model/Getcategory.dart';
import 'package:flutter_app/fetchdataapi/Model/searchcity.dart';
import 'package:flutter_app/fetchdataapi/NetwrokUtils.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;
import 'package:flutter_app/Screen/theme.dart' as Theme;



class nearby_place extends StatefulWidget {
  @override
  _nearby_placeState createState() => _nearby_placeState();
}

class _nearby_placeState extends State<nearby_place> {
  var value;
  var value1;
  bool isExpanded = false;
  AppConfig _appConfig;
  List<GetCatItem> catgorylist = new List();
  List<CitysSelectList> searchlist = new List();
  int index = 0;
  NetworkUtil networkUtil;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    networkUtil = new NetworkUtil();
    getcatdaata();
    getsearchdaata();
  }

  int vau = int.parse(AppConfig.distcance);

  void getcatdaata() async {
    await networkUtil.homegetcat();

    catgorylist = GetCat.homeGetCatlist;
    setState(() {});
  }

  void getsearchdaata() async {
    await networkUtil.searchcitylist();

    searchlist = CitysSelect.searchlist;
    setState(() {});
  }

  double _lowerValue = 10.0;
  double _upperValue = 30.0;

  @override
  Widget build(BuildContext context) {
    _appConfig = new AppConfig(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                'Filter',
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
              /* onPressed: () => Navigator.pop(context, false),*/
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Color(0xffF5F5F5),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
            child: Card(
              color: Color(0xffFFFFFF),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Select Your Prefrences",
                            style: TextStyle(
                                color: Color(0xff4BBAC3),
                                fontSize: 21,
                                fontFamily: 'LatoBold'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _appConfig.rHP(4),
                    ),
                    Container(
                      width: _appConfig.rWP(85),
                      height: 2,
                      color: Color(0xffF5F5F5),
                    ),
                    SizedBox(
                      height: _appConfig.rHP(4),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: prefix0.MainAxisAlignment.start,
                        crossAxisAlignment: prefix0.CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Select Category",
                            style: TextStyle(
                                fontSize: 18, fontFamily: 'LatoMedium'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "The distance of Places around me",
                            style: TextStyle(
                                color: Color(0xffBFBFBF),
                                fontSize: 16,
                                fontFamily: 'LatoMedium'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: _appConfig.rHP(7),
                      margin: prefix0.EdgeInsets.fromLTRB(15, 15, 15, 15),
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.all(Radius.circular(30)),
                        border:
                            Border.all(color: Color(0xff4ABAC2), width: 2.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Center(
                          child: DropdownButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xff4ABAC2),
                            ),
                            underline: Text(""),
                            items: catgorylist.map((location) {
                              return DropdownMenuItem(
                                child: new Text(location.category_name),
                                value: location.category_name,
                              );
                            }).toList(),
                            isExpanded: true,
                            hint: Text(
                              "Select Category",
                              style: TextStyle(color: Color(0xff4ABAC2)),
                            ),
                            value: value,
                            onChanged: (value) {
                              print(value);


                              for(int i=0;i<catgorylist.length;i++)
                                {

                                  if(catgorylist[i].category_name==value.toString())
                                    {
                                      AppConfig.cate=catgorylist[i].category_id;
                                    }

                                }


                              print(AppConfig.cate);

                              setState(() {
                                this.value = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _appConfig.rHP(3),
                    ),
                    /* SizedBox(
                      height: _appConfig.rHP(4),
                    ),*/
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: prefix0.MainAxisAlignment.start,
                        crossAxisAlignment: prefix0.CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Select City",
                            style: TextStyle(
                                fontSize: 18, fontFamily: 'LatoMedium'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "The distance of Places around me",
                            style: TextStyle(
                                color: Color(0xffBFBFBF),
                                fontSize: 16,
                                fontFamily: 'LatoMedium'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: _appConfig.rHP(7),
                      margin: prefix0.EdgeInsets.fromLTRB(15, 15, 15, 15),
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.all(Radius.circular(30)),
                        border:
                            Border.all(color: Color(0xff4ABAC2), width: 2.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Center(
                          child: DropdownButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xff4ABAC2),
                            ),
                            underline: Text(""),
                            items: searchlist.map((location) {
                              return DropdownMenuItem(
                                child: new Text(location.place_city),
                                value: location.place_city,
                              );
                            }).toList(),
                            isExpanded: true,
                            hint: Text(
                              "Select City",
                              style: TextStyle(color: Color(0xff4ABAC2)),
                            ),
                            value: value1,
                            onChanged: (value) {
                              print(value);

                              AppConfig.citys=value;
                              setState(() {
                                this.value1 = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _appConfig.rHP(3),
                    ),
                    Container(
                      width: _appConfig.rWP(85),
                      height: 2,
                      color: Color(0xffF5F5F5),
                    ),
                    SizedBox(
                      height: _appConfig.rHP(3),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: prefix0.MainAxisAlignment.start,
                        crossAxisAlignment: prefix0.CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Distance( KM )",
                            style: TextStyle(
                                fontSize: 18, fontFamily: 'LatoMedium'),
                          ),
                          prefix0.SizedBox(
                            height: 10,
                          ),
                          Text(
                            "The distance of Places around me is $vau",
                            style: TextStyle(
                                color: Color(0xffBFBFBF),
                                fontSize: 16,
                                fontFamily: 'LatoMedium'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: _appConfig.rHP(10),
                      width: _appConfig.rWP(80),
                      child: SliderTheme(
                        // Customization of the SliderTheme
                        // based on individual definitions
                        // (see rangeSliders in _RangeSliderSampleState)
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Color(0xFF4CB8C4),
                          inactiveTrackColor: Colors.teal,
                          //trackHeight: 8.0,
                          thumbColor: Color(0xFF3CD3AD),
                          valueIndicatorColor: Color(0xFF4CB8C4),
                        ),
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
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _appConfig.rHP(5),
                    ),
                    GestureDetector(
                      onTap: () {


                        AppConfig.distcance=vau.toString();
                        Navigator.pop(context,true);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Container(
                          width: _appConfig.rWP(46),
                          height: _appConfig.rHP(6),
                          decoration: new BoxDecoration(
                            borderRadius:
                                new BorderRadius.all(Radius.circular(30)),
                            gradient: new LinearGradient(
                                colors: [
                                  Theme.Colors.firstGradientStart,
                                  Theme.Colors.firstGradientEnd
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 1.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: Center(
                              child: Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                SizedBox(
                                  width: _appConfig.rWP(2),
                                ),
                                Text(
                                  "Apply",
                                  style: TextStyle(
                                      fontSize: _appConfig.rWP(4),
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          )),
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
    );
  }
}
