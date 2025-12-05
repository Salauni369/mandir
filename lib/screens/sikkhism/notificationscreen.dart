// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/notification_controller.dart';
// import '../../controllers/sik_noti_cont.dart';
//
// class NotificationPage extends StatelessWidget {
//   final c = Get.put(NotificationController());
//
//   NotificationPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0A73FF),
//         title: const Text("Notifications",
//             style: TextStyle(color: Colors.white)),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//
//       body: Column(
//         children: [
//           _searchBar(),
//
//           const SizedBox(height: 16),
//
//           Obx(() => _header(c)),
//
//           Expanded(
//             child: Obx(() => ListView(
//               padding: const EdgeInsets.all(16),
//               children:
//               c.notifications.map((n) => _notifCard(n)).toList(),
//             )),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _searchBar() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: "Search for area, street name...",
//           prefixIcon: const Icon(Icons.search),
//           filled: true,
//           fillColor: Colors.grey.shade100,
//           border:
//           OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//       ),
//     );
//   }
//
//   Widget _header(NotificationController c) {
//     int unread = c.notifications.where((e) => e!.unread).length;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text("Unread ($unread)",
//               style:
//               const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
//           GestureDetector(
//             onTap: c.markAllRead,
//             child: const Text("Mark all as read",
//                 style: TextStyle(color: Colors.blue)),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _notifCard(notification) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color:
//         notification.unread ? Colors.blue.shade50 : Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("• ${notification.title}",
//               style: const TextStyle(
//                   fontWeight: FontWeight.w600, fontSize: 13)),
//           const SizedBox(height: 6),
//           Text(notification.message,
//               style: const TextStyle(fontSize: 12)),
//           const SizedBox(height: 6),
//           Text(notification.time,
//               style: TextStyle(fontSize: 11, color: Colors.grey.shade600))
//         ],
//       ),
//     );
//   }
// }
