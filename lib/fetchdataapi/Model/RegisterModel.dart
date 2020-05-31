class RegisterModel{

final String name;
final String phone;
final String email;
final String password;
final String token;
final String id;
final String profile_pic;
final String lat;
final String long;
final String city;
final String address;

RegisterModel.fromJSON(Map<String, dynamic> jsonMap)
    : name = jsonMap['user_name'],
      phone = jsonMap['user_phone'],
      password = jsonMap['user_password'],
      token = jsonMap['user_token'],
      id=jsonMap['user_id'],

      profile_pic=jsonMap['user_profile_pic'],
      lat=jsonMap['user_lat'],
      long=jsonMap['user_long'],
      city=jsonMap['user_city'],
      address=jsonMap['user_address'],

      email = jsonMap['user_email'];

}