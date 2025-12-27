// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
//
// import '../../../controllers/dashboard_cotroller.dart';
// import '../../../models/live_darshan_model.dart';
// import '../../../utils/api_header.dart';
// import '../../../utils/apiconstants.dart';
// import '../screens/dashboard/live_darshan/Livedarshan.dart';
//
// class DarshanController extends GetxController {
//   final isLoading = false.obs;
//
//   final liveDarshans = <DarshanModel>[].obs;
//   final pastDarshans = <DarshanModel>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchDarshans();
//   }
//
//   // ===================================================
//   // FETCH DARSHANS (FROM HOME DATA)
//   // ===================================================
//   Future<void> fetchDarshans() async {
//     try {
//       isLoading(true);
//
//       final home = Get.find<TempleHomeController>().homeData.value;
//       if (home == null) {
//         debugPrint("❌ homeData null");
//         return;
//       }
//
//       liveDarshans.value =
//           home.liveDarshan.where((e) => e.isLive).toList();
//
//       pastDarshans.value =
//           home.liveDarshan.where((e) => !e.isLive).toList();
//
//       debugPrint("✅ Darshans fetched | LIVE=${liveDarshans.length} | PAST=${pastDarshans.length}");
//     } catch (e) {
//       debugPrint("❌ fetchDarshans error: $e");
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   // ===================================================
//   // ADD DARSHAN (CREATE)
//   // ===================================================
//   Future<bool> addDarshan({
//     required String title,
//     required String embeddedLink,
//     required String imagePath, // LOCAL FILE PATH
//   }) async {
//     try {
//       isLoading(true);
//
//       final request = http.MultipartRequest(
//         "POST",
//         Uri.parse(ApiConstants.liveDarshan),
//       );
//
//       request.headers.addAll(ApiHeaders.headers());
//
//       request.fields['title'] = title.trim();
//       request.fields['embeddedLink'] = embeddedLink.trim();
//       request.fields['status'] = "ACTIVE";
//
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           'mobile_image',
//           imagePath,
//           contentType: MediaType('image', 'jpeg'),
//         ),
//       );
//
//       debugPrint("🚀 ADD DARSHAN REQUEST SENT");
//
//       final streamed = await request.send();
//       final response = await http.Response.fromStream(streamed);
//
//       debugPrint("📥 ADD STATUS: ${response.statusCode}");
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         await Get.find<TempleHomeController>().fetchHomeData();
//         await fetchDarshans();
//         return true;
//       }
//
//       final msg = jsonDecode(response.body)['message'] ?? 'Add failed';
//       throw msg;
//     } catch (e) {
//       debugPrint("❌ ADD ERROR: $e");
//       Get.snackbar(
//         "Error",
//         e.toString(),
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return false;
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   // ===================================================
//   // UPDATE DARSHAN (CREATE + _id)
//   // ===================================================
//   Future<void> updateDarshan(DarshanModel darshan) async {
//     try {
//       isLoading(true);
//
//       // 🔥 IMAGE MUST BE LOCAL FILE
//       if (darshan.mobile_image == null ||
//           darshan.mobile_image!.startsWith("http")) {
//         throw "Please select image again";
//       }
//
//       final request = http.MultipartRequest(
//         "POST",
//         Uri.parse(ApiConstants.liveDarshan),
//       );
//
//       request.headers.addAll(ApiHeaders.headers());
//
//       request.fields['_id'] = darshan.id;
//       request.fields['title'] = darshan.title.trim();
//       request.fields['embeddedLink'] = darshan.liveLink.trim();
//       request.fields['status'] = darshan.status;
//
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           'mobile_image',
//           darshan.mobile_image!,
//           contentType: MediaType('image', 'jpeg'),
//         ),
//       );
//
//       debugPrint("🚀 UPDATE DARSHAN REQUEST SENT");
//       debugPrint("➡️ ID: ${darshan.id}");
//
//       final streamed = await request.send();
//       final response = await http.Response.fromStream(streamed);
//
//       debugPrint("📥 UPDATE STATUS: ${response.statusCode}");
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         await Get.find<TempleHomeController>().fetchHomeData();
//         await fetchDarshans();
//
//         if (Get.isDialogOpen ?? false) Get.back();
//         Get.offAll(() => DarshanMainPage());
//
//         Get.snackbar(
//           "Success",
//           "Darshan updated successfully",
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//         return;
//       }
//
//       final msg = jsonDecode(response.body)['message'] ?? 'Update failed';
//       throw msg;
//     } catch (e) {
//       debugPrint("❌ UPDATE ERROR: $e");
//
//       if (Get.isDialogOpen ?? false) Get.back();
//
//       Get.snackbar(
//         "Update Failed",
//         e.toString(),
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   // ===================================================
//   // DELETE DARSHAN (LOCAL REFRESH ONLY)
//   // ===================================================
//   Future<void> deleteDarshan(String id) async {
//     try {
//       await Get.find<TempleHomeController>().fetchHomeData();
//       await fetchDarshans();
//
//       Get.snackbar(
//         "Deleted",
//         "Darshan removed",
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Delete failed",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../controllers/BottomNavController.dart';
import '../../controllers/dashboard_cotroller.dart';
import '../../models/live_darshan_model.dart';
import '../../utils/api_header.dart';
import '../../utils/apiconstants.dart';

class DarshanController extends GetxController {
  final isLoading = false.obs;

  final liveDarshans = <DarshanModel>[].obs;
  final pastDarshans = <DarshanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDarshans();
  }

  // ================= FETCH =================
  Future<void> fetchDarshans() async {
    try {
      isLoading(true);

      final home = Get.find<TempleHomeController>().homeData.value;
      if (home == null) return;

      liveDarshans.value =
          home.liveDarshan.where((e) => e.isLive).toList();

      pastDarshans.value =
          home.liveDarshan.where((e) => !e.isLive).toList();
    } finally {
      isLoading(false);
    }
  }

  // ================= ADD =================
  Future<bool> addDarshan({
    required String title,
    required String embeddedLink,
    required String imagePath,
  }) async {
    try {
      isLoading(true);

      final req = http.MultipartRequest(
        "POST",
        Uri.parse(ApiConstants.liveDarshan),
      );

      req.headers.addAll(ApiHeaders.headers());
      req.fields['title'] = title;
      req.fields['embeddedLink'] = embeddedLink;
      req.fields['status'] = "ACTIVE";

      req.files.add(await http.MultipartFile.fromPath(
        'mobile_image',
        imagePath,
        contentType: MediaType('image', 'jpeg'),
      ));

      final res = await http.Response.fromStream(await req.send());

      if (res.statusCode == 200 || res.statusCode == 201) {
        await Get.find<TempleHomeController>().fetchHomeData();
        await fetchDarshans();
        return true;
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      isLoading(false);
    }
  }

  // ================= UPDATE =================
  Future<void> updateDarshan(DarshanModel darshan) async {
    try {
      isLoading(true);

      if (darshan.mobile_image == null ||
          darshan.mobile_image!.startsWith("http")) {
        throw "Please select image again";
      }

      final req = http.MultipartRequest(
        "POST",
        Uri.parse(ApiConstants.liveDarshan),
      );

      req.headers.addAll(ApiHeaders.headers());
      req.fields['_id'] = darshan.id;
      req.fields['title'] = darshan.title;
      req.fields['embeddedLink'] = darshan.liveLink;
      req.fields['status'] = darshan.status;

      req.files.add(await http.MultipartFile.fromPath(
        'mobile_image',
        darshan.mobile_image!,
        contentType: MediaType('image', 'jpeg'),
      ));

      final res = await http.Response.fromStream(await req.send());

      if (res.statusCode == 200 || res.statusCode == 201) {
        await Get.find<TempleHomeController>().fetchHomeData();
        await fetchDarshans();

        if (Get.isDialogOpen ?? false) Get.back();

        // 🔥 ONLY THIS
        Get.find<BottomNavController>().changeTab(2);

        Get.snackbar("Success", "Darshan updated");
        return;
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      Get.snackbar("Update Failed", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
