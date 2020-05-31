//import 'package:ebook/model/CommentModel.dart';
import 'package:flutter_app/fetchdataapi/Model/CommentModel.dart';

class CommentMaps {
  String status;
  String message;
  String response;

  static List<CommentModel> list=new List();

  CommentMaps.map(dynamic obj) {
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
  CommentMaps.getuserid(dynamic obj) {
    list = obj.map<CommentModel>((json) => new CommentModel.fromJSON(json)).toList();

  }
}