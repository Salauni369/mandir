// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/notification_controller.dart';
//
// class NotificationPage extends StatelessWidget {
//   const NotificationPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<NotificationController>();
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFFF7722),
//         title: const Text("Notifications"),
//         foregroundColor: Colors.white,
//         actions: [
//           TextButton(
//             onPressed: controller.markAllRead,
//             child: const Text(
//               "Mark all read",
//               style: TextStyle(color: Colors.white),
//             ),
//           )
//         ],
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator(color: Color(0xFFFF7722)));
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: controller.notifications.length,
//           itemBuilder: (_, i) {
//             final n = controller.notifications[i];
//
//             return Container(
//               margin: const EdgeInsets.only(bottom: 12),
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: n.isUnread ? Colors.orange.shade50 : Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.black12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(n.title,
//                       style: const TextStyle(
//                           fontSize: 16, fontWeight: FontWeight.w600)),
//                   const SizedBox(height: 6),
//                   Text(n.message,
//                       style: const TextStyle(fontSize: 13, color: Colors.grey)),
//                   const SizedBox(height: 6),
//                   Text(n.time,
//                       style: const TextStyle(fontSize: 12, color: Colors.grey)),
//                 ],
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
