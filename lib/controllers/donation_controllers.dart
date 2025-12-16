
import 'package:get/get.dart';

import '../models/donation_model.dart';
import '../services/daanservice.dart';
import 'dashboard_cotroller.dart';

class DaanController extends GetxController {
  final list = <DaanModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDonations();
  }

  // ----------------------------------
  // LOAD DONATIONS FROM DASHBOARD DATA
  // ----------------------------------
  //
  Future<void> fetchDonations() async {
    try {
      isLoading(true);
      final data = await DaanService.getAll();
      list.assignAll(data);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  // -----------------------------
  // ADD DONATION
  // -----------------------------
  Future<void> addDonation(DaanModel daan) async {
    isLoading.value = true;
    try {
      final created = await DaanService.add(daan);

      // UI list update
      list.insert(0, created);

      // dashboard sync
      final homeCtrl = Get.find<TempleHomeController>();
      homeCtrl.homeData.update((h) {
        h?.donation.insert(0, created.toJson());
      });

      Get.snackbar("Success", "Donation added");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // -----------------------------
  // UPDATE DONATION
  // -----------------------------
  Future<void> updateDonation(DaanModel daan) async {
    isLoading.value = true;
    try {
      final updated = await DaanService.update(daan);

      if (updated != null) {
        // UI list update
        final index = list.indexWhere((d) => d.id == daan.id);
        if (index != -1) {
          list[index] = updated;
        }

        // dashboard sync
        final homeCtrl = Get.find<TempleHomeController>();
        homeCtrl.homeData.update((h) {
          final i = h?.donation.indexWhere((e) => e["_id"] == daan.id) ?? -1;
          if (i != -1) {
            h?.donation[i] = updated.toJson();
          }
        });

        Get.snackbar("Updated", "Donation updated");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // -----------------------------
  // DELETE DONATION
  // -----------------------------
  // Future<void> deleteDonation(String id) async {
  //   isLoading.value = true;
  //   try {
  //     final success = await DaanService.remove(id);
  //
  //     if (success) {
  //       // UI list update
  //       list.removeWhere((d) => d.id == id);
  //
  //       // dashboard sync
  //       final homeCtrl = Get.find<TempleHomeController>();
  //       homeCtrl.homeData.update((h) {
  //         h?.donation.removeWhere((e) => e["_id"] == id);
  //       });
  //
  //       Get.snackbar("Deleted", "Donation removed");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
