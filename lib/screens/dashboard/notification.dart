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

import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // ------------------ CUSTOM APP BAR ------------------
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color(0xFFFF7A00),
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
                onPressed: () => Navigator.pop(context),
              ),
              const Text(
                "Notifications",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),

      // ------------------ BODY ------------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ----------------- SEARCH BAR -----------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey),
                  hintText: "Search for notification...",
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ------------ UNREAD HEADER ------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Unread (3)",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Mark all as read",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ---------- MULTIPLE NOTIFICATION ITEMS ----------
            ...List.generate(7, (index) => _notificationTile()),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // ------------------- SINGLE NOTIFICATION TILE -------------
  // ----------------------------------------------------------
  Widget _notificationTile() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "•  ",
                style: TextStyle(fontSize: 20, color: Colors.orange),
              ),
              const Expanded(
                child: Text(
                  "Update Successful",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.more_vert, size: 18, color: Colors.grey),
            ],
          ),

          const SizedBox(height: 6),

          // Description
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "Your mandir details have been updated and are now up to date.",
              style: TextStyle(fontSize: 12, height: 1.3, color: Colors.black87),
            ),
          ),

          const SizedBox(height: 6),

          // Time
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "5 hours ago",
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
