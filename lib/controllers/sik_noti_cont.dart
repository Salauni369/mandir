// import 'package:get/get.dart';
// import '../models/notification_model.dart';
//
// class NotificationController extends GetxController {
//   var notifications = <AppNotification>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     notifications.addAll([
//       AppNotification(
//         title: "Update Successful",
//         message:
//         "Your gurudwara details have been updated and are now up to date.",
//         time: "5 hours ago",
//         unread: true,
//       ),
//       AppNotification(
//         title: "Update Successful",
//         message:
//         "Your gurudwara details have been updated and are now up to date.",
//         time: "5 hours ago",
//         unread: true,
//       ),
//       AppNotification(
//         title: "Update Successful",
//         message:
//         "Your gurudwara details have been updated and are now up to date.",
//         time: "5 hours ago",
//         unread: true,
//       ),
//     ]);
//   }
//
//   void markAllRead() {
//     for (var n in notifications) {
//       n.unread = false;
//     }
//     notifications.refresh();
//   }
// }
