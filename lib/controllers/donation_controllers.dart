import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/donation_model.dart';
import '../services/daanservice.dart';

class DaanController extends GetxController {
  var list = <DaanModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetch();
  }

  Future<void> fetch() async {
    isLoading.value = true;
    try {
      final items = await DaanService.getAll();
      list.assignAll(items);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addDaan(DaanModel daan) async {
    isLoading.value = true;
    try {
      final created = await DaanService.add(daan);
      list.insert(0, created);
      Get.snackbar('Success', 'Daan added', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateDaan(DaanModel daan) async {
    isLoading.value = true;
    try {
      final updated = await DaanService.update(daan);
      if (updated != null) {
        final idx = list.indexWhere((d) => d.id == daan.id);
        if (idx != -1) list[idx] = updated;
        Get.snackbar('Success', 'Daan updated', snackPosition: SnackPosition.BOTTOM);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteDaan(String id) async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: Text('Delete?'),
        content: Text('This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Get.back(result: false), child: Text('Cancel')),
          ElevatedButton(onPressed: () => Get.back(result: true), child: Text('Delete')),
        ],
      ),
    );
    if (confirm == true) {
      isLoading.value = true;
      try {
        await DaanService.remove(id);
        list.removeWhere((d) => d.id == id);
        Get.snackbar('Deleted', 'Daan removed', snackPosition: SnackPosition.BOTTOM);
      } finally {
        isLoading.value = false;
      }
    }
  }
}
