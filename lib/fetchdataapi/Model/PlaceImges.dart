class PlaceImages {
  String status;
  String message;
  String response;

  static List<GetPlaceImages> getplaceimages = new List();

  PlaceImages.map(dynamic obj) {
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

  PlaceImages.getuserid(dynamic obj) {
    getplaceimages =
        obj.map<GetPlaceImages>((json) => new GetPlaceImages.fromJson(json)).toList();
  }
}
















class GetPlaceImages {
  final String place_image;
  final String is_primary;


  GetPlaceImages(
      {this.place_image,
        this.is_primary,
        });

  factory GetPlaceImages.fromJson(Map<String, dynamic> jsonMap) {
    return GetPlaceImages(
      place_image: jsonMap['place_image'],
      is_primary: jsonMap['is_primary'],

    );
  }
}
