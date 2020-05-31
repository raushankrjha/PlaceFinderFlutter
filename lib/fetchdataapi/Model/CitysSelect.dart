
import 'package:flutter_app/fetchdataapi/Model/RegisterModel.dart';

class CitysSelect {
  String status;
  String message;
  String response;

  static List<CitysSelectList> searchlist = new List();

  CitysSelect.map(dynamic obj) {
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

  CitysSelect.getuserid(dynamic obj) {
    searchlist =
        obj.map<CitysSelectList>((json) => new CitysSelectList.fromJson(json)).toList();
  }
}

class CitysSelectList {

  final String place_city;




  CitysSelectList(
      {
        this.place_city

      }
      );

  factory CitysSelectList.fromJson(Map<String, dynamic> jsonMap)
  {
    return CitysSelectList(
      place_city : jsonMap['place_city'],

    );
  }
}
