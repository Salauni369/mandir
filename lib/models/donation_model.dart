// // lib/models/daan_model.dart
// class DaanModel {
//   String id;
//   final String imageUrl;
//   final String title;
//   final String buttonLabel;
//   final String buttonUrl;
//   final DateTime? createdAt;
//
//   DaanModel({
//     required this.id,
//     required this.imageUrl,
//     required this.title,
//     required this.buttonLabel,
//     required this.buttonUrl,
//     this.createdAt,
//   });
//
//   // <- THIS is required by your service: DaanModel.fromJson(...)
//   factory DaanModel.fromJson(Map<String, dynamic> json) {
//     return DaanModel(
//       id: (json['_id'] ?? json['id'] ?? '').toString(),
//       imageUrl: json['image'] ?? json['imageUrl'] ?? '',
//       title: (json['title'] ?? json['description'] ?? '').toString(),
//       buttonLabel: (json['button_text'] ?? json['buttonLabel'] ?? '').toString(),
//       buttonUrl: (json['button_link'] ?? json['buttonUrl'] ?? '').toString(),
//       createdAt: json['createdAt'] != null
//           ? DateTime.tryParse(json['createdAt'].toString())
//           : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "_id": id,
//       "image": imageUrl,
//       "title": title,
//       "button_text": buttonLabel,
//       "button_link": buttonUrl,
//       if (createdAt != null) "createdAt": createdAt!.toIso8601String(),
//     };
//   }
//
//   DaanModel copyWith({
//     String? id,
//     String? imageUrl,
//     String? title,
//     String? buttonLabel,
//     String? buttonUrl,
//     DateTime? createdAt,
//   }) {
//     return DaanModel(
//       id: id ?? this.id,
//       imageUrl: imageUrl ?? this.imageUrl,
//       title: title ?? this.title,
//       buttonLabel: buttonLabel ?? this.buttonLabel,
//       buttonUrl: buttonUrl ?? this.buttonUrl,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }
// }

class DaanModel {
  final String id;
  final String image;
  final String buttonText;
  final String buttonLink;
  final String description;

  DaanModel({
    required this.id,
    required this.image,
    required this.buttonText,
    required this.buttonLink,
    required this.description,
  });

  /// -------------------------
  /// FROM JSON
  /// -------------------------
  factory DaanModel.fromJson(Map<String, dynamic> json) {
    return DaanModel(
      id: json["_id"] ?? "",
      image: json["image"] ?? "",
      buttonText: json["button_text"] ?? "",
      buttonLink: json["button_link"] ?? "",
      description: json["description"] ?? "",
    );
  }

  /// -------------------------
  /// TO JSON
  /// -------------------------
  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "button_text": buttonText,
      "button_link": buttonLink,
      "description": description,
    };
  }

  /// -------------------------
  /// COPY WITH (🔥 FIX)
  /// -------------------------
  DaanModel copyWith({
    String? id,
    String? image,
    String? buttonText,
    String? buttonLink,
    String? description,
  }) {
    return DaanModel(
      id: id ?? this.id,
      image: image ?? this.image,
      buttonText: buttonText ?? this.buttonText,
      buttonLink: buttonLink ?? this.buttonLink,
      description: description ?? this.description,
    );
  }
}

