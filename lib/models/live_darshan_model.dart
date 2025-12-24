class DarshanModel {
  final String id;
  final String title;
  final String liveLink;

  final String subtitle;
  final String description;
  final String image;

  final String? mobile_image;
  final DateTime createdAt;

  // 🔥 SINGLE SOURCE OF TRUTH
  final String status; // "ACTIVE" | "INACTIVE"

  DarshanModel({
    required this.id,
    required this.title,
    required this.liveLink,
    required this.subtitle,
    required this.description,
    required this.image,
    this.mobile_image,
    required this.createdAt,
    required this.status,
  });

  // ✅ DERIVED VALUE (NO FIELD)
  bool get isLive => status == "ACTIVE";

  DarshanModel copyWith({
    String? title,
    String? liveLink,
    String? mobile_image,
    String? status,
  }) {
    return DarshanModel(
      id: id,
      title: title ?? this.title,
      liveLink: liveLink ?? this.liveLink,
      subtitle: subtitle,
      description: description,
      image: image,
      mobile_image: mobile_image ?? this.mobile_image,
      createdAt: createdAt,
      status: status ?? this.status,
    );
  }

  factory DarshanModel.fromJson(Map<String, dynamic> json) {
    return DarshanModel(
      id: json['_id'],
      title: json['title'] ?? "",
      liveLink: json['embeddedLink'] ?? "",
      subtitle: "",
      description: "",
      image: json['image'] ?? "",
      mobile_image: json['mobile_image'],
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'] ?? "INACTIVE",
    );
  }
}
