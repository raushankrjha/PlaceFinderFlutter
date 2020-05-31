
import 'package:flutter_app/fetchdataapi/Model/RegisterModel.dart';

  class Fullsearch {
  String status;
  String message;
  String response;

  static List<GetFullsearch> fullsearch = new List();

  Fullsearch.map(dynamic obj) {
    if (obj != null) {
      this.status = obj["status"];
      if (status == null) {
        this.status = obj["status_code"];
      }
      this.message = obj["message"];
      this.response =
      obj["response"] != null ? obj["response"].toString() : null;
    }
  }

  Fullsearch.getuserid(dynamic obj) {
    fullsearch =
        obj.map<GetFullsearch>((json) => new GetFullsearch.fromJson(json)).toList();
  }
}

class GetFullsearch {
  final String user_id;
  final String search;
  final String category_id;
  final String distance;
  final String city;



  GetFullsearch(
      {
        this.user_id,
        this.search,
        this.category_id,
        this.distance,
        this.city,



      });

  factory GetFullsearch.fromJson(Map<String, dynamic> jsonMap) {
    return GetFullsearch(
      user_id: jsonMap['user_id'],
      search: jsonMap['search'],
      category_id: jsonMap['category_id'],
      distance: jsonMap['distance'],
      city: jsonMap['city'],



    );
  }
}