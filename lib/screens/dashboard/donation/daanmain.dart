// // lib/screens/daan/daan_main_page.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controllers/donation_controllers.dart';
// import '../../../widgets/app_colors.dart';
// import '../../../widgets/daancard.dart';
// import 'add_donation_page.dart';
// import 'edit_donation_page.dart'; // ← YE ADD KARNA ZAROORI THA!
//
// class DaanMainPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<DaanController>();
//
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.hinduBase,
//         title: const Text("Daan", style: TextStyle(color: Colors.white)),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(8),
//             bottomRight: Radius.circular(8),
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: InkWell(
//               borderRadius: BorderRadius.circular(30),
//               onTap: () => Get.to(() => AddDaanPage()),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.add, color: Colors.white, size: 20),
//                     SizedBox(width: 6),
//                     Text(
//                       "Add",
//                       style: TextStyle(color: Colors.white, fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(
//             child: CircularProgressIndicator(color: AppColors.hinduBase),
//           );
//         }
//
//         if (controller.daanListData.isEmpty) {
//           return Center(
//             child: Text(
//               "No Daan Items",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           );
//         }
//
//         return ListView.builder(
//           padding: EdgeInsets.all(16),
//           itemCount: controller.daanListData.length,
//           itemBuilder: (context, index) {
//             final daan = controller.daanListData[index];
//             print("Akshaykkk   ===>> ${controller.daanListData.length}");
//             print("Akshay   ===>> ${daan.image}");
//             return GestureDetector(
//               onTap: () {
//                 Get.to(() => EditDaanPage(daan: daan)); // ← YE LINE ADD KI!
//               },
//               child: DaanCard(daan: daan),
//             );
//           },
//         );
//       }),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/donation_controllers.dart';
import '../../../widgets/app_colors.dart';
import '../../../widgets/daancard.dart';
import 'add_donation_page.dart';
import 'edit_donation_page.dart';

class DaanMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DaanController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.hinduBase,
        title: const Text("Daan", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () => Get.to(() => AddDaanPage()),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.white, size: 20),
                    SizedBox(width: 6),
                    Text("Add", style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: AppColors.hinduBase));
        }

        if (controller.daanListData.isEmpty) {
          return Center(
            child: Text("No Daan Items", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.daanListData.length,
          itemBuilder: (context, index) {
            final daan = controller.daanListData[index];
            return GestureDetector(
              onTap: () => Get.to(() => EditDaanPage(daan: daan)),
              child: DaanCard(daan: daan),
            );
          },
        );
      }),
    );
  }
}