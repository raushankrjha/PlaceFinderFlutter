

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_app/Screen/hotel_details/map_open.dart';
import 'package:flutter_app/Utils/AppConfig.dart';
import 'package:flutter_app/fetchdataapi/Model/Getsinglecategory.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/Screen/hotel_details/parallax_sliding_card.dart';
import 'package:flutter_app/Screen/theme.dart' as Theme;
import 'package:fluttertoast/fluttertoast.dart';

class StubData {
  BuildContext cntext;

  int isli = 0;
  Widget islikeimg() {
    if (isli == 1) {
      return Center(
        child: Icon(
          Icons.favorite,
          color: Colors.white,
        ),
      );
    } else {
      return Center(
        child: Center(
          child: Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
        ),
      );
    }
  }
  StubData(BuildContext buildContext,GetsingleCatItem getsingleCatItem) {
    this.cntext = buildContext;
    _appConfig = new AppConfig(cntext);
    this.getsingleCatItem=getsingleCatItem;

  }

  List<String> get hotelCategories =>
      ["All", "Popular", "Top", "Sale", "30\$-100\$", "100\$-200\$"];
  AppConfig _appConfig;
  GetsingleCatItem getsingleCatItem;
}

class HotelCard implements ISlidingCard {
  final String title;
  final String subTitle;
  final String imageAsset;

  HotelCard({
    this.title,
    this.subTitle,
    this.imageAsset,
  });

  @override
  String cardTitle() => title;

  @override
  String cardSubTitle() => subTitle;

  @override
  String cardImageAsset() => imageAsset;
}

class EventCard implements ISlidingCard {
  final String title;
  final String subTitle;
  final String imageAsset;

  EventCard({
    this.title,
    this.subTitle,
    this.imageAsset,
  }
  );

  @override
  String cardTitle() => title;

  @override
  String cardSubTitle() => subTitle;

  @override
  String cardImageAsset() => imageAsset;
}
