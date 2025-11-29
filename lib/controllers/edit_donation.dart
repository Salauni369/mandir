// lib/controllers/edit_daan_controller.dart   ← YE FILE POORI REPLACE KAR DE

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/donation_model.dart';
import '../myRoutes/mypagesname.dart';

import 'donation_list.dart';

class EditDaanController extends GetxController {
  late DaanModel daan;

  late TextEditingController descCtrl;
  late TextEditingController buttonLabelCtrl;
  late TextEditingController urlCtrl;

  var imagePath = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    daan = Get.arguments as DaanModel;

    descCtrl = TextEditingController(text: daan.description);
    buttonLabelCtrl = TextEditingController(text: daan.buttonLabel);
    urlCtrl = TextEditingController(text: daan.redirectUrl);
    imagePath.value = daan.imageUrl;
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path;
    }
  }

  void updateDaan() {
    if (descCtrl.text.trim().isEmpty || buttonLabelCtrl.text.trim().isEmpty || urlCtrl.text.trim().isEmpty) {
      Get.snackbar("Error", "All fields are required", backgroundColor: Colors.red);
      return;
    }

    final updated = DaanModel(
      id: daan.id,
      imageUrl: imagePath.value,
      title: descCtrl.text.trim(),
      description: descCtrl.text.trim(),
      buttonLabel: buttonLabelCtrl.text.trim(),
      redirectUrl: urlCtrl.text.trim(),
    );

    Get.find<DaanListController>().updateDaan(updated);
    Get.offAllNamed("/success_donation"); // ya jo bhi tera success route hai
  }

  void deleteDaan() {
    Get.find<DaanListController>().deleteDaan(daan.id!);
    Get.offAllNamed(MyPagesName.donation);
    Get.snackbar("Deleted", "Daan deleted successfully", backgroundColor: Colors.red);
  }

  @override
  void onClose() {
    descCtrl.dispose();
    buttonLabelCtrl.dispose();
    urlCtrl.dispose();
    super.onClose();
  }
}