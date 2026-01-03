// class LiveDarshanModel {
//   final String id;
//   final String title;
//   final String embeddedLink;
//   final String status;
//   final String mobileImage;
//   final String webImage;
//   final DateTime createdAt;
//
//   LiveDarshanModel({
//     required this.id,
//     required this.title,
//     required this.embeddedLink,
//     required this.status,
//     required this.mobileImage,
//     required this.webImage,
//     required this.createdAt,
//   });
//
//   factory LiveDarshanModel.fromJson(Map<String, dynamic> json) {
//     return LiveDarshanModel(
//       id: json['_id'] ?? '',
//       title: json['title'] ?? '',
//       embeddedLink: json['embeddedLink'] ?? '',
//       status: json['status'] ?? '',
//       mobileImage: json['mobile_image'] ?? '',
//       webImage: json['web_image'] ?? '',
//       createdAt: DateTime.parse(json['createdAt']),
//     );
//   }
// }
