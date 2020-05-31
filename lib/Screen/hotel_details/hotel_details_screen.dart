import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_app/Screen/hotel_details/book_screen.dart';
import 'package:flutter_app/Screen/hotel_details/theme1.dart';
import 'package:flutter_app/Screen/widget/blur_icon.dart';
import 'package:flutter_app/Screen/navigation/fade_route.dart';
import 'package:flutter_app/Screen/hotel_details/icons.dart';
import 'package:flutter_app/Screen/hotel_details/parallax_page_view.dart';
import 'package:flutter_app/Screen/hotel_details/sliding_bottom_sheet.dart';
import 'package:flutter_app/Utils/AppConfig.dart';
import 'package:flutter_app/fetchdataapi/Model/Getsinglecategory.dart';
import 'package:flutter_app/fetchdataapi/Model/PlaceImges.dart';
import 'package:flutter_app/fetchdataapi/NetwrokUtils.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:flutter_app/Screen/theme.dart' as Theme;

class DetailScreen extends StatefulWidget {
  final String heroTag;
  final String imageAsset;

 
  GetsingleCatItem getsingleCatItem;

  DetailScreen({this.heroTag, this.imageAsset, this.getsingleCatItem});

  @override
  _DetailScreenState createState() =>
      _DetailScreenState(heroTag: heroTag, imageAsset: imageAsset);
}
AppConfig _appConfig;
class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {


  final String heroTag;
  final String imageAsset;
  final double bottomSheetCornerRadius = 50;

  final Duration animationDuration = Duration(milliseconds: 600);
  final Duration delay = Duration(milliseconds: 300);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;


  _DetailScreenState({
    this.heroTag,
    this.imageAsset,
  });

  static double bookButtonBottomOffset = -60;
  double bookButtonBottom = bookButtonBottomOffset;
  AnimationController _bottomSheetController;

  void _onTap() {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, _goToNextPage);
    });
  }

  void _goToNextPage() {
    Navigator.of(context)
        .push(FadeRouteBuilder(page: BookScreen()))
        .then((_) => setState(() => rect = null));
  }

  @override
  void initState() {
    super.initState();
    _bottomSheetController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    Future.delayed(Duration(milliseconds: 700)).then((v) {
      setState(() {
        bookButtonBottom = 0;
      }
      );
    });

    networkUtil = new NetworkUtil();

    getplaceall();
  }

  NetworkUtil networkUtil;
  List<GetPlaceImages> getplaceimage = new List();

  void getplaceall() async {
    await networkUtil.getallplace(AppConfig.userid, widget.getsingleCatItem.place_id);

    getplaceimage = PlaceImages.getplaceimages;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = new AppConfig(context);
    final themeData = HotelConceptThemeProvider.get();
    final coverImageHeightCalc =
        MediaQuery.of(context).size.height / 2 + bottomSheetCornerRadius;
    return WillPopScope(
      onWillPop: () async {
        if (_bottomSheetController.value <= 0.5) {
          setState(() {
            bookButtonBottom = bookButtonBottomOffset;
          });
        }
        return true;
      },

      child: Scaffold(
        appBar:


        PreferredSize(
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
                      tileMode: TileMode.clamp
                  ),
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
                        textAlign: prefix0.TextAlign.start,
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


        body: Stack(
          children: <Widget>[
            Container(

            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,

              child: Hero(
                createRectTween: ParallaxPageView.createRectTween,
                tag: heroTag,
                child: Container(
                  height: _appConfig.rHP(48),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      child: PageIndicatorContainer(
                        align: IndicatorAlign.bottom,
                        length: 3,
                        indicatorSpace: 12.0,
                        padding: EdgeInsets.only(bottom: 60),
                        indicatorColor: themeData.indicatorColor,
                        indicatorSelectorColor: Colors.white,
                        shape: IndicatorShape.circle(size: 8),


                        child:getplaceimage.length>0? CarouselSlider(
                          height: _appConfig.rHP(50),
                          autoPlay: true,
                          items: getplaceimage.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white
                                    ),
                                    child:FadeInImage.assetNetwork(
                                      // here `bytes` is a Uint8List containing the bytes for the in-memory image
                                      placeholder: "assets/loading.gif",

                                      image: ( NetworkUtil.BASE_URL1 +
                                          i.place_image),
                                      fit: BoxFit.cover,
                                    )
                                  /*Image.network(
                                      NetworkUtil.BASE_URL1 +
                                          i.place_image,
                                      //last listvew img

                                      fit: BoxFit.cover,
                                    )*/
                                );
                              },
                            );
                          }
                          ).toList(),
                        )

                        /*PageView(
                          children: <Widget>[
                            Image.network(
                              NetworkUtil.BASE_URL1 +
                                  widget.getsingleCatItem.place_image,
                              //last listvew img

                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              "assets/hotel_bnner.jpg", // <- stubbed data
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              "assets/hotelbnner.jpg", // <- stubbed data
                              fit: BoxFit.cover,
                            ),
                          ],
                        )*/:Container()
                      )),
                ),
              ),
            ),
          /*  Positioned(
              top: 46,
              right: 24,
              child: Hero(
                tag: "${heroTag}heart",
                child: BlurIcon(
                  icon: Icon(
                    HotelBookingConcept.ic_heart_empty,
                    color: Colors.white,
                    size: 15.2,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 46,
              left: 24,
              child: Hero(
                tag: "${heroTag}chevron",
                child: GestureDetector(
                  onTap: () async {
                    await _bottomSheetController.animateTo(0,
                        duration: Duration(milliseconds: 150));
                    setState(() {
                      bookButtonBottom = bookButtonBottomOffset;
                    }
                    );
                    Navigator.pop(context);
                  },
                  child: BlurIcon(
                    icon: Icon(
                      HotelBookingConcept.ic_chevron_left,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),*/
            SlidingBottomSheet(
              controller: _bottomSheetController,
              cornerRadius: bottomSheetCornerRadius,
              getsingleCatItem: widget.getsingleCatItem,
              getplaceimages: getplaceimage,
            ),
         /*   AnimatedPositioned(
              duration: Duration(milliseconds: 100),
              curve: Interval(
                0,
                0.5,
                curve: Curves.easeInOut,
              ),
              bottom: bookButtonBottom,
              right: 0,
              child: RectGetter(
                key: rectGetterKey,
                child: GestureDetector(
                  onTap: _onTap,
                  child: Container(
                    height: 60,
                    width: 172,
                    decoration: BoxDecoration(
                        color: themeData.accentColor,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(50))),
                    child: Center(
                      child: Text(
                        "Distance",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),*/
            _ripple(themeData),
          ],
        ),
      ),
    );
  }

  Widget _ripple(ThemeData themeData) {


    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      duration: animationDuration,
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: themeData.accentColor,
        ),
      ),
    );
  }
}
