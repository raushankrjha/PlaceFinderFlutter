
//import 'package:flutter_app/fetchdataapi/Model/RegisterModel.dart';

class EditProfile {
  String status;
  String message;
  String response;

  static List<GetEditProfile> geteditprofile = new List();

  EditProfile.map(dynamic obj) {
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

  EditProfile.getuserid(dynamic obj) {
    geteditprofile =
        obj.map<GetEditProfile>((json) => new GetEditProfile.fromJson(json)).toList();
  }
}

class GetEditProfile {
  final String user_id;
  final String user_name;
  final String user_password;
  final String user_phone;
  final String user_address;
  final String user_profile_pic;
  final String user_email;
  final String user_city;
  final String user_lat;
  final String user_long;
  final String user_max_distance;
  final String user_notification_status;
  final String user_token;


  GetEditProfile(
      {this.user_id,
        this.user_name,
        this.user_password,
        this.user_phone,
        this.user_address,
        this.user_city,
        this.user_lat,
        this.user_long,
        this.user_max_distance,
        this.user_notification_status,
        this.user_token,
        this.user_email,
        this.user_profile_pic

      });

  factory GetEditProfile.fromJson(Map<String, dynamic> jsonMap) {
    return GetEditProfile(
      user_id: jsonMap['user_id'],
      user_name: jsonMap['user_name'],
      user_password: jsonMap['user_password'],
      user_phone: jsonMap['user_phone'],
      user_address: jsonMap['user_address'],
      user_city: jsonMap['user_city'],
      user_lat: jsonMap['user_lat'],
      user_long: jsonMap['user_long'],
      user_max_distance: jsonMap['user_max_distance'],
      user_notification_status: jsonMap['user_notification_status'],
      user_token: jsonMap['user_token'],
      user_profile_pic: jsonMap['user_profile_pic'],
        user_email:jsonMap['user_email'],
    );
  }
}
