


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
