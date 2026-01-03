// // class DarshanModel {
// //   final String id;
// //   final String title;
// //   final String liveLink;
// //
// //   final String subtitle;
// //   final String description;
// //   final String image;
// //
// //   final String? mobile_image;
// //   final DateTime createdAt;
// //
// //   // 🔥 SINGLE SOURCE OF TRUTH
// //   final String status; // "ACTIVE" | "INACTIVE"
// //
// //   DarshanModel({
// //     required this.id,
// //     required this.title,
// //     required this.liveLink,
// //     required this.subtitle,
// //     required this.description,
// //     required this.image,
// //     this.mobile_image,
// //     required this.createdAt,
// //     required this.status,
// //   });
// //
// //   // ✅ DERIVED VALUE (NO FIELD)
// //   bool get isLive => status == "ACTIVE";
// //
// //   DarshanModel copyWith({
// //     String? title,
// //     String? liveLink,
// //     String? mobile_image,
// //     String? status,
// //     //String? image,
// //   }) {
// //     return DarshanModel(
// //       id: id,
// //       title: title ?? this.title,
// //       liveLink: liveLink ?? this.liveLink,
// //       subtitle: subtitle,
// //       description: description,
// //       image: image,
// //       mobile_image: mobile_image ?? this.mobile_image,
// //       createdAt: createdAt,
// //       status: status ?? this.status,
// //     );
// //   }
// //
// //   factory DarshanModel.fromJson(Map<String, dynamic> json) {
// //     return DarshanModel(
// //       id: json['_id'],
// //       title: json['title'] ?? "",
// //       liveLink: json['embeddedLink'] ?? "",
// //       subtitle: "",
// //       description: "",
// //       image: json['image'] ?? "",
// //       mobile_image: json['mobile_image'],
// //       createdAt: DateTime.parse(json['createdAt']),
// //       status: json['status'] ?? "INACTIVE",
// //     );
// //   }
// // }
//
//
// // ========================================
// // 1. DARSHAN MODEL (live_darshan_model.dart)
// // ========================================
// class DarshanModel {
//   final String id;
//   final String title;
//   final String embeddedLink;
//   final String status; // "ACTIVE" | "INACTIVE"
//   final String mobileImage;
//   final DateTime createdAt;
//
//   DarshanModel({
//     required this.id,
//     required this.title,
//     required this.embeddedLink,
//     required this.status,
//     required this.mobileImage,
//     required this.createdAt,
//   });
//
//   // Derived property
//   bool get isLive => status == "ACTIVE";
//
//   // FROM JSON
//   factory DarshanModel.fromJson(Map<String, dynamic> json) {
//     return DarshanModel(
//       id: json["_id"] ?? "",
//       title: json["title"] ?? "",
//       embeddedLink: json["embeddedLink"] ?? "",
//       status: json["status"] ?? "INACTIVE",
//       mobileImage: json["mobile_image"] ?? "",
//       createdAt: json["createdAt"] != null
//           ? DateTime.parse(json["createdAt"])
//           : DateTime.now(),
//     );
//   }
//
//   // TO JSON
//   Map<String, dynamic> toJson() {
//     return {
//       "title": title,
//       "embeddedLink": embeddedLink,
//       "status": status,
//       "mobile_image": mobileImage,
//     };
//   }
//
//   // COPY WITH
//   DarshanModel copyWith({
//     String? title,
//     String? embeddedLink,
//     String? status,
//     String? mobileImage,
//   }) {
//     return DarshanModel(
//       id: id,
//       title: title ?? this.title,
//       embeddedLink: embeddedLink ?? this.embeddedLink,
//       status: status ?? this.status,
//       mobileImage: mobileImage ?? this.mobileImage,
//       createdAt: createdAt,
//     );
//   }
// }

// ========================================
// 1. DARSHAN MODEL (live_darshan_model.dart)
// ========================================
class DarshanModel {
  final String id;
  final String title;
  final String embeddedLink;
  final String status; // "ACTIVE" | "INACTIVE"
  final String mobileImage;
  final DateTime createdAt;

  DarshanModel({
    required this.id,
    required this.title,
    required this.embeddedLink,
    required this.status,
    required this.mobileImage,
    required this.createdAt,
  });

  // Derived property
  bool get isLive => status == "ACTIVE";

  // FROM JSON
  factory DarshanModel.fromJson(Map<String, dynamic> json) {
    return DarshanModel(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      embeddedLink: json["embeddedLink"] ?? "",
      status: json["status"] ?? "INACTIVE",
      mobileImage: json["mobile_image"] ?? "",
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : DateTime.now(),
    );
  }

  // TO JSON
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "embeddedLink": embeddedLink,
      "status": status,
      "mobile_image": mobileImage,
    };
  }

  // COPY WITH
  DarshanModel copyWith({
    String? title,
    String? embeddedLink,
    String? status,
    String? mobileImage,
  }) {
    return DarshanModel(
      id: id,
      title: title ?? this.title,
      embeddedLink: embeddedLink ?? this.embeddedLink,
      status: status ?? this.status,
      mobileImage: mobileImage ?? this.mobileImage,
      createdAt: createdAt,
    );
  }
}
class DarshanModel2 {
  final String id;
  final String title;
  final String embeddedLink;
  final String status; // "ACTIVE" | "INACTIVE"
  final String mobileImage;
  final DateTime createdAt;

  DarshanModel2({
    required this.id,
    required this.title,
    required this.embeddedLink,
    required this.status,
    required this.mobileImage,
    required this.createdAt,
  });

  // Derived property
  bool get isLive => status == "ACTIVE";

  // FROM JSON
  factory DarshanModel2.fromJson(Map<String, dynamic> json) {
    return DarshanModel2(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      embeddedLink: json["embeddedLink"] ?? "",
      status: json["status"] ?? "INACTIVE",
      mobileImage: json["mobile_image"] ?? "",
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : DateTime.now(),
    );
  }

  // TO JSON
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "embeddedLink": embeddedLink,
      "status": status,
      "mobile_image": mobileImage,
    };
  }

  // COPY WITH
  DarshanModel copyWith({
    String? title,
    String? embeddedLink,
    String? status,
    String? mobileImage,
  }) {
    return DarshanModel(
      id: id,
      title: title ?? this.title,
      embeddedLink: embeddedLink ?? this.embeddedLink,
      status: status ?? this.status,
      mobileImage: mobileImage ?? this.mobileImage,
      createdAt: createdAt,
    );
  }
}