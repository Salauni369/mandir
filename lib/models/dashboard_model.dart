class TempleHomeModel {
  final String id;
  final String templeId;
  final String name;
  final String image;
  final List<String> gallery;
  final List<String> banner;
  final String about;
  final String contactNumber;
  final Map<String, dynamic> timings;
  final Map<String, String> location;

  TempleHomeModel({
    required this.id,
    required this.templeId,
    required this.name,
    required this.image,
    required this.gallery,
    required this.banner,
    required this.about,
    required this.contactNumber,
    required this.timings,
    required this.location,
  });

  factory TempleHomeModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"]?["data"] ?? json["data"] ?? json;

    final galleryData = data["gallery_images"] ?? {};

    return TempleHomeModel(
      id: data["_id"] ?? "",
      templeId: data["temple_id"] ?? "",
      name: data["name"] ?? "",
      image: data["image"] ?? "",
      about: data["about"] ?? "",
      contactNumber: data["contact_number"] ?? "",
      timings: data["timings"] ?? {},
      gallery: List<String>.from(galleryData["gallery"] ?? []),
      banner: List<String>.from(galleryData["banner"] ?? []),
      location: {
        "city": data["location"]?["city"]?["name"] ?? "",
        "state": data["location"]?["state"]?["name"] ?? "",
        "country": data["location"]?["country"]?["name"] ?? "",
        "latitude": data["location"]?["latitude"] ?? "",
        "longitude": data["location"]?["longitude"] ?? "",
      },
    );
  }
}
