class LiveDarshanModel {
  final String id;
  final String title;
  final String link;
  final String image;
  final bool isLive;
  final String? date;

  LiveDarshanModel({
    required this.id,
    required this.title,
    required this.link,
    required this.image,
    required this.isLive,
    this.date,
  });

  factory LiveDarshanModel.fromJson(Map<String, dynamic> json) {
    return LiveDarshanModel(
      id: json['id'].toString(),
      title: json['title'] ?? "",
      link: json['link'] ?? "",
      image: json['image'] ?? "",
      isLive: json['isLive'] ?? false,
      date: json['date'], // optional hai, null allowed hai
    );
  }
}
