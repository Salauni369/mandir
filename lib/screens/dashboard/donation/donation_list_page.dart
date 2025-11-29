// // screens/daan/daan_list_page.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
// import '../../../controllers/donation_list.dart';
// import '../../../widgets/custom_bottom_nav.dart';
// import '../../../widgets/donation_card.dart';
// import 'add_donation_page.dart';
//
// class DaanListPage extends StatelessWidget {
//   final MotionTabBarController controller;
//   const DaanListPage({super.key, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(DaanListController());
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFFF7722),
//         title: const Text("Daan", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator(color: Color(0xFFFF7722)));
//         }
//         if (controller.daanList.isEmpty) {
//           return const Center(child: Text("No Daan added yet", style: TextStyle(fontSize: 18)));
//         }
//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: controller.daanList.length,
//           itemBuilder: (_, i) => DaanCard(daan: controller.daanList[i]),
//         );
//       }),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color(0xFFFF7722),
//         child: const Icon(Icons.add, color: Colors.white),
//         onPressed: () => Get.to(() => AddDaanPage()),
//       ),
//
//     );
//   }
// }