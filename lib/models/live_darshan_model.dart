//
// class DarshanModel {
//    String id;
//   final String subtitle;
//   final String description;
//   final String image;
//   final String title;
//   final String templeName;
//   final String liveLink;
//   final String? webImage;
//   final String? mobileImage;
//   final DateTime createdAt;
//   final bool isLive;
//
//   DarshanModel({
//     required this.description,
//     required this.subtitle,
//     required this.image,
//     required this.id,
//     required this.title,
//     required this.templeName,
//     required this.liveLink,
//     this.webImage,
//     this.mobileImage,
//     required this.createdAt,
//     this.isLive = false,
//   });
//
//   factory DarshanModel.fromJson(Map<String, dynamic> json) {
//     return DarshanModel(
//       id: json['id'],
//       description:json['description'],
//       subtitle: json['subtitle'],
//       image: json['image'],
//       title: json['title'],
//       templeName: json['templeName'],
//       liveLink: json['liveLink'],
//       webImage: json['webImage'],
//       mobileImage: json['mobileImage'],
//       createdAt: DateTime.parse(json['createdAt']),
//       isLive: json['isLive'] ?? false,
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'title': title,
//     'templeName': templeName,
//     'liveLink': liveLink,
//     'webImage': webImage,
//     'mobileImage': mobileImage,
//     'createdAt': createdAt.toIso8601String(),
//     'isLive': isLive,
//   };
// }



class DarshanModel {
  String id;
  final String title;
  final String templeName;
  final String liveLink;

  final String subtitle;
  final String description;
  final String image; // main image (can be "")

  final String? webImage;     // optional
  final String? mobileImage;  // optional

  final DateTime createdAt;
  final bool isLive;

  DarshanModel({
    required this.id,
    required this.title,
    required this.templeName,
    required this.liveLink,

    required this.subtitle,
    required this.description,
    required this.image,

    this.webImage,
    this.mobileImage,

    required this.createdAt,
    this.isLive = false,
  });

  // -------------------------
  // copyWith() for Edit Page
  // -------------------------
  DarshanModel copyWith({
    String? id,
    String? title,
    String? templeName,
    String? liveLink,

    String? subtitle,
    String? description,
    String? image,

    String? webImage,
    String? mobileImage,

    DateTime? createdAt,
    bool? isLive,
  }) {
    return DarshanModel(
      id: id ?? this.id,
      title: title ?? this.title,
      templeName: templeName ?? this.templeName,
      liveLink: liveLink ?? this.liveLink,

      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      image: image ?? this.image,

      webImage: webImage ?? this.webImage,
      mobileImage: mobileImage ?? this.mobileImage,

      createdAt: createdAt ?? this.createdAt,
      isLive: isLive ?? this.isLive,
    );
  }

  // -------------------------
  // JSON from Backend
  // -------------------------
  factory DarshanModel.fromJson(Map<String, dynamic> json) {
    return DarshanModel(
      id: json['id'],
      title: json['title'],
      templeName: json['templeName'],
      liveLink: json['liveLink'],

      subtitle: json['subtitle'] ?? "",
      description: json['description'] ?? "",
      image: json['image'] ?? "",

      webImage: json['webImage'],
      mobileImage: json['mobileImage'],

      createdAt: DateTime.parse(json['createdAt']),
      isLive: json['isLive'] ?? false,
    );
  }

  // -------------------------
  // JSON to Backend
  // -------------------------
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'templeName': templeName,
    'liveLink': liveLink,

    'subtitle': subtitle,
    'description': description,
    'image': image,

    'webImage': webImage,
    'mobileImage': mobileImage,

    'createdAt': createdAt.toIso8601String(),
    'isLive': isLive,
  };
}
