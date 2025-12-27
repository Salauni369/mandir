// // // lib/models/daan_model.dart
// // class DaanModel {
// //   String id;
// //   final String imageUrl;
// //   final String title;
// //   final String buttonLabel;
// //   final String buttonUrl;
// //   final DateTime? createdAt;
// //
// //   DaanModel({
// //     required this.id,
// //     required this.imageUrl,
// //     required this.title,
// //     required this.buttonLabel,
// //     required this.buttonUrl,
// //     this.createdAt,
// //   });
// //
// //   // <- THIS is required by your service: DaanModel.fromJson(...)
// //   factory DaanModel.fromJson(Map<String, dynamic> json) {
// //     return DaanModel(
// //       id: (json['_id'] ?? json['id'] ?? '').toString(),
// //       imageUrl: json['image'] ?? json['imageUrl'] ?? '',
// //       title: (json['title'] ?? json['description'] ?? '').toString(),
// //       buttonLabel: (json['button_text'] ?? json['buttonLabel'] ?? '').toString(),
// //       buttonUrl: (json['button_link'] ?? json['buttonUrl'] ?? '').toString(),
// //       createdAt: json['createdAt'] != null
// //           ? DateTime.tryParse(json['createdAt'].toString())
// //           : null,
// //     );
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     return {
// //       "_id": id,
// //       "image": imageUrl,
// //       "title": title,
// //       "button_text": buttonLabel,
// //       "button_link": buttonUrl,
// //       if (createdAt != null) "createdAt": createdAt!.toIso8601String(),
// //     };
// //   }
// //
// //   DaanModel copyWith({
// //     String? id,
// //     String? imageUrl,
// //     String? title,
// //     String? buttonLabel,
// //     String? buttonUrl,
// //     DateTime? createdAt,
// //   }) {
// //     return DaanModel(
// //       id: id ?? this.id,
// //       imageUrl: imageUrl ?? this.imageUrl,
// //       title: title ?? this.title,
// //       buttonLabel: buttonLabel ?? this.buttonLabel,
// //       buttonUrl: buttonUrl ?? this.buttonUrl,
// //       createdAt: createdAt ?? this.createdAt,
// //     );
// //   }
// // }
// //
// // class DaanModel {
// //   final String id;
// //   final String image;
// //   final String buttonText;
// //   final String buttonLink;
// //   final String donation_title;
// //
// //   DaanModel({
// //     required this.id,
// //     required this.image,
// //     required this.buttonText,
// //     required this.buttonLink,
// //     required this.donation_title,
// //   });
// //
// //   /// -------------------------
// //   /// FROM JSON
// //   /// -------------------------
// //   factory DaanModel.fromJson(Map<String, dynamic> json) {
// //     return DaanModel(
// //       id: json["_id"] ?? "",
// //       image: json["image"] ?? "",
// //       buttonText: json["button_text"] ?? "",
// //       buttonLink: json["button_link"] ?? "",
// //       donation_title: json["donation_title"] ?? "",
// //     );
// //   }
// //
// //   /// -------------------------
// //   /// TO JSON
// //   /// -------------------------
// //   Map<String, dynamic> toJson() {
// //     return {
// //       "image": image,
// //       "button_text": buttonText,
// //       "button_link": buttonLink,
// //       "description": donation_title,
// //     };
// //   }
// //
// //   /// -------------------------
// //   /// COPY WITH (🔥 FIX)
// //   /// -------------------------
// //   DaanModel copyWith({
// //     String? id,
// //     String? image,
// //     String? buttonText,
// //     String? buttonLink,
// //     String? donation_title,
// //   }) {
// //     return DaanModel(
// //       id: id ?? this.id,
// //       image: image ?? this.image,
// //       buttonText: buttonText ?? this.buttonText,
// //       buttonLink: buttonLink ?? this.buttonLink,
// //       donation_title: donation_title ?? this.donation_title,
// //     );
// //   }
// // }
// //
// //
// // class DaanModel {
// //   final String id;
// //   final String image;
// //   final String buttonText;
// //   final String buttonLink;
// //   final String donation_title;  // description ke jagah ye use kar rahe ho
// //
// //   DaanModel({
// //     required this.id,
// //     required this.image,
// //     required this.buttonText,
// //     required this.buttonLink,
// //     required this.donation_title,
// //   });
// // //    get vaale names
// //   factory DaanModel.fromJson(Map<String, dynamic> json) {
// //     return DaanModel(
// //       id: json["_id"] ?? "",
// //       image: json["image"] ?? "",
// //       buttonText: json["button_text"] ?? "",
// //       buttonLink: json["button_link"] ?? "",
// //       donation_title: json["description"] ?? "",  // API mein "description" hai
// //     );
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     return {
// //       "image": image,
// //       "button_text": buttonText,
// //       "button_link": buttonLink,
// //       "description": donation_title,
// //     };
// //   }
// //
// //   DaanModel copyWith({
// //     String? id,
// //     String? image,
// //     String? buttonText,
// //     String? buttonLink,
// //     String? donation_title,
// //   }) {
// //     return DaanModel(
// //       id: id ?? this.id,
// //       image: image ?? this.image,
// //       buttonText: buttonText ?? this.buttonText,
// //       buttonLink: buttonLink ?? this.buttonLink,
// //       donation_title: donation_title ?? this.donation_title,
// //     );
// //   }
// // }
//
//
// // ========================================
// // MODEL (donation_model.dart) - NO CHANGES NEEDED
// // ========================================
// class DaanModel {
//   final String id;
//   final String image;
//   final String buttonText;
//   final String buttonLink;
//   final String donation_title;
//
//   DaanModel({
//     required this.id,
//     required this.image,
//     required this.buttonText,
//     required this.buttonLink,
//     required this.donation_title,
//   });
//
//   factory DaanModel.fromJson(Map<String, dynamic> json) {
//     return DaanModel(
//       id: json["_id"] ?? "",
//       image: json["image"] ?? json["mobile_image"] ?? "",
//       buttonText: json["button_text"] ?? json["button_label"] ?? "",
//       buttonLink: json["button_link"] ?? json["button_url"] ?? "",
//       donation_title: json["description"] ?? json["donation_title"] ?? "",
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "mobile_image": image,
//       "donation_title": donation_title,
//       "button_label": buttonText,
//       "button_url": buttonLink,
//     };
//   }
//
//   DaanModel copyWith({
//     String? id,
//     String? image,
//     String? buttonText,
//     String? buttonLink,
//     String? donation_title,
//   }) {
//     return DaanModel(
//       id: id ?? this.id,
//       image: image ?? this.image,
//       buttonText: buttonText ?? this.buttonText,
//       buttonLink: buttonLink ?? this.buttonLink,
//       donation_title: donation_title ?? this.donation_title,
//     );
//   }
// }
class DaanModel {
  final String id;
  final String description;
  final String button_text;
  final String button_link;
  final String image;

  DaanModel({
    required this.id,
    required this.description,
    required this.button_text,
    required this.button_link,
    required this.image,
  });

  // =========================
  // TO JSON (For API Request)
  // =========================
  Map<String, dynamic> toJson() {
    return {
      "donation_title": description,
      "button_label": button_text,
      "button_url": button_link,
      "mobile_image": image,
    };
  }

  // =========================
  // FROM JSON (From API Response)
  // =========================
  factory DaanModel.fromJson(Map<String, dynamic> json) {
    return DaanModel(
      id: json["_id"] ?? json["id"] ?? "",
      description: json["description"] ?? "",
      button_text: json["button_text"] ?? json["button_text"] ?? "",
      button_link: json["button_link"] ?? json["button_link"] ?? "",
      image: json["image"] ?? json["image"] ?? "",
    );
  }

  // =========================
  // COPY WITH (For Updates)
  // =========================
  DaanModel copyWith({
    String? id,
    String? donation_title,
    String? buttonText,
    String? buttonLink,
    String? image,
  }) {
    return DaanModel(
      id: id ?? this.id,

            description: donation_title ?? this.description,
      button_text: buttonText ?? this.button_text,
      button_link: buttonLink ?? this.button_link,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'DaanModel(id: $id, title: $description, button_text: $button_text, button_link: $button_link, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DaanModel &&
        other.id == id &&
        other.description == description &&
        other.button_text == button_text &&
        other.button_link == button_link &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    description.hashCode ^
    button_text.hashCode ^
    button_link.hashCode ^
    image.hashCode;
  }
}