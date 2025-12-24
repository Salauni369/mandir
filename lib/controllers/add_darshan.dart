//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../services/livedarshan.dart';
// import 'darshan_controller.dart';
// class AddDarshanController extends GetxController {
//   var isLoading = false.obs;
//
//   Future<bool> addDarshan({
//     required String title,
//     required String embeddedLink,
//     required String mobileImageUrl,
//   }) async {
//     try {
//       isLoading(true);
//
//       final result = await DarshanService.createDarshan(
//         title: title,
//         embeddedLink: embeddedLink,
//         mobileImageUrl: mobileImageUrl,
//       );
//
//       if (result['success'] == true) {
//         // Refresh the main darshan list
//         final darshanController = Get.find<DarshanController>();
//         await darshanController.fetchDarshans();
//
//         Get.snackbar(
//           "Success",
//           result['message'],
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//         return true;
//       } else {
//         Get.snackbar(
//           "Error",
//           result['message'],
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//         return false;
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Something went wrong: ${e.toString()}",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return false;
//     } finally {
//       isLoading(false);
//     }
//   }
// }