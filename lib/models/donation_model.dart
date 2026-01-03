
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