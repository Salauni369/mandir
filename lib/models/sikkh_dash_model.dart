// lib/models/dashboard_model.dart
class DashboardModel {
  final int visitorsThisMonth;
  final int liveAttended;
  final List<LiveDarshan> liveDarshans;
  final TempleInfo templeInfo;

  DashboardModel({
    required this.visitorsThisMonth,
    required this.liveAttended,
    required this.liveDarshans,
    required this.templeInfo,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      visitorsThisMonth: json['visitors'] ?? 0,
      liveAttended: json['liveAttended'] ?? 0,
      liveDarshans: (json['liveDarshans'] as List).map((e) => LiveDarshan.fromJson(e)).toList(),
      templeInfo: TempleInfo.fromJson(json['templeInfo']),
    );
  }
}

class LiveDarshan {
  final String title;
  final String image;
  final String youtubeLink;
  final bool isLive;

  LiveDarshan({required this.title, required this.image, required this.youtubeLink, required this.isLive});

  factory LiveDarshan.fromJson(Map<String, dynamic> json) {
    return LiveDarshan(
      title: json['title'] ?? "",
      image: json['image'] ?? "",
      youtubeLink: json['youtubeLink'] ?? "",
      isLive: json['isLive'] ?? false,
    );
  }
}

class TempleInfo {
  final String name;
  final String address;
  final String about;
  final String timings;
  final String image;

  TempleInfo({required this.name, required this.address, required this.about, required this.timings, required this.image});

  factory TempleInfo.fromJson(Map<String, dynamic> json) {
    return TempleInfo(
      name: json['name'] ?? "",
      address: json['address'] ?? "",
      about: json['about'] ?? "",
      timings: json['timings'] ?? "",
      image: json['image'] ?? "",
    );
  }
}