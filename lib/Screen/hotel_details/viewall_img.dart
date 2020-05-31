import 'package:flutter/material.dart';
import 'package:flutter_app/Screen/hotel_details/theme1.dart';
import 'package:flutter_app/Utils/AppConfig.dart';
import 'package:flutter_app/fetchdataapi/Model/CommentModel.dart';
import 'package:flutter_app/fetchdataapi/Model/Getsinglecategory.dart';
import 'package:flutter_app/fetchdataapi/Model/PlaceImges.dart';
import 'package:flutter_app/fetchdataapi/NetwrokUtils.dart';
import 'package:flutter_app/maps/CommentMaps.dart';
import 'package:flutter_app/test/MapScreen.dart';
import 'package:flutter_app/Screen/theme.dart' as Theme;

class Viewallimg extends StatefulWidget {

//  GetsingleCatItem getsingleCatItem;
  List<GetPlaceImages> getplaceimages;

  Viewallimg(@required this.getplaceimages);

  @override
  _ViewallimgState createState() => _ViewallimgState();


}
AppConfig _appConfig;

class _ViewallimgState extends State<Viewallimg> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    _appConfig = new AppConfig(context);
    final themeData = HotelConceptThemeProvider.get();
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size(null, 100),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 2)
          ]),
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
            ),
            child: Container(
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.circular(0)),
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
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                      child: GestureDetector(
                          onTap: () => Navigator.pop(context, false),

                          child: Icon(Icons.arrow_back_ios,size: 30,color: Colors.white)),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      "Place Finder",
                      style: TextStyle(fontSize: 25, color: Colors.white,fontFamily: 'LatoBold'),
                      textAlign: TextAlign.start,
                    ),
                    /* Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                        child: Icon(Icons.search,size: 30,color: Colors.white,),
                      ),*/
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
        body: Container(
height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
//            physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
              crossAxisSpacing: 5,mainAxisSpacing: 5),
              scrollDirection: Axis.vertical,
              itemCount: widget.getplaceimages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) {
                          return new Material(
                            color: Colors.black54,
                            child: Container(
                              padding: EdgeInsets.all(30.0),
                              child: InkWell(
                                child: Hero(
                                    tag:
                                    "hero-grid-${widget.getplaceimages[index].hashCode}",
                                    child: Image.network(
                                      NetworkUtil.BASE_URL1+ widget.getplaceimages[index].place_image,
                                      width: 300.0,
                                      height: 300.0,
                                      alignment: Alignment.center,
                                      fit: BoxFit.contain,
                                    )),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          );
                        },
                        transitionDuration: Duration(milliseconds: 500)));
                  },
                  child: Container(
//                    height: _appConfig.rH(20),
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0.0),
//                    width: _appConfig.rW(35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
//                          height: _appConfig.rH(14),
                            padding: EdgeInsets.all(0.8),
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.black,
                                //                   <--- border color
                                width: 0.1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: FadeInImage.assetNetwork(
                                // here `bytes` is a Uint8List containing the bytes for the in-memory image
                                placeholder: "assets/loading.gif",

                                image: (NetworkUtil.BASE_URL1 +
                                    widget.getplaceimages[index].place_image),
                                height: _appConfig.rHP(22),
                                fit: BoxFit.cover,
                                width: _appConfig.rHP(23),
                              ),

                              /*Image.network(
                            NetworkUtil.BASE_URL1 +
                                widget.getplaceimage s[index].place_image,
                            //last listvew img

                            fit: BoxFit.fill,
                          ),*/
                            ),
                          ),
                        ],
                      )
                  ),
                );
              },
            ),
          ),
        )
    );
  }

}
