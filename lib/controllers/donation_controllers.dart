//
// import 'dart:convert';
//
// import 'package:get/get.dart';
//
// import '../models/donation_model.dart';
// import '../services/daanservice.dart';
// import 'dashboard_cotroller.dart';
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
//   // ----------------------------------
//   // LOAD DONATIONS FROM DASHBOARD DATA
//   // ----------------------------------
//   //
//   Future<void> fetchDonations() async {
//     try {
//       isLoading(true);
//       daanListData.clear();
//       final data = await DaanService.getAll();
//       print("test ===>> ${jsonEncode(data)}");
//       daanListData.assignAll(data);
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   // -----------------------------
//   // ADD DONATION
//   // -----------------------------
//   Future<void> addDonation(DaanModel daan) async {
//     isLoading.value = true;
//     try {
//       final created = await DaanService.add(daan);
//       daanListData.insert(0, created);
//
//       // UI list update
//       daanListData.insert(0, created);
//
//       // dashboard sync
//       final homeCtrl = Get.find<TempleHomeController>();
//       homeCtrl.homeData.update((h) {
//         h?.donation.insert(0, created.toJson());
//       });
//
//       Get.snackbar("Success", "Donation added");
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // -----------------------------
//   // UPDATE DONATION
//   // -----------------------------
//   Future<void> updateDonation(DaanModel daan) async {
//     isLoading.value = true;
//     try {
//       final updated = await DaanService.update(daan);
//
//       if (updated != null) {
//         // UI list update
//         final index = daanListData.indexWhere((d) => d.id == daan.id);
//         if (index != -1) {
//           daanListData[index] = updated;
//         }
//
//         // dashboard sync
//         final homeCtrl = Get.find<TempleHomeController>();
//         homeCtrl.homeData.update((h) {
//           final i = h?.donation.indexWhere((e) => e["_id"] == daan.id) ?? -1;
//           if (i != -1) {
//             h?.donation[i] = updated.toJson();
//           }
//         });
//
//         Get.snackbar("Updated", "Donation updated");
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // -----------------------------
//   // DELETE DONATION
//   // -----------------------------
//   // Future<void> deleteDonation(String id) async {
//   //   isLoading.value = true;
//   //   try {
//   //     final success = await DaanService.remove(id);
//   //
//   //     if (success) {
//   //       // UI list update
//   //       list.removeWhere((d) => d.id == id);
//   //
//   //       // dashboard sync
//   //       final homeCtrl = Get.find<TempleHomeController>();
//   //       homeCtrl.homeData.update((h) {
//   //         h?.donation.removeWhere((e) => e["_id"] == id);
//   //       });
//   //
//   //       Get.snackbar("Deleted", "Donation removed");
//   //     }
//   //   } catch (e) {
//   //     Get.snackbar("Error", e.toString());
//   //   } finally {
//   //     isLoading.value = false;
//   //   }
//   // }
// }

//
// import 'package:get/get.dart';
// import '../models/donation_model.dart';
// import '../services/daanservice.dart';
// import 'dashboard_cotroller.dart';
//
// class DaanController extends GetxController {
//   final daanListData = <DaanModel>[].obs;
//   final isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchDonations();
//
//     // Dashboard update hone pe auto refresh
//     ever(Get.find<TempleHomeController>().homeData, (_) => fetchDonations());
//   }
//
//   Future<void> fetchDonations() async {
//     try {
//       isLoading(true);
//       daanListData.clear();
//
//       final homeCtrl = Get.find<TempleHomeController>();
//       final home = homeCtrl.homeData.value;
//
//       if (home == null || home.donation.isEmpty) {
//         print("No donation data");
//         return;
//       }
//
//       daanListData.value = home.donation
//           .map((json) => DaanModel.fromJson(json as Map<String, dynamic>))
//           .toList();
//
//       print("Loaded ${daanListData.length} donations");
//     } catch (e) {
//       print("Error loading donations: $e");
//       Get.snackbar("Error", "Failed to load donations");
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<void> addDonation(DaanModel daan) async {
//     isLoading(true);
//     try {
//       final created = await DaanService.add(daan);
//       daanListData.insert(0, created);
//
//       // Dashboard refresh
//       await Get.find<TempleHomeController>().fetchHomeData();
//
//       Get.snackbar("Success", "Donation added");
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<void> updateDonation(DaanModel daan) async {
//     isLoading(true);
//     try {
//       final updated = await DaanService.update(daan);
//
//       final index = daanListData.indexWhere((d) => d.id == updated.id);
//       if (index != -1) daanListData[index] = updated;
//
//       await Get.find<TempleHomeController>().fetchHomeData();
//
//       Get.snackbar("Success", "Donation updated");
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../models/donation_model.dart';
// import '../services/daanservice.dart';
// import 'dashboard_cotroller.dart';
//
// class DaanController extends GetxController {
//   final daanListData = <DaanModel>[].obs;
//   final isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchDonations();
//     // Dashboard change hone pe auto update
//     ever(Get.find<TempleHomeController>().homeData, (_) => fetchDonations());
//   }
//
//   // 🔥 YE LINE HI SAB FIX KAREGI – dashboard se direct load
//   Future<void> fetchDonations() async {
//     try {
//       isLoading(true);
//       daanListData.clear();
//
//       final home = Get.find<TempleHomeController>().homeData.value;
//
//       if (home == null) {
//         print("❌ Dashboard data null hai");
//         return;
//       }
//
//       if (home.donation.isEmpty) {
//         print("❌ Donation array empty hai");
//         return;
//       }
//
//       print("✅ ${home.donation.length} daan items mil gaye");
//
//       daanListData.value = home.donation
//           .map((json) => DaanModel.fromJson(json as Map<String, dynamic>))
//           .toList();
//
//       print("List mein items: ${daanListData.length}");
//     } catch (e) {
//       print("Error: $e");
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   // Add aur update wala code same rakho jo pehle tha
//   // Future<void> addDonation(DaanModel daan) async {
//   //   isLoading(true);
//   //   try {
//   //     final created = await DaanService.add(daan);
//   //     daanListData.insert(0, created);
//   //     await Get.find<TempleHomeController>().fetchHomeData();
//   //     Get.snackbar("Success", "New Daan Added!");
//   //   } catch (e) {
//   //     Get.snackbar("Error", e.toString());
//   //   } finally {
//   //     isLoading(false);
//   //   }
//   // }
//   Future<void> addDonation(DaanModel daan) async {
//     isLoading(true);
//     try {
//       print("🚀 Starting add donation...");
//       final created = await DaanService.add(daan);
//       print("✅ Backend success - new item: ${created.id}");
//
//       daanListData.insert(0, created);
//
//       // Dashboard refresh
//       await Get.find<TempleHomeController>().fetchHomeData();
//
//       Get.snackbar("Success", "New Daan Added!");
//     } catch (e) {
//       print("❌ Add donation failed: $e");
//       rethrow; // important – error upar jaayega AddDaanPage mein
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<void> updateDonation(DaanModel daan) async {
//     isLoading(true);
//     try {
//       final updated = await DaanService.update(daan);
//       final index = daanListData.indexWhere((d) => d.id == updated.id);
//       if (index != -1) daanListData[index] = updated;
//       await Get.find<TempleHomeController>().fetchHomeData();
//       Get.snackbar("Success", "Daan Updated!");
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
// }

// ========================================
// 3. CONTROLLER (donation_controllers.dart)
// ========================================
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/donation_model.dart';
import '../services/daanservice.dart';
import 'dashboard_cotroller.dart';

class DaanController extends GetxController {
  final daanListData = <DaanModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDonations();
    ever(Get.find<TempleHomeController>().homeData, (_) => fetchDonations());
  }

  Future<void> fetchDonations() async {
    try {
      isLoading(true);
      daanListData.clear();

      final home = Get.find<TempleHomeController>().homeData.value;

      if (home == null) {
        print("❌ Dashboard data null");
        return;
      }

      if (home.donation.isEmpty) {
        print("❌ Donation array empty");
        return;
      }

      print("✅ ${home.donation.length} donations found");

      daanListData.value = home.donation
          .map((json) => DaanModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("❌ Fetch Error: $e");
      Get.snackbar("Error", "Failed to load donations");
    } finally {
      isLoading(false);
    }
  }

  Future<void> addDonation(DaanModel daan) async {
    try {
      isLoading(true);
      print("🚀 Adding donation...");

      final created = await DaanService.add(daan);
      print("✅ Donation created: ${created.id}");

      daanListData.insert(0, created);

      await Get.find<TempleHomeController>().fetchHomeData();

      Get.snackbar(
        "Success",
        "Donation added successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print("❌ Add failed: $e");
      Get.snackbar(
        "Error",
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

  Future<void> updateDonation(DaanModel daan) async {
    try {
      isLoading(true);
      print("🔄 Updating donation...");

      final updated = await DaanService.update(daan);
      print("✅ Donation updated: ${updated.id}");

      final index = daanListData.indexWhere((d) => d.id == updated.id);
      if (index != -1) {
        daanListData[index] = updated;
      }

      await Get.find<TempleHomeController>().fetchHomeData();

      Get.snackbar(
        "Success",
        "Donation updated successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print("❌ Update failed: $e");
      Get.snackbar(
        "Error",
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
}
