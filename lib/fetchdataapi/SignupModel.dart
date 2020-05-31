

import 'package:flutter/material.dart';

class Registers{

  String status;
  String message;
  String response;

   List<GetRegisters> fullsearch = new List();

  Registers.map(dynamic obj) {
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

  Registers.getuserid(dynamic obj) {
    fullsearch =
        obj.map<GetRegisters>((json) => new GetRegisters.fromJson(json)).toList();
  }
}



class User {

  String message;


  List<GetRegisters> userlist;

  User({
    this.message,
    this.userlist,

  });

  factory User.fromJson(Map<String, dynamic> json) {



    var list = json['result'] as List;
    print(list.runtimeType);
    List<GetRegisters> imagesList = list.map((i) => GetRegisters.fromJson(i)).toList();


    return new User(
        message: json['message'],
        userlist: imagesList
    );
  }
}





class GetRegisters {

  final String user_token;
  final String user_email;
  final String user_password;
  final String user_id;
  final String user_name;
  final String user_profile_pic;
  final String user_notification_status;

  GetRegisters({ this.user_token, this.user_profile_pic, this.user_email,
    this.user_name,this.user_id,
    this.user_password,this.user_notification_status});



    factory GetRegisters.fromJson(Map<String, dynamic> jsonMap){
      return GetRegisters(user_token : jsonMap['user_token'],
          user_email : jsonMap['user_email'],
          user_name: jsonMap['user_name'],
          user_password : jsonMap['user_password'],
          user_id: jsonMap['user_id'],
          user_profile_pic : jsonMap['user_profile_pic'],
          user_notification_status:jsonMap['user_notification_status']);


    }


}





