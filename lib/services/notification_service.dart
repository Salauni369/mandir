import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/notification_model.dart';

class NotificationService {
  static Future<List<NotificationModel>> fetchNotifications() async {
    final data = await rootBundle.loadString("assets/mock/notifications.json");
    final list = jsonDecode(data) as List;
    return list.map((e) => NotificationModel.fromJson(e)).toList();
  }
}
