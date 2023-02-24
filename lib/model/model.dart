class Model {
  dynamic id;
  String? name;
  String? masged;
  String? location;
  double? latitude;
  double? longitude;
  String? date;
  String? time;

  Model(
      { required this.id, required this.name, required this.masged, required this.location, required this.latitude, required this.longitude, required this.date, required this.time});

  Model.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    masged = json['masged'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['masged'] = this.masged;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;


  }


}
// Map<String, Object> message = {
// 'notification': {
// 'title': 'New post added',
// 'body': state.title,
// },
// 'data': {
// 'postId': postRef.id,
// },
// 'topic': 'new-posts',
// };