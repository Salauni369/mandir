// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../controllers/donation_controllers.dart';
// import '../../../widgets/app_colors.dart';
// import '../../../widgets/daancard.dart';
// import 'add_donation_page.dart';
//
// class DaanMainPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(DaanController());
//
//     return Scaffold(
//       backgroundColor: AppColors.hinduL1,
//
//       appBar:  AppBar(
//         backgroundColor: AppColors.hinduBase,
//         title: Text("Daan", style: TextStyle(color: Colors.white)),
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
//       //
//       // floatingActionButton: FloatingActionButton(
//       //   backgroundColor: AppColors.hinduBase,
//       //   child: Icon(Icons.add, color: Colors.white),
//       //   onPressed: () => Get.to(() => AddDaanPage()),
//       // ),
//
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(
//             child: CircularProgressIndicator(color: AppColors.hinduBase),
//           );
//         }
//
//         if (controller.list.isEmpty) {
//           return Center(
//             child: Text(
//               "No Daan Items",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           );
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: controller.list.length,
//           itemBuilder: (context, index) {
//             return DaanCard(daan: controller.list[index]);
//           },
//         );
//       }),
//     );
//   }
// }

// lib/screens/daan/daan_main_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/donation_controllers.dart';
import '../../../widgets/app_colors.dart';
import '../../../widgets/daancard.dart';
import 'add_donation_page.dart';
import 'edit_donation_page.dart'; // ← YE ADD KARNA ZAROORI THA!

class DaanMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DaanController());

    return Scaffold(
      backgroundColor: AppColors.hinduL1,
      appBar: AppBar(
        backgroundColor: AppColors.hinduBase,
        title: const Text("Daan", style: TextStyle(color: Colors.white)),
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

        if (controller.list.isEmpty) {
          return Center(
            child: Text("No Daan Items", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.list.length,
          itemBuilder: (context, index) {
            final daan = controller.list[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => EditDaanPage(daan: daan)); // ← YE LINE ADD KI!
              },
              child: DaanCard(daan: daan),
            );
          },
        );
      }),
    );
  }
}