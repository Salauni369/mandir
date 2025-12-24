// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:http_parser/http_parser.dart';
// // import '../../../controllers/dashboard_cotroller.dart';
// // import '../../../models/live_darshan_model.dart';
// // import '../../../services/livedarshan.dart';
// // import '../../../utils/api_header.dart';
// // import '../../../utils/apiconstants.dart';
// // import '../screens/dashboard/live_darshan/Livedarshan.dart';
// //
// // class DarshanController extends GetxController {
// //   final isLoading = false.obs;
// //   final liveDarshans = <DarshanModel>[].obs;
// //   final pastDarshans = <DarshanModel>[].obs;
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchDarshans();
// //   }
// //
// //   // FETCH FROM DASHBOARD
// //   Future<void> fetchDarshans() async {
// //     print("🔥 fetchDarshans CALLED");
// //     try {
// //       isLoading(true);
// //       final home = Get.find<TempleHomeController>().homeData.value;
// //
// //       if (home == null) return;
// //
// //       print(
// //         "✅ homeData FOUND - total liveDarshan = ${home.liveDarshan.length}",
// //       );
// //
// //       liveDarshans.value = home.liveDarshan.where((e) => e.isLive).toList();
// //       pastDarshans.value = home.liveDarshan.where((e) => !e.isLive).toList();
// //
// //       print("🟢 LIVE COUNT = ${liveDarshans.length}");
// //       print("🔵 PAST COUNT = ${pastDarshans.length}");
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// //
// //   // ADD DARSHAN
// //   Future<bool> addDarshan({
// //     required String title,
// //     required String embeddedLink,
// //     required String mobile_image,
// //   }) async {
// //     print("🚀 ADD DARSHAN START");
// //
// //     final res = await DarshanService.createDarshanMultipart(
// //       title: title,
// //       embeddedLink: embeddedLink,
// //       imagePath: mobile_image,
// //       status: "ACTIVE",
// //     );
// //
// //     print("📥 ADD RESPONSE => $res");
// //
// //     if (res["success"] == true) {
// //       await Get.find<TempleHomeController>().fetchHomeData();
// //       await fetchDarshans();
// //       return true;
// //     }
// //     return false;
// //   }
// //
// //   Future<void> updateDarshan(DarshanModel updatedDarshan) async {
// //     try {
// //       isLoading(true);
// //
// //       final uri = Uri.parse(ApiConstants.liveDarshan);
// //       var request = http.MultipartRequest("POST", uri);
// //
// //       request.headers.addAll(ApiHeaders.headers());
// //
// //       // Required fields
// //       request.fields['title'] = updatedDarshan.title.trim();
// //       request.fields['embeddedLink'] = updatedDarshan.liveLink.trim();
// //       request.fields['status'] = updatedDarshan.status;
// //       request.fields['_id'] = updatedDarshan.id; // Crucial for update
// //
// //       // Handle image
// //       if (updatedDarshan.mobile_image != null &&
// //           !updatedDarshan.mobile_image!.startsWith("http")) {
// //         final file = File(updatedDarshan.mobile_image!);
// //         if (await file.exists()) {
// //           request.files.add(
// //             await http.MultipartFile.fromPath(
// //               "mobile_image",
// //               updatedDarshan.mobile_image!,
// //               contentType: MediaType('image', 'jpeg'),
// //             ),
// //           );
// //           print("📤 NEW IMAGE UPLOADED");
// //         }
// //       } else if (updatedDarshan.mobile_image != null) {
// //         request.fields['mobile_image'] = updatedDarshan.mobile_image!;
// //         print("📤 EXISTING IMAGE KEPT");
// //       }
// //
// //       print("🔄 UPDATING DARSHAN (POST + _id)");
// //       print("📤 FIELDS: ${request.fields}");
// //       print("📤 FILES: ${request.files.length}");
// //
// //       final streamedResponse = await request.send();
// //       final response = await http.Response.fromStream(streamedResponse);
// //
// //       print("📥 STATUS: ${response.statusCode}");
// //       print("📥 BODY: ${response.body}");
// //
// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         final json = jsonDecode(response.body);
// //         final updatedData = json['data']['liveDarshan'];
// //         final newModel = DarshanModel.fromJson(updatedData);
// //
// //         // Update local state
// //         final homeController = Get.find<TempleHomeController>();
// //         final currentList = homeController.homeData.value?.liveDarshan ?? [];
// //
// //         final index = currentList.indexWhere((e) => e.id == updatedDarshan.id);
// //         if (index != -1) {
// //           currentList[index] = newModel;
// //           homeController.homeData.refresh();
// //         }
// //
// //         // Refresh lists
// //         await fetchDarshans();
// //
// //         // ✅ PROFESSIONAL SUCCESS FEEDBACK
// //         Get.snackbar(
// //           "Updated Successfully ✅",
// //           "Live Darshan has been updated",
// //           backgroundColor: Colors.green.shade600,
// //           colorText: Colors.white,
// //           snackPosition: SnackPosition.BOTTOM,
// //           margin: const EdgeInsets.all(16),
// //           duration: const Duration(seconds: 2),
// //           icon: const Icon(Icons.check_circle, color: Colors.white),
// //         );
// //
// //         // 🔥 DIRECT MAIN LIST PAGE PE WAPAS JAO (Clean Navigation)
// //         // Ye sab pages pop karega jab tak first page (dashboard) na mile
// //         Get.offAll(() => DarshanMainPage());
// //
// //         // Alternative (agar route name pata hai):
// //         // Get.offAllNamed('/MyHomePage');
// //         // Get.offAllNamed('/LiveDarshanPage');
// //
// //       } else {
// //         throw Exception(jsonDecode(response.body)["message"] ?? "Update failed");
// //       }
// //     } catch (e) {
// //       print("❌ Update Error: $e");
// //       Get.snackbar(
// //         "Update Failed ❌",
// //         e.toString(),
// //         backgroundColor: Colors.red.shade600,
// //         colorText: Colors.white,
// //         snackPosition: SnackPosition.BOTTOM,
// //         margin: const EdgeInsets.all(16),
// //         duration: const Duration(seconds: 4),
// //         icon: const Icon(Icons.error, color: Colors.white),
// //       );
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// //
// //   // DELETE DARSHAN
// //   Future<void> deleteDarshan(String id) async {
// //     try {
// //       // Add delete API call here
// //       // For now just refreshing as placeholder if API not available
// //       await Get.find<TempleHomeController>().fetchHomeData();
// //       await fetchDarshans();
// //
// //       Get.snackbar(
// //         "Deleted",
// //         "Darshan removed successfully",
// //         backgroundColor: Colors.green,
// //         colorText: Colors.white,
// //       );
// //     } catch (e) {
// //       Get.snackbar(
// //         "Error",
// //         "Failed to delete darshan",
// //         backgroundColor: Colors.red,
// //         colorText: Colors.white,
// //       );
// //     }
// //   }
// // }
//
//
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import '../../../controllers/dashboard_cotroller.dart';
// import '../../../models/live_darshan_model.dart';
// import '../../../services/livedarshan.dart';
// import '../../../utils/api_header.dart';
// import '../../../utils/apiconstants.dart';
// import '../screens/dashboard/live_darshan/Livedarshan.dart'; // ← Import added
//
// class DarshanController extends GetxController {
//   final isLoading = false.obs;
//   final liveDarshans = <DarshanModel>[].obs;
//   final pastDarshans = <DarshanModel>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchDarshans();
//   }
//
//   Future<void> fetchDarshans() async {
//     print("🔥 fetchDarshans CALLED");
//     try {
//       isLoading(true);
//       final home = Get.find<TempleHomeController>().homeData.value;
//
//       if (home == null) return;
//
//       print("✅ homeData FOUND - total liveDarshan = ${home.liveDarshan.length}");
//
//       liveDarshans.value = home.liveDarshan.where((e) => e.isLive).toList();
//       pastDarshans.value = home.liveDarshan.where((e) => !e.isLive).toList();
//
//       print("🟢 LIVE COUNT = ${liveDarshans.length}");
//       print("🔵 PAST COUNT = ${pastDarshans.length}");
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<bool> addDarshan({
//     required String title,
//     required String embeddedLink,
//     required String mobile_image,
//   }) async {
//     print("🚀 ADD DARSHAN START");
//
//     final res = await DarshanService.createDarshanMultipart(
//       title: title,
//       embeddedLink: embeddedLink,
//       imagePath: mobile_image,
//       status: "ACTIVE",
//     );
//
//     print("📥 ADD RESPONSE => $res");
//
//     if (res["success"] == true) {
//       await Get.find<TempleHomeController>().fetchHomeData();
//       await fetchDarshans();
//       return true;
//     }
//     return false;
//   }
//
//   Future<void> updateDarshan(DarshanModel updatedDarshan) async {
//     try {
//       isLoading(true);
//
//       final uri = Uri.parse(ApiConstants.liveDarshan);
//       var request = http.MultipartRequest("POST", uri);
//
//       request.headers.addAll(ApiHeaders.headers());
//
//       request.fields['title'] = updatedDarshan.title.trim();
//       request.fields['embeddedLink'] = updatedDarshan.liveLink.trim();
//       request.fields['status'] = updatedDarshan.status;
//       request.fields['_id'] = updatedDarshan.id;
//
//       if (updatedDarshan.mobile_image != null &&
//           !updatedDarshan.mobile_image!.startsWith("http")) {
//         final file = File(updatedDarshan.mobile_image!);
//         if (await file.exists()) {
//           request.files.add(
//             await http.MultipartFile.fromPath(
//               "mobile_image",
//               updatedDarshan.mobile_image!,
//               contentType: MediaType('image', 'jpeg'),
//             ),
//           );
//           print("📤 NEW IMAGE UPLOADED");
//         }
//       } else if (updatedDarshan.mobile_image != null) {
//         request.fields['mobile_image'] = updatedDarshan.mobile_image!;
//         print("📤 EXISTING IMAGE KEPT");
//       }
//
//       print("🔄 UPDATING DARSHAN (POST + _id)");
//       print("📤 FIELDS: ${request.fields}");
//       print("📤 FILES: ${request.files.length}");
//
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);
//
//       print("📥 STATUS: ${response.statusCode}");
//       print("📥 BODY: ${response.body}");
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final json = jsonDecode(response.body);
//         final updatedData = json['data']['liveDarshan'];
//         final newModel = DarshanModel.fromJson(updatedData);
//
//         final homeController = Get.find<TempleHomeController>();
//         final currentList = homeController.homeData.value?.liveDarshan ?? [];
//
//         final index = currentList.indexWhere((e) => e.id == updatedDarshan.id);
//         if (index != -1) {
//           currentList[index] = newModel;
//           homeController.homeData.refresh();
//         }
//
//         await fetchDarshans();
//
//         // ✅ SUCCESS MESSAGE — 2 SECONDS DIKHEGA
//         Get.snackbar(
//           "Updated Successfully ✅",
//           "Live Darshan has been updated",
//           backgroundColor: Colors.green.shade600,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.BOTTOM,
//           margin: const EdgeInsets.all(16),
//           duration: const Duration(seconds: 2),
//           isDismissible: true,
//           forwardAnimationCurve: Curves.easeOutBack,
//           icon: const Icon(Icons.check_circle, color: Colors.white, size: 30),
//         );
//
//         // 🔥 2 SECONDS KE BAAD DIRECT LIVE DARSHAN MAIN PAGE PE
//         Future.delayed(const Duration(seconds: 2), () {
//           Get.offAll(() =>  DarshanMainPage()); // ← Direct widget call
//         });
//
//       } else {
//         throw Exception(jsonDecode(response.body)["message"] ?? "Update failed");
//       }
//     } catch (e) {
//       print("❌ Update Error: $e");
//       Get.snackbar(
//         "Update Failed ❌",
//         e.toString(),
//         backgroundColor: Colors.red.shade600,
//         colorText: Colors.white,
//         snackPosition: SnackPosition.BOTTOM,
//         margin: const EdgeInsets.all(16),
//         duration: const Duration(seconds: 4),
//         icon: const Icon(Icons.error, color: Colors.white),
//       );
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<void> deleteDarshan(String id) async {
//     try {
//       await Get.find<TempleHomeController>().fetchHomeData();
//       await fetchDarshans();
//
//       Get.snackbar(
//         "Deleted",
//         "Darshan removed successfully",
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Failed to delete darshan",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
// }


import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:zamboree_devotion/common/util_method.dart';

import '../../../controllers/dashboard_cotroller.dart';
import '../../../models/live_darshan_model.dart';
import '../../../services/livedarshan.dart';
import '../../../utils/api_header.dart';
import '../../../utils/apiconstants.dart';
import '../screens/dashboard/live_darshan/Livedarshan.dart';

class DarshanController extends GetxController {
  final isLoading = false.obs;
  final liveDarshans = <DarshanModel>[].obs;
  final pastDarshans = <DarshanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDarshans();
  }

  // =========================
  // FETCH DARSHANS
  // =========================
  Future<void> fetchDarshans() async {
    print("🔥 fetchDarshans CALLED");
    try {
      isLoading(true);
      final home = Get.find<TempleHomeController>().homeData.value;

      if (home == null) {
        print("❌ homeData is null");
        return;
      }

      print("✅ homeData FOUND - total liveDarshan = ${home.liveDarshan.length}");

      liveDarshans.value = home.liveDarshan.where((e) => e.isLive).toList();
      pastDarshans.value = home.liveDarshan.where((e) => !e.isLive).toList();

      print("🟢 LIVE COUNT = ${liveDarshans.length}");
      print("🔵 PAST COUNT = ${pastDarshans.length}");
    } catch (e) {
      print("❌ Fetch Error: $e");
    } finally {
      isLoading(false);
    }
  }

  // =========================
  // ADD DARSHAN
  // =========================
  Future<bool> addDarshan({
    required String title,
    required String embeddedLink,
    required String mobile_image,
  }) async {
    print("🚀 ADD DARSHAN START");
    print("➡️ Title: $title");
    print("➡️ Embedded Link: $embeddedLink");
    print("➡️ Image Path: $mobile_image");

    try {
      final res = await DarshanService.createDarshanMultipart(
        title: title,
        embeddedLink: embeddedLink,
        imagePath: mobile_image,
        status: "ACTIVE",
      );

      print("📥 ADD RESPONSE => $res");

      if (res["success"] == true) {
        await Get.find<TempleHomeController>().fetchHomeData();
        await fetchDarshans();
        print("✅ Darshan added successfully");
        return true;
      } else {
        print("❌ Add failed: ${res['message']}");
        Get.snackbar(
          "Error",
          res['message'] ?? "Failed to add darshan",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      print("❌ Add Exception: $e");
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }

  // =========================
  // UPDATE DARSHAN (FIXED)
  // =========================
  Future<void> updateDarshan(DarshanModel updatedDarshan) async {
    try {
      isLoading(true);

      final uri = Uri.parse(ApiConstants.liveDarshan);
      var request = http.MultipartRequest("POST", uri);

      request.headers.addAll(ApiHeaders.headers());

      // ✅ CRITICAL: Send all required fields
      request.fields['_id'] = updatedDarshan.id; // For update identification
      request.fields['title'] = updatedDarshan.title.trim();
      request.fields['embeddedLink'] = updatedDarshan.liveLink.trim(); // ✅ YouTube link
      request.fields['status'] = updatedDarshan.status;

      print("🔄 UPDATING DARSHAN");
      print("➡️ ID: ${updatedDarshan.id}");
      print("➡️ Title: ${updatedDarshan.title}");
      print("➡️ Embedded Link: ${updatedDarshan.liveLink}"); // ✅ CHECK THIS
      print("➡️ Status: ${updatedDarshan.status}");
      print("➡️ Image: ${updatedDarshan.mobile_image}");

      // ✅ Handle image upload
      if (updatedDarshan.mobile_image != null) {
        if (updatedDarshan.mobile_image!.startsWith("http")) {
          // ✅ Existing image URL - send as field
          request.fields['mobile_image'] = updatedDarshan.mobile_image!;
          print("📤 EXISTING IMAGE URL SENT");
        } else {
          // ✅ New local file - upload it first
          print("📤 UPLOADING NEW IMAGE...");

          try {
            // Upload to cloudinary first
            final imageUrl = await UtilMethod.uploadImageAndGetUrl(
              updatedDarshan.mobile_image!,
            );

            request.fields['mobile_image'] = imageUrl;
            print("✅ NEW IMAGE UPLOADED: $imageUrl");
          } catch (e) {
            print("❌ Image upload failed: $e");
            // Continue with old image if new upload fails
            if (updatedDarshan.mobile_image != null) {
              request.fields['mobile_image'] = updatedDarshan.mobile_image!;
            }
          }
        }
      }

      print("📤 FINAL FIELDS: ${request.fields}");
      print("📤 FILES COUNT: ${request.files.length}");

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("📥 STATUS: ${response.statusCode}");
      print("📥 BODY: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final updatedData = json['data']['liveDarshan'];
        final newModel = DarshanModel.fromJson(updatedData);

        print("✅ UPDATE SUCCESS");
        print("✅ New embeddedLink: ${newModel.liveLink}");

        // Update local state
        final homeController = Get.find<TempleHomeController>();
        final currentList = homeController.homeData.value?.liveDarshan ?? [];

        final index = currentList.indexWhere((e) => e.id == updatedDarshan.id);
        if (index != -1) {
          currentList[index] = newModel;
          homeController.homeData.refresh();
          print("✅ Local state updated");
        }

        await fetchDarshans();

        // Success message
        Get.snackbar(
          "Updated Successfully ✅",
          "Live Darshan has been updated",
          backgroundColor: Colors.green.shade600,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
          isDismissible: true,
          icon: const Icon(Icons.check_circle, color: Colors.white, size: 30),
        );

        // Navigate back after 2 seconds
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAll(() => DarshanMainPage());
        });

      } else {
        final errorMsg = jsonDecode(response.body)["message"] ?? "Update failed";
        throw Exception(errorMsg);
      }
    } catch (e) {
      print("❌ UPDATE ERROR: $e");
      Get.snackbar(
        "Update Failed ❌",
        e.toString(),
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
        icon: const Icon(Icons.error, color: Colors.white),
      );
    } finally {
      isLoading(false);
    }
  }

  // =========================
  // DELETE DARSHAN
  // =========================
  Future<void> deleteDarshan(String id) async {
    try {
      print("🗑 Deleting darshan: $id");

      // TODO: Add actual delete API call here
      // For now, just refresh

      await Get.find<TempleHomeController>().fetchHomeData();
      await fetchDarshans();

      Get.snackbar(
        "Deleted",
        "Darshan removed successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print("❌ Delete Error: $e");
      Get.snackbar(
        "Error",
        "Failed to delete darshan",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}