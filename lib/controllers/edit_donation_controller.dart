import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/donation_model.dart';
import '../myRoutes/mypagesname.dart';
import '../screens/dashboard/donation/succes_donation_page.dart';

import 'donation_list.dart';

class EditDaanController extends GetxController {
  late DaanModel daan;
  late TextEditingController descCtrl;
  late TextEditingController buttonLabelCtrl;
  late TextEditingController urlCtrl;
  var imagePath = ''.obs;

  @override
  void onInit() {
    daan = Get.arguments as DaanModel;
    descCtrl = TextEditingController(text: daan.description);
    buttonLabelCtrl = TextEditingController(text: daan.buttonLabel);
    urlCtrl = TextEditingController(text: daan.redirectUrl);
    imagePath.value = daan.imageUrl;
    super.onInit();
  }

  void updateDaan() {
    final updated = DaanModel(
      id: daan.id,
      imageUrl: imagePath.value,
      title: descCtrl.text,
      description: descCtrl.text,
      buttonLabel: buttonLabelCtrl.text,
      redirectUrl: urlCtrl.text,
    );
    Get.find<DaanListController>().updateDaan(updated);
    Get.offAll(() => DaanSuccessPage(isEdit: true));
  }

  void deleteDaan() {
    Get.find<DaanListController>().deleteDaan(daan.id!);
    Get.offAllNamed(MyPagesName.donation);
  }

  @override
  void onClose() {
    descCtrl.dispose();
    buttonLabelCtrl.dispose();
    urlCtrl.dispose();
    super.onClose();
  }
}