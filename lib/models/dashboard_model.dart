//
// import 'live_darshan_model.dart';
//
// class TempleHomeModel {
//   final String id;
//   final String templeId;
//   final String name;
//   final String image;
//   final List<String> galleryImages;
//   final List<String> banner;
//   final String about;
//   final String contactNumber;
//   final String socialLinks;
//
//   final Map<String, dynamic> timings;
//   final Map<String, String> location;
//
//   // DONATION – temple ke andar hai
//   final List<Map<String, dynamic>> donation;
//
//   // LIVE DARSHAN
//   final List<DarshanModel> liveDarshan;
//
//   // ADDITIONAL INFO
//   final List<AdditionalInfo> additionalInfo;
// // social
//   final Map<String, String> socialLinks;
//
//
//   TempleHomeModel({
//     required this.id,
//     required this.templeId,
//     required this.name,
//     required this.image,
//     required this.galleryImages,
//     required this.banner,
//     required this.about,
//     required this.contactNumber,
//     required this.timings,
//     required this.location,
//     required this.donation,
//     required this.liveDarshan,
//     required this.additionalInfo,
//     required this.socialLinks
//   });
//
//   final social = temple["social_links"] ?? {};
//
//   final Map<String, String> parsedSocial = {
//     "facebook": social["facebook"] ?? "",
//     "instagram": social["instagram"] ?? "",
//     "youtube": social["youtube"] ?? "",
//     "linkedin": social["linkedIn"] ?? "",
//   };
//
//
//
//   factory TempleHomeModel.fromJson(Map<String, dynamic> json) {
//     final data = json["data"] ?? json;
//     final temple = data["user"]?["temple"] ?? {};
//     final galleryObj = temple["gallery_images"] ?? {};
//
//     // SAFE GALLERY PARSING – galleryObj ek map hai, uske andar "gallery" aur "banner" array hain
//     final List<String> parsedGallery = [];
//     final List<String> parsedBanner = [];
//
//     if (galleryObj is Map) {
//       final rawGallery = galleryObj["gallery"] ?? [];
//       final rawBanner = galleryObj["banner"] ?? [];
//
//       if (rawGallery is List) {
//         parsedGallery.addAll(rawGallery.whereType<String>());
//       }
//       if (rawBanner is List) {
//         parsedBanner.addAll(rawBanner.whereType<String>());
//       }
//     }
//
//     // SAFE ADDITIONAL INFO
//     final List<AdditionalInfo> parsedAdditional = [];
//     final rawAdditional = temple["additional_info"] ?? [];
//     if (rawAdditional is List) {
//       parsedAdditional.addAll(
//         rawAdditional
//             .whereType<Map<String, dynamic>>()
//             .map((e) => AdditionalInfo.fromJson(e)),
//       );
//     }
//
//     return TempleHomeModel(
//       id: temple["_id"] ?? "",
//       templeId: temple["temple_id"] ?? "",
//       name: temple["name"] ?? "",
//       image: temple["image"] ?? "",
//       about: temple["about"] ?? "",
//       contactNumber: temple["contact_number"] ?? "",
//       timings: Map<String, dynamic>.from(temple["timings"] ?? {}),
//
//       galleryImages: parsedGallery,
//       banner: parsedBanner,
//
//       location: {
//         "city": temple["location"]?["city"]?["name"] ?? "",
//         "state": temple["location"]?["state"]?["name"] ?? "",
//         "country": temple["location"]?["country"]?["name"] ?? "",
//         "latitude": temple["location"]?["latitude"]?.toString() ?? "",
//         "longitude": temple["location"]?["longitude"]?.toString() ?? "",
//       },
//
//       // DONATION – temple ke andar hai
//       donation: (temple["donation"] as List?)
//           ?.map((e) => Map<String, dynamic>.from(e as Map))
//           .toList() ??
//           [],
//
//       liveDarshan: (data["liveDarshan"] as List? ?? [])
//           .map((e) => DarshanModel.fromJson(e as Map<String, dynamic>))
//           .toList(),
//
//       additionalInfo: parsedAdditional,
//
//
//       // social
//
//       socialLinks: parsedSocial,
//     );
//   }
// }
//
// // ADDITIONAL INFO MODEL
// class AdditionalInfo {
//   final String title;
//   final String content;
//   final String id;
//
//   AdditionalInfo({
//     required this.title,
//     required this.content,
//     required this.id,
//   });
//
//   factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
//     return AdditionalInfo(
//       title: json["title"] ?? "",
//       content: json["content"] ?? "",
//       id: json["_id"] ?? "",
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "title": title,
//       "content": content,
//     };
//   }
// }


import 'live_darshan_model.dart';

class TempleHomeModel {
  final String id;
  final String templeId;
  final String name;
  final String image;
  final List<String> galleryImages;
  final List<String> banner;
  final String about;
  final String contactNumber;

  final Map<String, dynamic> timings;
  final Map<String, String> location;

  // DONATION
  final List<Map<String, dynamic>> donation;

  // LIVE DARSHAN
  final List<DarshanModel> liveDarshan;

  // ADDITIONAL INFO
  final List<AdditionalInfo> additionalInfo;

  // ✅ SOCIAL LINKS (ONLY ONCE)
  final Map<String, String> socialLinks;

  TempleHomeModel({
    required this.id,
    required this.templeId,
    required this.name,
    required this.image,
    required this.galleryImages,
    required this.banner,
    required this.about,
    required this.contactNumber,
    required this.timings,
    required this.location,
    required this.donation,
    required this.liveDarshan,
    required this.additionalInfo,
    required this.socialLinks,
  });

  factory TempleHomeModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"] ?? json;
    final temple = data["user"]?["temple"] ?? {};

    // -------- SOCIAL LINKS (FIXED) --------
    final social = temple["social_links"] ?? {};
    final Map<String, String> parsedSocial = {
      "facebook": social["facebook"] ?? "",
      "instagram": social["instagram"] ?? "",
      "youtube": social["youtube"] ?? "",
      "linkedin": social["linkedin"] ?? "",
    };

    // -------- GALLERY --------
    final List<String> parsedGallery = [];
    final List<String> parsedBanner = [];

    final galleryObj = temple["gallery_images"];
    if (galleryObj is List) {
      parsedGallery.addAll(galleryObj.whereType<String>());
    }

    // -------- ADDITIONAL INFO --------
    final List<AdditionalInfo> parsedAdditional = [];
    final rawAdditional = temple["additional_info"] ?? [];
    if (rawAdditional is List) {
      parsedAdditional.addAll(
        rawAdditional
            .whereType<Map<String, dynamic>>()
            .map((e) => AdditionalInfo.fromJson(e)),
      );
    }

    return TempleHomeModel(
      id: temple["_id"] ?? "",
      templeId: temple["temple_id"] ?? "",
      name: temple["name"] ?? "",
      image: temple["image"] ?? "",
      about: temple["about"] ?? "",
      contactNumber: temple["contact_number"] ?? "",
      timings: Map<String, dynamic>.from(temple["timings"] ?? {}),
      galleryImages: parsedGallery,
      banner: parsedBanner,
      location: {
        "city": temple["location"]?["city"]?["name"] ?? "",
        "state": temple["location"]?["state"]?["name"] ?? "",
        "country": temple["location"]?["country"]?["name"] ?? "",
        "latitude": temple["location"]?["latitude"]?.toString() ?? "",
        "longitude": temple["location"]?["longitude"]?.toString() ?? "",
      },
      donation: (temple["donation"] as List? ?? [])
          .map((e) => Map<String, dynamic>.from(e))
          .toList(),
      liveDarshan: (data["liveDarshan"] as List? ?? [])
          .map((e) => DarshanModel.fromJson(e))
          .toList(),
      additionalInfo: parsedAdditional,

      // ✅ FINAL FIX
      socialLinks: parsedSocial,
    );
  }
}

// ---------------- ADDITIONAL INFO ----------------
class AdditionalInfo {
  final String title;
  final String content;
  final String id;

  AdditionalInfo({
    required this.title,
    required this.content,
    required this.id,
  });

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalInfo(
      title: json["title"] ?? "",
      content: json["content"] ?? "",
      id: json["_id"] ?? "",
    );
  }
}
