//
// //
//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';  // MediaType ke liye
//
// import '../models/live_darshan_model.dart';
// import '../services/livedarshan.dart';
// import '../utils/apiconstants.dart';     // ApiConstants.baseUrl ke liye
// import '../utils/api_header.dart';        // headers ke liye
// import 'dashboard_cotroller.dart';
//
// class DarshanController extends GetxController {
//   final isLoading = false.obs;
//   final liveDarshans = <DarshanModel>[].obs;
//   final pastDarshans = <DarshanModel>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchDarshans(); // agar zarurat ho page open hote hi
//   }
//
//   Future<void> fetchDarshans() async {
//     print("🔥 fetchDarshans CALLED");
//     try {
//       isLoading(true);
//       final home = Get.find<TempleHomeController>().homeData.value;
//       if (home == null) {
//         print("❌ homeData is NULL");
//         return;
//       }
//
//       print("✅ homeData FOUND - total liveDarshan = ${home.liveDarshan.length}");
//
//       liveDarshans.value = home.liveDarshan.where((e) => e.isLive == true).toList();
//       pastDarshans.value = home.liveDarshan.where((e) => e.isLive == false).toList();
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
//     final res = await DarshanService.createDarshanMultipart(
//       title: title,
//       embeddedLink: embeddedLink,
//       imagePath: mobile_image,
//       status: "ACTIVE",
//     );
//
//     print("📥 ADD RESPONSE => $res");
//     if (res["success"] == true) {
//       await Get.find<TempleHomeController>().fetchHomeData();
//       await fetchDarshans(); // local list bhi update
//       return true;
//     }
//     return false;
//   }
//
//   // 🔥 FINAL WORKING UPDATE FUNCTION
//   Future<void> updateDarshan(DarshanModel updatedDarshan) async {
//     try {
//       isLoading(true);
//
//       final uri = Uri.parse("${ApiConstants.liveDarshan}/${updatedDarshan.id}"); // apna exact endpoint daal dena
//
//       var request = http.MultipartRequest("PUT", uri); // ya "PATCH" agar backend support kare
//
//       request.headers.addAll(ApiHeaders.headers());
//
//       // Text fields
//       request.fields['title'] = updatedDarshan.title;
//       request.fields['embeddedLink'] = updatedDarshan.liveLink;
//       request.fields['status'] = updatedDarshan.status; // ACTIVE or INACTIVE
//
//       // Agar nayi image pick ki hai (local path hai) to upload karo
//       if (updatedDarshan.mobile_image != null &&
//           !updatedDarshan.mobile_image!.startsWith("http")) {
//         request.files.add(
//           await http.MultipartFile.fromPath(
//             "mobile_image",
//             updatedDarshan.mobile_image!,
//             contentType: MediaType('image', 'jpeg'),
//           ),
//         );
//       }
//
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);
//
//       print("📥 UPDATE STATUS CODE: ${response.statusCode}");
//       print("📥 UPDATE BODY: ${response.body}");
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Backend success → dashboard refetch kar do (sab latest ho jaaye)
//         await Get.find<TempleHomeController>().fetchHomeData();
//
//         // Local lists bhi update kar do (optional but smooth)
//         await fetchDarshans();
//
//         Get.snackbar("Success ✅", "Live Darshan updated!",
//             backgroundColor: Colors.green, colorText: Colors.white);
//       } else {
//         throw "Server error: ${response.body}";
//       }
//     } catch (e) {
//       print("❌ Update Error: $e");
//       Get.snackbar("Error ❌", "Update failed: $e",
//           backgroundColor: Colors.red, colorText: Colors.white);
//       rethrow;
//     } finally {
//       isLoading(false);
//     }
//   }
// }



// =========================import '../../../controllers/dashboard_cotroller.dart';

// 2. DARSHAN CONTROLLER - PROFESSIONAL VERSION
// ========================================
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../../controllers/dashboard_cotroller.dart';
import '../../../models/live_darshan_model.dart';
import '../../../services/livedarshan.dart';
import '../../../utils/api_header.dart';
import '../../../utils/apiconstants.dart';

class DarshanController extends GetxController {
  final isLoading = false.obs;
  final liveDarshans = <DarshanModel>[].obs;
  final pastDarshans = <DarshanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDarshans();
  }

  // FETCH FROM DASHBOARD
  Future<void> fetchDarshans() async {
    print("🔥 fetchDarshans CALLED");
    try {
      isLoading(true);
      final home = Get.find<TempleHomeController>().homeData.value;

      if (home == null) {
        print("❌ homeData is NULL");
        return;
      }

      print("✅ homeData FOUND - total liveDarshan = ${home.liveDarshan.length}");

      liveDarshans.value = home.liveDarshan.where((e) => e.isLive).toList();
      pastDarshans.value = home.liveDarshan.where((e) => !e.isLive).toList();

      print("🟢 LIVE COUNT = ${liveDarshans.length}");
      print("🔵 PAST COUNT = ${pastDarshans.length}");
    } finally {
      isLoading(false);
    }
  }

  // ADD DARSHAN
  Future<bool> addDarshan({
    required String title,
    required String embeddedLink,
    required String mobile_image,
  }) async {
    print("🚀 ADD DARSHAN START");

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
      return true;
    }
    return false;
  }

  // UPDATE DARSHAN - PROFESSIONAL VERSION
  Future<void> updateDarshan(DarshanModel updatedDarshan) async {
    try {
      isLoading(true);

      final uri = Uri.parse("${ApiConstants.liveDarshan}/${updatedDarshan.id}");
      var request = http.MultipartRequest("PUT", uri);

      request.headers.addAll(ApiHeaders.headers());

      // Text fields
      request.fields['title'] = updatedDarshan.title;
      request.fields['embeddedLink'] = updatedDarshan.liveLink;
      request.fields['status'] = updatedDarshan.status;

      // Image file (if new local file)
      if (updatedDarshan.mobile_image != null &&
          !updatedDarshan.mobile_image!.startsWith("http")) {
        final file = File(updatedDarshan.mobile_image!);
        if (await file.exists()) {
          request.files.add(
            await http.MultipartFile.fromPath(
              "mobile_image",
              updatedDarshan.mobile_image!,
              contentType: MediaType('image', 'jpeg'),
            ),
          );
          print("📤 NEW IMAGE FILE ADDED");
        }
      } else if (updatedDarshan.mobile_image != null) {
        // Existing URL
        request.fields['mobile_image'] = updatedDarshan.mobile_image!;
        print("📤 EXISTING IMAGE URL SENT");
      }

      print("🔄 UPDATE URL: $uri");
      print("📤 FIELDS: ${request.fields}");
      print("📤 FILES: ${request.files.length}");

      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
      );
      final response = await http.Response.fromStream(streamedResponse);

      print("📥 UPDATE STATUS: ${response.statusCode}");
      print("📥 UPDATE BODY: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Refresh dashboard data
        await Get.find<TempleHomeController>().fetchHomeData();

        // Refresh local lists
        await fetchDarshans();

        print("✅ UPDATE SUCCESS");
      } else {
        final decoded = jsonDecode(response.body);
        throw Exception(decoded["message"] ?? "Update failed");
      }
    } catch (e) {
      print("❌ Update Error: $e");
      Get.snackbar(
        "Update Failed",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  // DELETE DARSHAN (if needed)
  Future<void> deleteDarshan(String id) async {
    try {
      // Add delete API call here
      await Get.find<TempleHomeController>().fetchHomeData();
      await fetchDarshans();

      Get.snackbar(
        "Deleted",
        "Darshan removed successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to delete darshan",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}