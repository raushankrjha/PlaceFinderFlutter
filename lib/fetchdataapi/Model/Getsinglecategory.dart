class GetsingleCat {
  String status;
  String message;
  String response;

  static List<GetsingleCatItem> getsingleCatItem = new List();

  GetsingleCat.map(dynamic obj) {
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

  GetsingleCat.getuserid(dynamic obj) {
    getsingleCatItem =
        obj.map<GetsingleCatItem>((json) => new GetsingleCatItem.fromJson(json)).toList();
  }
}

class GetsingleCatItem {
  final String place_id;
  final String category_id;
  final String place_name;
  final String place_phone;
  final String place_address;
  final String place_city;
  final String place_lat;
  final String place_long;
  final String place_website;
  final String place_status;
  final String created_date;
  final String distance;
  final String rate;
  final String place_image;
  final String rate_count;
  final int is_liked;
  final String my_rate;

  GetsingleCatItem(
      {this.place_id,
      this.category_id,
      this.place_name,
      this.place_phone,
      this.place_address,
      this.place_city,
      this.place_lat,
      this.place_long,
      this.place_website,
      this.place_status,
      this.created_date,
      this.distance,
      this.rate,this.rate_count,
        this.is_liked,
      this.place_image,this.my_rate});

  factory GetsingleCatItem.fromJson(Map<String, dynamic> jsonMap) {
    return GetsingleCatItem(
      place_id: jsonMap['place_id'],
      category_id: jsonMap['category_id'],
      place_name: jsonMap['place_name'],
      place_phone: jsonMap['place_phone'],
      place_address: jsonMap['place_address'],
      place_city: jsonMap['place_city'],
      place_lat: jsonMap['place_lat'],
      place_long: jsonMap['place_long'],
      place_website: jsonMap['place_website'],
      place_status: jsonMap['place_status'],
      created_date: jsonMap['created_date'],
      distance: jsonMap['distance'],
      rate: jsonMap['rate'],
      rate_count:jsonMap['rate_count'],
      place_image: jsonMap['place_image'],
        is_liked:jsonMap['is_liked'],
        my_rate:jsonMap['my_rate']
    );
  }
}
