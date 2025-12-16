import 'live_darshan_model.dart';

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

  final List<dynamic> donation;


  // 🔥 THIS WAS MISSING
  final List<DarshanModel> liveDarshan;

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
    required this.liveDarshan,
    required this.donation
  });

  factory TempleHomeModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"] ?? json;
    final temple = data["user"]?["temple"] ?? {};
    final galleryData = temple["gallery_images"] ?? {};

    return TempleHomeModel(
      id: temple["_id"] ?? "",
      templeId: temple["temple_id"] ?? "",
      name: temple["name"] ?? "",
      image: temple["image"] ?? "",
      about: temple["about"] ?? "",
      contactNumber: temple["contact_number"] ?? "",
      timings: temple["timings"] ?? {},

      gallery: List<String>.from(galleryData["gallery"] ?? []),
      banner: List<String>.from(galleryData["banner"] ?? []),

      location: {
        "city": temple["location"]?["city"]?["name"] ?? "",
        "state": temple["location"]?["state"]?["name"] ?? "",
        "country": temple["location"]?["country"]?["name"] ?? "",
        "latitude": temple["location"]?["latitude"]?.toString() ?? "",
        "longitude": temple["location"]?["longitude"]?.toString() ?? "",
      },

      // ✅ FIXED
      donation: List.from(data["donation"] ?? []),

      // ✅ LIVE DARSHAN
      liveDarshan: (data["liveDarshan"] as List? ?? [])
          .map((e) => DarshanModel.fromJson(e))
          .toList(),
    );
  }
}
