import 'package:flutter/material.dart';
import 'package:flutter_app/Screen/hotel_details/theme1.dart';
import 'package:flutter_app/Utils/AppConfig.dart';
import 'package:flutter_app/fetchdataapi/Model/CommentModel.dart';
import 'package:flutter_app/fetchdataapi/Model/Getsinglecategory.dart';
import 'package:flutter_app/fetchdataapi/NetwrokUtils.dart';
import 'package:flutter_app/maps/CommentMaps.dart';
import 'package:flutter_app/test/MapScreen.dart';
import 'package:flutter_app/Screen/theme.dart' as Theme;
class CommentList extends StatefulWidget {
  GetsingleCatItem getsingleCatItem;


  CommentList(@required this.getsingleCatItem);

  @override
  _CommentListState createState() => _CommentListState();


}
AppConfig _appConfig;

class _CommentListState extends State<CommentList> {

  bool isloadcomment = false;
  Future<void> listcpmments() async {
    await networkUtil.getCommentid(widget.getsingleCatItem.place_id);

    listcomments = CommentMaps.list;

    setState(() {
      isloadcomment = true;
    }
    );
  }
  @override
  void initState() {
    super.initState();
    networkUtil = NetworkUtil();

    listcpmments();
  }

  NetworkUtil networkUtil;

  List<CommentModel> listcomments = new List();
  @override
  Widget build(BuildContext context) {
    _appConfig = new AppConfig(context);

    final themeData = HotelConceptThemeProvider.get();
    return Scaffold(
      appBar: PreferredSize(
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


        child: listcomments.length>0? Container(

            child: ListView.builder(


                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: listcomments.length,
                itemBuilder: (context, position) {
                  return childcomment(position);
                }),
          ):Center(
          child:
          CircularProgressIndicator(
            backgroundColor: Colors.tealAccent,
            strokeWidth: 2.0,
            ),
        ),

      )
    );
  }
  Widget childcomment(int index) {




    return Container(
      margin: EdgeInsets.all(6.0),
      child: Container(
        child: Container(

          color: Color(0xffF6F6F6),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: _appConfig.rW(20),
                  child: Image.network(NetworkUtil.BASE_URL1+listcomments[index].user_profile_pic),
                ),
                Container(
                  width: _appConfig.rW(60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /*  Text(
                        listcomments[index].user_name,
                        style: TextStyle(
                            color: Color(0xff146BB1),
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),*/
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          listcomments[index].review_text,
                          style: TextStyle(
                              color: Color(0xffAFB1B3),
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
