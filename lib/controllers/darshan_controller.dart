// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'dart:developer'; // 👈 for logging
// //
// // import '../models/live_darshan_model.dart';
// // import '../services/livedarshan.dart';
// // import '../widgets/darshansucces.dart';
// // import 'BottomNavController.dart';
// // import 'dashboard_cotroller.dart';
// //
// // class DarshanController extends GetxController {
// //   final isPageLoading = true.obs;
// //   final isActionLoading = false.obs;
// //
// //   final liveDarshans = <DarshanModel>[].obs;
// //   final pastDarshans = <DarshanModel>[].obs;
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     log("DarshanController initialized");
// //     fetchDarshans();
// //   }
// //
// //   Future<void> fetchDarshans() async {
// //     try {
// //       isPageLoading(true);
// //       log("Fetching darshans...");
// //
// //       final home = Get.find<TempleHomeController>().homeData.value;
// //       if (home == null) {
// //         log("Home data is null, skipping darshan fetch");
// //         return;
// //       }
// //
// //       liveDarshans.value = home.liveDarshan.where((e) => e.isLive).toList();
// //       pastDarshans.value = home.liveDarshan.where((e) => !e.isLive).toList();
// //
// //       log("Fetched ${liveDarshans.length} live darshans and ${pastDarshans.length} past darshans");
// //     } finally {
// //       isPageLoading(false);
// //       log("Darshan fetch completed");
// //     }
// //   }
// //
// //   // ===============================
// //   // ADD DARSHAN (URL ONLY)
// //   // ===============================
// //   Future<void> addDarshan({
// //     required String title,
// //     required String embeddedLink,
// //     required String imageUrl,
// //   }) async {
// //     try {
// //       isActionLoading(true);
// //       log("Adding darshan: title=$title, link=$embeddedLink, image=$imageUrl");
// //
// //       if (!imageUrl.startsWith("http")) {
// //         log("Invalid image URL provided: $imageUrl");
// //         throw Exception("Invalid image URL");
// //       }
// //
// //       final darshan = DarshanModel(
// //         id: "",
// //         title: title,
// //         embeddedLink: embeddedLink,
// //         status: "ACTIVE",
// //         mobileImage: imageUrl,
// //         createdAt: DateTime.now(),
// //       );
// //
// //       await DarshanService.add(darshan);
// //       log("Darshan added successfully via service");
// //
// //       await Get.find<TempleHomeController>().fetchHomeData();
// //       await fetchDarshans();
// //
// //       if (Get.isDialogOpen ?? false) Get.back();
// //
// //       await showDarshanSuccessDialog(
// //         title: "Darshan Added Successfully",
// //         subtitle: "Your live darshan entry is ready.",
// //       );
// //
// //       Get.find<BottomNavController>().changeTab(2);
// //       log("Darshan add flow completed");
// //     } finally {
// //       isActionLoading(false);
// //     }
// //   }
// //
// //   // ===============================
// //   // UPDATE DARSHAN (URL ONLY)
// //   // ===============================
// //   Future<void> updateDarshan(DarshanModel darshan) async {
// //     try {
// //       isActionLoading(true);
// //       log("Updating darshan with id=${darshan.id}");
// //
// //       if (!darshan.mobileImage.startsWith("http")) {
// //         log("Invalid image URL provided: ${darshan.mobileImage}");
// //         throw Exception("Invalid image URL");
// //       }
// //
// //       await DarshanService.update(darshan.id, darshan);
// //       log("Darshan updated successfully via service");
// //
// //       await Get.find<TempleHomeController>().fetchHomeData();
// //       await fetchDarshans();
// //
// //       if (Get.isDialogOpen ?? false) Get.back();
// //       Get.back();
// //
// //       await showDarshanSuccessDialog(
// //         title: "Darshan Updated Successfully",
// //         subtitle: "Your changes have been saved.",
// //       );
// //
// //       Get.find<BottomNavController>().changeTab(2);
// //       log("Darshan update flow completed for id=${darshan.id}");
// //     } finally {
// //       isActionLoading(false);
// //     }
// //   }
// //
// //   Future<void> deleteDarshan(String id) async {
// //     log("Deleting darshan with id=$id");
// //     await DarshanService.delete(id);
// //     log("Darshan deleted successfully via service");
// //
// //     await Get.find<TempleHomeController>().fetchHomeData();
// //     await fetchDarshans();
// //     log("Darshan delete flow completed for id=$id");
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:developer';
//
// import '../models/live_darshan_model.dart';
// import '../services/livedarshan.dart';
// import '../widgets/darshansucces.dart';
// import 'BottomNavController.dart';
// import 'dashboard_cotroller.dart';
//
// class DarshanController extends GetxController {
//   final isPageLoading = true.obs;
//   final isActionLoading = false.obs;
//   final LiveDarshanController = Get.put(LiveDarshanController());
//   final liveDarshans = <DarshanModel>[].obs;
//
//   final pastDarshans = <DarshanModel>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     log("DarshanController initialized");
//     fetchDarshans();
//   }
//
//   // ===============================
//   // FETCH DARSHANS (🔥 FIXED LOGIC)
//   // ===============================
//   Future<void> fetchDarshans() async {
//     try {
//       isPageLoading(true);
//       log("Fetching darshans...");
//
//       final home = Get.find<TempleHomeController>().homeData.value;
//       if (home == null) {
//         log("Home data is null, skipping darshan fetch");
//         return;
//       }
//
//       final all = home.liveDarshan;
//
//       // 🔥 MAIN FIX — ACTIVE darshan ko bhi LIVE treat karo
//       liveDarshans.value = all.where((e) {
//         return e.isLive == true || e.status == "ACTIVE";
//       }).toList();
//
//       pastDarshans.value = all.where((e) {
//         return e.isLive == false && e.status != "ACTIVE";
//       }).toList();
//
//       log(
//         "Fetched ${liveDarshans.length} live darshans and ${pastDarshans.length} past darshans",
//       );
//     } finally {
//       isPageLoading(false);
//       log("Darshan fetch completed");
//     }
//   }
//
//
//   // ===============================
//   // ADD DARSHAN (URL ONLY)
//   // ===============================
//   Future<void> addDarshan({
//     required String title,
//     required String embeddedLink,
//     required String imageUrl,
//   }) async {
//     try {
//       isActionLoading(true);
//       log("Adding darshan: title=$title, link=$embeddedLink, image=$imageUrl");
//
//       if (!imageUrl.startsWith("http")) {
//         log("Invalid image URL provided: $imageUrl");
//         throw Exception("Invalid image URL");
//       }
//
//       final darshan = DarshanModel(
//         id: "",
//         title: title,
//         embeddedLink: embeddedLink,
//         status: "ACTIVE", // 🔥 THIS WILL NOW SHOW IN LIVE
//         mobileImage: imageUrl,
//         createdAt: DateTime.now(),
//       );
//
//       await DarshanService.add(darshan);
//       log("Darshan added successfully via service");
//
//       // 🔥 Refresh source of truth
//       await Get.find<TempleHomeController>().fetchHomeData();
//       await fetchDarshans();
//
//       if (Get.isDialogOpen ?? false) Get.back();
//
//       await showDarshanSuccessDialog(
//         title: "Darshan Added Successfully",
//         subtitle: "Your live darshan entry is ready.",
//       );
//
//       Get.find<BottomNavController>().changeTab(2);
//       log("Darshan add flow completed");
//     } finally {
//       isActionLoading(false);
//     }
//   }
//
//   // ===============================
//   // UPDATE DARSHAN (URL ONLY)
//   // ===============================
//   Future<void> updateDarshan(DarshanModel darshan) async {
//     try {
//       isActionLoading(true);
//       log("Updating darshan with id=${darshan.id}");
//
//       if (!darshan.mobileImage.startsWith("http")) {
//         log("Invalid image URL provided: ${darshan.mobileImage}");
//         throw Exception("Invalid image URL");
//       }
//
//       await DarshanService.update(darshan.id, darshan);
//       log("Darshan updated successfully via service");
//
//       await Get.find<TempleHomeController>().fetchHomeData();
//       await fetchDarshans();
//
//       if (Get.isDialogOpen ?? false) Get.back();
//       Get.back();
//
//       await showDarshanSuccessDialog(
//         title: "Darshan Updated Successfully",
//         subtitle: "Your changes have been saved.",
//       );
//
//       Get.find<BottomNavController>().changeTab(2);
//       log("Darshan update flow completed for id=${darshan.id}");
//     } finally {
//       isActionLoading(false);
//     }
//   }
//
//   // ===============================
//   // DELETE DARSHAN
//   // ===============================
//   Future<void> deleteDarshan(String id) async {
//     log("Deleting darshan with id=$id");
//
//     await DarshanService.delete(id);
//     log("Darshan deleted successfully via service");
//
//     await Get.find<TempleHomeController>().fetchHomeData();
//     await fetchDarshans();
//
//     log("Darshan delete flow completed for id=$id");
//   }
// }

import 'dart:developer';
import 'package:get/get.dart';

import '../get live dasharn/controller.dart';
import '../models/live_darshan_model.dart';
import '../services/livedarshan.dart';
import '../widgets/darshansucces.dart';
import 'BottomNavController.dart';

class DarshanController extends GetxController {
  // ---------------- STATE ----------------
  final isPageLoading = true.obs;
  final isActionLoading = false.obs;

  final liveDarshans = <DarshanModel>[].obs;
  final pastDarshans = <DarshanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    log("DarshanController initialized");
    fetchDarshans();
  }

  // ===============================
  // FETCH DARSHANS (SOURCE = LIVE API)
  // ===============================
  Future<void> fetchDarshans() async {
    try {
      isPageLoading(true);
      log("DarshanController: fetchDarshans");

      final liveCtrl = Get.find<LiveDarshanController>();

      // Agar live controller empty hai to API hit
      if (liveCtrl.liveDarshans.isEmpty) {
        await liveCtrl.fetchLiveDarshans();
      }

      // 🔥 UI ko data
      liveDarshans.assignAll(liveCtrl.liveDarshans);

      // Abhi past ka logic/API nahi
      pastDarshans.clear();

      log(
        "Fetched ${liveDarshans.length} live darshans for UI",
      );
    } catch (e) {
      log("Fetch darshans error: $e");
    } finally {
      isPageLoading(false);
    }
  }

  // ===============================
  // ADD DARSHAN
  // ===============================
  Future<void> addDarshan({
    required String title,
    required String embeddedLink,
    required String imageUrl,
  }) async {
    try {
      isActionLoading(true);
      log("Adding darshan: $title");

      final darshan = DarshanModel(
        id: "",
        title: title,
        embeddedLink: embeddedLink,
        status: "ACTIVE",
        mobileImage: imageUrl,
        createdAt: DateTime.now(),
      );

      await DarshanService.add(darshan);
      log("Darshan added via service");

      // 🔥 REFRESH PIPELINE
      await refreshAfterChange();

      if (Get.isDialogOpen ?? false) Get.back();

      await showDarshanSuccessDialog(
        title: "Darshan Added Successfully",
        subtitle: "Your live darshan entry is ready.",
      );

      Get.find<BottomNavController>().changeTab(2);
    } catch (e) {
      log("Add darshan error: $e");
      rethrow;
    } finally {
      isActionLoading(false);
    }
  }

  // ===============================
  // UPDATE DARSHAN
  // ===============================
  Future<void> updateDarshan(DarshanModel darshan) async {
    try {
      isActionLoading(true);
      log("Updating darshan: ${darshan.id}");

      await DarshanService.update(darshan.id, darshan);
      log("Darshan updated via service");

      await refreshAfterChange();

      if (Get.isDialogOpen ?? false) Get.back();
      Get.back();

      await showDarshanSuccessDialog(
        title: "Darshan Updated Successfully",
        subtitle: "Your changes have been saved.",
      );

      Get.find<BottomNavController>().changeTab(2);
    } catch (e) {
      log("Update darshan error: $e");
      rethrow;
    } finally {
      isActionLoading(false);
    }
  }

  // ===============================
  // DELETE DARSHAN
  // ===============================
  Future<void> deleteDarshan(String id) async {
    try {
      isActionLoading(true);
      log("Deleting darshan: $id");

      await DarshanService.delete(id);
      log("Darshan deleted via service");

      await refreshAfterChange();
    } catch (e) {
      log("Delete darshan error: $e");
      rethrow;
    } finally {
      isActionLoading(false);
    }
  }

  // ===============================
  // COMMON REFRESH (SINGLE SOURCE)
  // ===============================
  Future<void> refreshAfterChange() async {
    final liveCtrl = Get.find<LiveDarshanController>();
    await liveCtrl.fetchLiveDarshans();
    await fetchDarshans();
  }
}
