
import 'package:flutter_app/fetchdataapi/Model/RegisterModel.dart';

class SearchList {
  String status;
  String message;
  String response;

  static List<GetSearchList> searchlist = new List();

  SearchList.map(dynamic obj) {
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

  SearchList.getuserid(dynamic obj) {
    searchlist =
        obj.map<GetSearchList>((json) => new GetSearchList.fromJson(json)).toList();
  }
}

class GetSearchList {

  final String place_city;
  final String place_id;
  final String place_name;
  final String distance;




  GetSearchList(
      {
        this.place_city,
        this.place_id,
        this.place_name,
        this.distance

      }
      );

  factory GetSearchList.fromJson(Map<String, dynamic> jsonMap)
  {
    return GetSearchList(
        place_city : jsonMap['place_city'],
      place_id : jsonMap['place_id'],
      place_name : jsonMap['place_name'],
      distance : jsonMap['distance'],

    );
  }
}
