

class GetCat {
  String status;
  String message;
  String response;

  static List<GetCatItem> homeGetCatlist=new List();

  GetCat.map(dynamic obj) {
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
  GetCat.getuserid(dynamic obj) {
    homeGetCatlist = obj.map<GetCatItem>((json) => new GetCatItem.fromJson(json)).toList();

  }
}




class GetCatItem
{

  final String  category_id;
  final String category_name;
  final String category_image;







  GetCatItem({ this.category_id, this.category_image, this.category_name,
    });



  factory GetCatItem.fromJson(Map<String, dynamic> jsonMap){



    return GetCatItem(
      category_id : jsonMap['category_id'],
      category_image:   jsonMap['category_image'],
      category_name:   jsonMap['category_name'],



    );


  }


}

