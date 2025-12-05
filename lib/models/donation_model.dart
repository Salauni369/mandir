// class DaanModel {
//   String id;
//   final String imageUrl;
//   final String title;
//   final String buttonLabel;
//   final String buttonUrl;
//   final DateTime createdAt;
//
//   DaanModel({
//     required this.id,
//     required this.imageUrl,
//     required this.title,
//     required this.buttonLabel,
//     required this.buttonUrl,
//     required this.createdAt,
//   });
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
//
//   factory DaanModel.fromJson(Map<String, dynamic> json) => DaanModel(
//     id: json['id'] as String,
//     imageUrl: json['imageUrl'] as String,
//     title: json['title'] as String,
//     buttonLabel: json['buttonLabel'] as String,
//     buttonUrl: json['buttonUrl'] as String,
//     createdAt: DateTime.parse(json['createdAt'] as String),
//   );
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'imageUrl': imageUrl,
//     'title': title,
//     'buttonLabel': buttonLabel,
//     'buttonUrl': buttonUrl,
//     'createdAt': createdAt.toIso8601String(),
//   };
// }

// lib/models/daan_model.dart  ← YE EK HI FILE RAKHNA
class DaanModel {
   String id;
  final String imageUrl;
  final String title;           // ← YE HONA CHAHIYE
  final String buttonLabel;     // ← YE BHI
  final String buttonUrl;       // ← YE BHI
  final DateTime createdAt;

  DaanModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.buttonLabel,
    required this.buttonUrl,
    required this.createdAt,
  });

  factory DaanModel.fromJson(Map<String, dynamic> json) => DaanModel(
    id: json['id'] ?? '',
    imageUrl: json['imageUrl'] ?? '',
    title: json['title'] ?? '',
    buttonLabel: json['buttonLabel'] ?? '',
    buttonUrl: json['buttonUrl'] ?? '',
    createdAt: DateTime.now(),
  );

  DaanModel copyWith({
    String? id,
    String? imageUrl,
    String? title,
    String? buttonLabel,
    String? buttonUrl,
    DateTime? createdAt,
  }) {
    return DaanModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      buttonLabel: buttonLabel ?? this.buttonLabel,
      buttonUrl: buttonUrl ?? this.buttonUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}