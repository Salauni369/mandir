// // import 'live_darshan_model.dart';
// //
// // class TempleHomeModel {
// //   final String id;
// //   final String templeId;
// //   final String name;
// //   final String image;
// //   List<String> galleryImages;
// //   final List<String> banner;
// //   final String about;
// //   final String contactNumber;
// //
// //   final Map<String, dynamic> timings;
// //   final Map<String, String> location;
// //
// //   final List<dynamic> donation;
// //
// //
// //   // 🔥 THIS WAS MISSING
// //   final List<DarshanModel> liveDarshan;
// //
// //   TempleHomeModel({
// //     required this.id,
// //     required this.templeId,
// //     required this.name,
// //     required this.image,
// //     required this.galleryImages,
// //     required this.banner,
// //     required this.about,
// //     required this.contactNumber,
// //     required this.timings,
// //     required this.location,
// //     required this.liveDarshan,
// //     required this.donation
// //   });
// //
// //   factory TempleHomeModel.fromJson(Map<String, dynamic> json) {
// //     final data = json["data"] ?? json;
// //     final temple = data["user"]?["temple"] ?? {};
// //     final galleryData = data["user"]?["temple"]["gallery_images"] ?? {};
// //
// //     return TempleHomeModel(
// //       id: temple["_id"] ?? "",
// //       templeId: temple["temple_id"] ?? "",
// //       name: temple["name"] ?? "",
// //       image: temple["image"] ?? "",
// //       about: temple["about"] ?? "",
// //       contactNumber: temple["contact_number"] ?? "",
// //       timings: temple["timings"] ?? {},
// //
// //       galleryImages: List<String>.from(galleryData.map((x) => x)),
// //       banner: [],
// //
// //       location: {
// //         "city": temple["location"]?["city"]?["name"] ?? "",
// //         "state": temple["location"]?["state"]?["name"] ?? "",
// //         "country": temple["location"]?["country"]?["name"] ?? "",
// //         "latitude": temple["location"]?["latitude"]?.toString() ?? "",
// //         "longitude": temple["location"]?["longitude"]?.toString() ?? "",
// //       },
// //
// //       // ✅ FIXED
// //       donation: List.from(data["donation"] ?? []),
// //
// //       // ✅ LIVE DARSHAN
// //       liveDarshan: (data["liveDarshan"] as List? ?? [])
// //           .map((e) => DarshanModel.fromJson(e))
// //           .toList(),
// //     );
// //   }
// // }
//
// import 'live_darshan_model.dart';
//
// class TempleHomeModel {
//   final String id;
//   final String templeId;
//   final String name;
//   final String image;
//   List<String> galleryImages;
//   final List<String> banner;
//   final String about;
//   final String contactNumber;
//
//   final Map<String, dynamic> timings;
//   final Map<String, String> location;
//
//   final List<dynamic> donation;
//
//   // 🔥 LIVE DARSHAN
//   final List<DarshanModel> liveDarshan;
//
//   // 🔥 NEW: ADDITIONAL INFO
//   List<AdditionalInfo> additionalInfo;
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
//     required this.liveDarshan,
//     required this.donation,
//     required this.additionalInfo,  // ← added
//   });
//
//   factory TempleHomeModel.fromJson(Map<String, dynamic> json) {
//     final data = json["data"] ?? json;
//     final temple = data["user"]?["temple"] ?? {};
//     // final galleryData = temple["gallery_images"] ?? {};
//     final additionalInfo = temple["additional_info"] ?? {};
//
//     return TempleHomeModel(
//       id: temple["_id"] ?? "",
//       templeId: temple["temple_id"] ?? "",
//       name: temple["name"] ?? "",
//       image: temple["image"] ?? "",
//       about: temple["about"] ?? "",
//       contactNumber: temple["contact_number"] ?? "",
//       timings: temple["timings"] ?? {},
//
//       galleryImages: List<String>.from(temple["gallery_images"] ?? []),
//       banner: List<String>.from(temple["gallery_images"] ?? []),
//
//       location: {
//         "city": temple["location"]?["city"]?["name"] ?? "",
//         "state": temple["location"]?["state"]?["name"] ?? "",
//         "country": temple["location"]?["country"]?["name"] ?? "",
//         "latitude": temple["location"]?["latitude"]?.toString() ?? "",
//         "longitude": temple["location"]?["longitude"]?.toString() ?? "",
//       },
//
//       donation: List.from(data["donation"] ?? []),
//
//       liveDarshan: (data["liveDarshan"] as List? ?? [])
//           .map((e) => DarshanModel.fromJson(e))
//           .toList(),
//
//       // 🔥 ADDITIONAL INFO PARSED
//       additionalInfo: additionalInfo == null ? [] : List<AdditionalInfo>.from(additionalInfo!.map((x) => AdditionalInfo.fromJson(x))),
//     );
//   }
// }
// class AdditionalInfo {
//   String? title;
//   String? content;
//   String? id;
//
//   AdditionalInfo({
//     this.title,
//     this.content,
//     this.id,
//   });
//
//   factory AdditionalInfo.fromJson(Map<String, dynamic> json) => AdditionalInfo(
//     title: json["title"],
//     content: json["content"],
//     id: json["_id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "title": title,
//     "content": content,
//     "_id": id,
//   };
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

  // DONATION – temple ke andar hai
  final List<Map<String, dynamic>> donation;

  // LIVE DARSHAN
  final List<DarshanModel> liveDarshan;

  // ADDITIONAL INFO
  final List<AdditionalInfo> additionalInfo;

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
  });

  factory TempleHomeModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"] ?? json;
    final temple = data["user"]?["temple"] ?? {};
    final galleryObj = temple["gallery_images"] ?? {};

    // SAFE GALLERY PARSING – galleryObj ek map hai, uske andar "gallery" aur "banner" array hain
    final List<String> parsedGallery = [];
    final List<String> parsedBanner = [];

    if (galleryObj is Map) {
      final rawGallery = galleryObj["gallery"] ?? [];
      final rawBanner = galleryObj["banner"] ?? [];

      if (rawGallery is List) {
        parsedGallery.addAll(rawGallery.whereType<String>());
      }
      if (rawBanner is List) {
        parsedBanner.addAll(rawBanner.whereType<String>());
      }
    }

    // SAFE ADDITIONAL INFO
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

      // DONATION – temple ke andar hai
      donation: (temple["donation"] as List?)
          ?.map((e) => Map<String, dynamic>.from(e as Map))
          .toList() ??
          [],

      liveDarshan: (data["liveDarshan"] as List? ?? [])
          .map((e) => DarshanModel.fromJson(e as Map<String, dynamic>))
          .toList(),

      additionalInfo: parsedAdditional,
    );
  }
}

// ADDITIONAL INFO MODEL
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

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "content": content,
    };
  }
}