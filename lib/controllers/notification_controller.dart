// import 'package:get/get.dart';
// import '../models/notification_model.dart';
// import '../services/notification_service.dart';
//
// class NotificationController extends GetxController {
//   var isLoading = true.obs;
//   var notifications = <NotificationModel>[].obs;
//
//   // unread badge count
//   int get unreadCount =>
//       notifications.where((e) => e.isUnread == true).length;
//
//   @override
//   void onInit() {
//     loadNotifications();
//     super.onInit();
//   }
//
//   Future<void> loadNotifications() async {
//     try {
//       isLoading(true);
//       final data = await NotificationService.fetchNotifications();
//       notifications.assignAll(data);
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   void markAllRead() {
//     notifications.value = notifications.map(
//           (e) => NotificationModel(
//         title: e.title,
//         message: e.message,
//         time: e.time,
//         isUnread: false,
//       ),
//     ).toList();
//   }
// }
