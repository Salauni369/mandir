import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/donation_model.dart';
import '../screens/dashboard/donation/succes_donation_page.dart';
import 'donation_list.dart';


class AddDaanController extends GetxController {
  final descCtrl = TextEditingController();
  final buttonLabelCtrl = TextEditingController();
  final urlCtrl = TextEditingController();
  var imagePath = ''.obs;

  bool hasChanges() =>
      descCtrl.text.isNotEmpty ||
          buttonLabelCtrl.text.isNotEmpty ||
          urlCtrl.text.isNotEmpty ||
          imagePath.value.isNotEmpty;

  void pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) imagePath.value = picked.path;
  }

  void saveDaan() async {
    if (descCtrl.text.isEmpty || buttonLabelCtrl.text.isEmpty || urlCtrl.text.isEmpty) {
      Get.snackbar("Error", "All fields required", backgroundColor: Colors.red);
      return;
    }

    final daan = DaanModel(
      imageUrl: imagePath.value.isEmpty
          ? "https://via.placeholder.com/300"
          : imagePath.value,
      title: descCtrl.text,
      description: descCtrl.text,
      buttonLabel: buttonLabelCtrl.text,
      redirectUrl: urlCtrl.text,
    );

    Get.find<DaanListController>().addDaan(daan);
    Get.offAll(() => DaanSuccessPage(isEdit: false));
  }

  @override
  void onClose() {
    descCtrl.dispose();
    buttonLabelCtrl.dispose();
    urlCtrl.dispose();
    super.onClose();
  }
}