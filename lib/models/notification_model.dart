class NotificationModel {
  final String title;
  final String message;
  final String time;
  final bool isUnread;

  NotificationModel({
    required this.title,
    required this.message,
    required this.time,
    required this.isUnread,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      message: json['message'],
      time: json['time'],
      isUnread: json['isUnread'],
    );
  }
}
