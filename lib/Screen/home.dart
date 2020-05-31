import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_app/Screen/fabbottom.dart';
import 'package:flutter_app/Screen/hotel_details/hotel_details_screen.dart';
import 'package:flutter_app/Screen/nearby_place.dart';
import 'package:flutter_app/Utils/AppConfig.dart';
import 'package:flutter_app/Screen/theme.dart' as Theme;
import 'package:flutter_app/Screen/category_screen.dart';
import 'package:flutter_app/fetchdataapi/Model/Getcategory.dart';
import 'package:flutter_app/fetchdataapi/Model/Getsinglecategory.dart';
import 'package:flutter_app/fetchdataapi/Model/searchcity.dart';
import 'package:flutter_app/fetchdataapi/NetwrokUtils.dart';
import 'package:search_widget/search_widget.dart';

class home extends StatefulWidget {
  BuildContext context;

  home(@required this.context);

  @override
  _homeState createState() => _homeState();
}

AppConfig _appConfig;

class _homeState extends State<home> {
  final fabc = 0xFFffb3b3;
  String _lastSelected = 'TAB: 0';

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
    });
  }
  GetsingleCatItem getsingleCatItem ;

  // Main_screen({Key key}) : super(key: key);
    NetworkUtil networkUtil;
  List<GetSearchList> searchlist = new List();
  void getsearchdaata() async {
    searchlist.clear();

    await networkUtil.searchlist();

    searchlist = SearchList.searchlist;
    setState(() {});
  }
  GetSearchList _selectedItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    networkUtil = new NetworkUtil();
    getcatdaata();
    getsearchdaata();
  }
  void getsubcatdaata(String pos) async {
//    print("cvcfcfcfc" + widget.index.toString());
    await networkUtil.viewplacesingle(AppConfig.userid,pos);

    getsingleCatItem = GetsingleCat.getsingleCatItem[0];
    setState(() {});
  }
  List<GetCatItem> catgorylist = new List();

  void getcatdaata() async {
    await networkUtil.homegetcat();

    catgorylist = GetCat.homeGetCatlist;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = new AppConfig(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: _appConfig.rH(96),
          width: _appConfig.rW(100),
          child: Stack(
            fit: StackFit.expand,
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: _appConfig.rHP(30),
                  child: Stack(
                    children: <Widget>[
                      Container(
                          height: _appConfig.rHP(30),
                          width: double.infinity,
                          child: Image.asset(
                            "assets/header_bg.png",
                            fit: BoxFit.cover,
                          )
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/logo_img.png",
                                height: 50,
                                width: 50,
                              ),
                              Container(
                                  margin:
                                      prefix0.EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Text(
                                    "Place Finder",
                                    style: prefix0.TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'Righteous',
                                      color: Colors.white,
                                    ),
                                  ))
                            ],
                          ),
                          Container(
                            margin: prefix0.EdgeInsets.fromLTRB(20, 15, 10, 0),
                            child: Text(
                              "search areas in the simplest way",
                              style: prefix0.TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _appConfig.rHP(5),
                      ),

                    ],
                  ),
                ),
              ),


              Positioned(
                top: _appConfig.rH(19),
                left: 20,
                right: 20,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: _appConfig.rWP(72),
                      height: _appConfig.rHP(7),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        new BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Center(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: _appConfig.rWP(70),
                                  child: SearchWidget<GetSearchList>(
                                    dataList: searchlist,
                                    hideSearchBoxWhenItemSelected: false,
                                    listContainerHeight:_appConfig.rH(20),
                                    queryBuilder: (query, list) {
                                      return list
                                          .where((item) => item.place_name
                                          .toLowerCase()
                                          .contains(query.toLowerCase()))
                                          .toList();
                                    },
                                    popupListItemBuilder: (item) {
                                      return PopupListItemWidget(item);
                                    },
                                      selectedItemBuilder: (selectedItem, deleteSelectedItem) {
                                        return prefix0.Container();
                                      },
                                    // widget customization

                                    textFieldBuilder: (controller, focusNode) {
                                      return MyTextField(controller, focusNode);
                                    },
                                    onItemSelected: (item) async {

                                      await getsubcatdaata(item.place_id);






                                      Navigator.of(context).push(
                                        PageRouteBuilder<void>(
                                          pageBuilder: (BuildContext context,
                                              Animation<double> animation,
                                              Animation<double> secondaryAnimation) {
                                            return AnimatedBuilder(
                                                animation: animation,
                                                builder:
                                                    (BuildContext context, Widget child) {
                                                  return DetailScreen(
                                                    heroTag: "klsejfksefjeo",
                                                    imageAsset: cardImageAsset(),
                                                    getsingleCatItem:
                                                    getsingleCatItem,
                                                  );
                                                }
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),

                              ],
                            ),
                          )
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => nearby_place())).then((val)=>val?getsearchdaata():null);
                      },
                      child: Image.asset(
                        "assets/ic_filter.png",
                        height: _appConfig.rHP(6.5),
                        width: _appConfig.rHP(6.5),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(

                top: _appConfig.rH(27),
             left: 0,
                right: 0,

                child: Container(
                  height: _appConfig.rHP(70),
                  width: double.infinity,
                  child: catgorylist.length == 0
                      ?
                  Container(
                          child: Center(
                              child: CircularProgressIndicator(
                            backgroundColor: Colors.tealAccent,
                            strokeWidth: 2.0,
                          )
                          ),
                        )
                      : GridView.builder(
                          /* physics: NeverScrollableScrollPhysics(),*/
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.3,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 0.0),
                          shrinkWrap: true,
                          itemCount: catgorylist.length,
                          itemBuilder: (context, index) => Container(
                            child: Container(
                              child: Card(
                                elevation: 1,
                                child: Container(
                                  height: _appConfig.rHP(10),
                                  child: GestureDetector(
                                    onTap: () =>
                                        Navigator.of(
                                            widget.context).push(
                                      PageRouteBuilder<Null>(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation,
                                            Animation<double>
                                                secondaryAnimation) {
                                          return AnimatedBuilder(
                                              animation: animation,
                                              builder: (BuildContext context,
                                                  Widget child) {
                                                return category_screen(
                                                    ImageWithLabel(
                                                        index, catgorylist),
                                                    catgorylist[index]
                                                        .category_id);
                                              });
                                        },
                                      ),
                                    ),
                                    /*  Navigator.of(context).push(MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  SecondScreen(
                                                    Hero(
                                                      tag: index,
                                                      child: ImageWithLabel(index),
                                                    ),
                                                  ),

                                          ),
                                          ),*/
                                    child: ImageWithLabel(index, catgorylist),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  cardImageAsset() {

  }
}

class ImageWithLabel extends StatelessWidget {
/*  final List<String> categories = [
    'ATM',
    'BANKS',
    'BAR',
    'BEACH',
    'CINEMA',
    'COFFEE',
    'EDUCATION',
    'HOTELS',
    'MALL',
    'MEDICAL',
    'RESAURANT',
    'TEMPLE',
    'ZOO'
  ];

  final List<String> images = [
    'assets/ic_atm.png',
    'assets/ic_bank.png',
    'assets/ic_bar.png',
    'assets/ic_beach.png',
    'assets/ic_cinema.png',
    'assets/ic_coffee.png',
    'assets/ic_library.png',
    'assets/ic_hotel.png',
    'assets/ic_mall.png',
    'assets/ic_pharmacy.png',
    'assets/ic_food.png',
    'assets/ic_temple.png',
    'assets/ic_zoo.png'
  ];*/

  ImageWithLabel(this.index, this.catgorylist);

  final int index;
  List<GetCatItem> catgorylist = new List();

  @override
  Widget build(BuildContext context) => Container(
        height: _appConfig.rHP(18),
        width: _appConfig.rWP(30),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      NetworkUtil.BASE_URL1 + catgorylist[index].category_image,
                      height: 50,
                    ),
                    SizedBox(
                      height: _appConfig.rHP(1),
                    ),
                    Text(catgorylist[index].category_name,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Lato')),
                  ],
                )),
          ),
        ),
      );

/* void searchOperation(String searchText) {
    catgorylist.clear();

    if (_isSearching != null) {
      for (int i = 0; i < _list.length; i++) {
        String data = _list[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }*/


  cardImageAsset() {

  }
}

class SelectedItemWidget extends StatelessWidget {
  const SelectedItemWidget(this.selectedItem, this.deleteSelectedItem);

  final GetSearchList selectedItem;
  final VoidCallback deleteSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: Text(
                selectedItem.place_name,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, size: 22),
            color: Colors.grey[700],
            onPressed: deleteSelectedItem,
          ),
        ],
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField(this.controller, this.focusNode);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        decoration: InputDecoration(


          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: "Search here...",
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
          ),
        ),
      ),
    );
  }
}

class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.folder_open,
          size: 24,
          color: Colors.grey[900].withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          "No Items Found",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900].withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.item);

  final GetSearchList item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        item.place_name,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
