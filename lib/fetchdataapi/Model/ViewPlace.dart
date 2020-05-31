class ViewPlace {
  String status;
  String message;
  String response;

  static List<GetViewPlace> getviewplace = new List();

  ViewPlace.map(dynamic obj) {
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

  ViewPlace.getuserid(dynamic obj) {
    getviewplace =
        obj.map<GetViewPlace>((json) => new GetViewPlace.fromJson(json)).toList();
  }
}

class GetViewPlace {
  final String place_lat ;
  final String place_long;


  GetViewPlace(
      {this.place_lat,
        this.place_long,
      });

  factory GetViewPlace.fromJson(Map<String, dynamic> jsonMap) {
    return GetViewPlace(
      place_lat: jsonMap['place_lat'],
      place_long: jsonMap['place_long'],

    );
  }
}
