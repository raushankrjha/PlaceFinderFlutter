
import 'package:flutter_app/fetchdataapi/Model/RegisterModel.dart';

class RegisterMaps {
  String status;
  String message;
  String response;

  static List<RegisterModel> list=new List();

  RegisterMaps.map(dynamic obj) {
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
  RegisterMaps.getuserid(dynamic obj) {
    list = obj.map<RegisterModel>((json) => new RegisterModel.fromJSON(json)).toList();
  }
}