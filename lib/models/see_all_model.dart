class SeeAllModel {
  String? title;
  String? duration;
  String? image;
  int? timestamp;
  bool? isFav;

  SeeAllModel({this.title, this.duration, this.image, this.timestamp});

  SeeAllModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    duration = json['duration'];
    image = json['image'];
    timestamp = json['timestamp'];
    isFav = json['isFav'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['duration'] = this.duration;
    data['image'] = this.image;
    data['timestamp'] = this.timestamp;
    data['isFav'] = this.isFav;
    return data;
  }
}
