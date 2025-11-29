class DaanModel {
  String? id;
  String imageUrl;
  String title;
  String description;
  String buttonLabel;
  String redirectUrl;

  DaanModel({
    this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.redirectUrl,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "imageUrl": imageUrl,
    "title": title,
    "description": description,
    "buttonLabel": buttonLabel,
    "redirectUrl": redirectUrl,
  };

  factory DaanModel.fromJson(Map<String, dynamic> json) => DaanModel(
    id: json["id"],
    imageUrl: json["imageUrl"],
    title: json["title"],
    description: json["description"],
    buttonLabel: json["buttonLabel"],
    redirectUrl: json["redirectUrl"],
  );
}