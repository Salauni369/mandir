// //
// //
// // import 'dart:convert';
// // import 'dart:core';
// // import 'package:http/http.dart' as http;
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:zamboree_devotion/utils/api_header.dart';
// // import '../models/donation_model.dart';
// // import '../services/daanservice.dart';
// //
// //
// // class DaanController extends GetxController {
// //   final daanListData = <DaanModel>[].obs;
// //   final isLoading = false.obs;
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchDonations(); // only ONE source
// //   }
// //
// //   Future<void> fetchDonations() async {
// //     try {
// //       isLoading(true);
// //       final list = await DaanService.getAll();
// //       daanListData.assignAll(list);
// //       print("✅ Donations loaded: ${list.length}");
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// //
// //   Future<void> addDonation({String, title, button, buttonUrl, image}) async {
// //     var _url = "https://api.gamsgroup.in/spiritual/buffer";
// //
// //     try {
// //       isLoading(true);
// //       final created = await DaanService.addWithJson(
// //         bodyReq: {
// //           "donation_title": title,
// //           "button_label": button,
// //           "button_url": buttonUrl,
// //           "mobile_image": image, // URL
// //         },
// //         uri: _url,
// //       );
// //       // daanListData.insert(0, created);
// //        await fetchDonations();
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// //
// //   Future<void> updateDonation(DaanModel daan) async {
// //     try {
// //       isLoading(true);
// //       final updated = await DaanService.update(daan);
// //       final i = daanListData.indexWhere((d) => d.id == updated.id);
// //       if (i != -1) {
// //         daanListData[i] = updated;
// //         daanListData.refresh();
// //       }
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// // }
// //
//
//
// import 'package:get/get.dart';
//
// import '../models/donation_model.dart';
// import '../services/daanservice.dart';
//
// class DaanController extends GetxController {
//   final daanListData = <DaanModel>[].obs;
//   final isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchDonations();
//   }
//
//   // =========================
//   // FETCH ALL DONATIONS
//   // =========================
//   Future<void> fetchDonations() async {
//     try {
//       isLoading(true);
//       final list = await DaanService.getAll();
//       daanListData.assignAll(list);
//       print("✅ Donations loaded: ${list.length}");
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   // =========================
//   // ADD DONATION
//   // =========================
//   Future<void> addDonation({
//     required String title,
//     required String buttonLabel,
//     required String buttonUrl,
//     required String imageUrl, // 👈 MUST BE URL
//   }) async {
//     try {
//       isLoading(true);
//
//       final daan = DaanModel(
//         id: '',
//         donation_title: title,
//         buttonText: buttonLabel,
//         buttonLink: buttonUrl,
//         image: imageUrl,
//       );
//
//       await DaanService.add(daan);
//
//       // refresh list
//       await fetchDonations();
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   // =========================
//   // UPDATE DONATION
//   // =========================
//   Future<void> updateDonation(DaanModel daan) async {
//     try {
//       isLoading(true);
//       final updated = await DaanService.update(daan);
//
//       final index = daanListData.indexWhere((d) => d.id == updated.id);
//       if (index != -1) {
//         daanListData[index] = updated;
//         daanListData.refresh();
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
// }


import 'package:get/get.dart';

import '../models/donation_model.dart';
import '../services/daanservice.dart';

class DaanController extends GetxController {
  final daanListData = <DaanModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDonations();
  }

  // =========================
  // FETCH ALL DONATIONS
  // =========================
  Future<void> fetchDonations() async {
    try {
      isLoading(true);
      final list = await DaanService.getAll();
      daanListData.assignAll(list);
      print("✅ Donations loaded: ${list.length}");
    } catch (e) {
      print("❌ Fetch donations error: $e");
      // Show error to user
      Get.snackbar(
        "Error",
        "Failed to load donations: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  // =========================
  // ADD DONATION
  // =========================
  Future<void> addDonation({
    required String title,
    required String buttonLabel,
    required String buttonUrl,
    required String imageUrl, // 👈 MUST BE URL
  }) async {
    try {
      isLoading(true);

      final daan = DaanModel(
        id: '',
        description: title,
        button_text: buttonLabel,
        button_link: buttonUrl,
        image: imageUrl,
      );

      await DaanService.add(daan);

      // ✅ Refresh list after adding
      await fetchDonations();

      print("✅ Donation added successfully");
    } catch (e) {
      print("❌ Add donation error: $e");
      rethrow; // Important: re-throw to catch in UI
    } finally {
      isLoading(false);
    }
  }

  // =========================
  // UPDATE DONATION
  // =========================
  Future<void> updateDonation(DaanModel daan) async {
    try {
      isLoading(true);
      final updated = await DaanService.update(daan);

      // ✅ Update local list
      final index = daanListData.indexWhere((d) => d.id == updated.id);
      if (index != -1) {
        daanListData[index] = updated;
        daanListData.refresh();
      }

      print("✅ Donation updated successfully");
    } catch (e) {
      print("❌ Update donation error: $e");
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  // =========================
  // DELETE DONATION
  // =========================
  Future<void> deleteDonation(String id) async {
    try {
      isLoading(true);
      final success = await DaanService.delete(id);

      if (success) {
        // ✅ Remove from local list
        daanListData.removeWhere((d) => d.id == id);
        daanListData.refresh();

        print("✅ Donation deleted successfully");
      } else {
        throw Exception("Failed to delete donation");
      }
    } catch (e) {
      print("❌ Delete donation error: $e");
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
