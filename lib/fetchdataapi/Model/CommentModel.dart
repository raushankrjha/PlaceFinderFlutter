class CommentModel{

final String user_name;
final String user_profile_pic;
final String review_id;
final String user_id;
final String place_id;
final String review_text;
final String review_status;
final String created_date;



CommentModel.fromJSON(Map<String, dynamic> jsonMap)
    : user_profile_pic = jsonMap['user_profile_pic'],
      review_id = jsonMap['review_id'],
      user_id = jsonMap['user_id'],
      place_id = jsonMap['place_id'],
      review_text = jsonMap['review_text'],
      review_status = jsonMap['review_status'],
      created_date = jsonMap['created_date'],
      user_name = jsonMap['user_name'];
}