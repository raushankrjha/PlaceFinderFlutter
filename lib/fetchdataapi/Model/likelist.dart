class LikeList {
  String status;
  String message;
  String response;

  static List<GetLikeList> getLikeList = new List();

  LikeList.map(dynamic obj) {
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

  LikeList.getuserid(dynamic obj) {
    getLikeList =
        obj.map<GetLikeList>((json) => new GetLikeList.fromJson(json)).toList();
  }
}

class GetLikeList {
  final String place_id;
  final String category_id;
  final String category_name;
  final String place_name;
  final String place_image;
  final String   place_lat;
  final String place_long;
  final String distance;
  final String rate;
  final String rate_count;



  GetLikeList(
      {
        this.place_id,
        this.category_id,
        this.category_name,
        this.place_name,
        this.place_image,
        this.place_lat,
        this.place_long,
        this.distance,
        this.rate,
        this.rate_count,
      });

  factory GetLikeList.fromJson(Map<String, dynamic> jsonMap) {
    return GetLikeList(
      place_id: jsonMap['place_id'],
      category_id: jsonMap['category_id'],
      category_name: jsonMap['category_name'],
      place_name: jsonMap['place_name'],
      place_image: jsonMap['place_image'],
      place_lat: jsonMap['place_lat'],
      place_long: jsonMap['place_long'],
      distance: jsonMap['distance'],
      rate: jsonMap['rate'],
      rate_count: jsonMap['rate_count'],


    );
  }
}
