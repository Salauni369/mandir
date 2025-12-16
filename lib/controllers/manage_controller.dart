import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../models/dashboard_model.dart';
import '../models/location_model.dart';
import '../models/social_media.dart';
import '../models/timming_model.dart';
import '../../controllers/dashboard_cotroller.dart';
import '../widgets/imageuploadwidget.dart';
class ManageController extends GetxController {
  final activeTab = 0.obs;

  final RxString mainImage = "".obs;

  final nameCtrl = TextEditingController();
  final aboutCtrl = TextEditingController();
  final contactCtrl = TextEditingController();

  final location = LocationModel(
      address: '',
      area: '',
      pincode: '',
      city: '',
      state: ''
  ).obs;

  final darshanTimings = <TimingModel>[].obs;
  final aartiTimings = <TimingModel>[].obs;

  final socialList = <SocialModel>[].obs;

  final selectedIndex = (-1).obs;

  final galleryImages = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    final dash = Get.find<TempleHomeController>();

    if (dash.homeData.value != null) {
      fillFromApi(dash.homeData.value!);
    }

    ever(dash.homeData, (data) {
      if (data != null) fillFromApi(data);
    });
  }

  // ============================
  // 🔥 ADD BELOW — TAB CONTROLS
  // ============================

  void nextTab() {
    if (activeTab.value < 4) {
      activeTab.value++;
    }
  }

  void previousTab() {
    if (activeTab.value > 0) {
      activeTab.value--;
    }
  }

  // ============================


  void fillFromApi(TempleHomeModel home) {
    nameCtrl.text = home.name;
    aboutCtrl.text = home.about;
    contactCtrl.text = home.contactNumber;

    mainImage.value = home.image;

    location.value = LocationModel(
      address: "",
      area: "",
      pincode: "",
      state: "",
      city: home.location["city"] ?? "",
    );

    darshanTimings.assignAll(
      (home.timings["darshan"] ?? []).map<TimingModel>((e) {
        return TimingModel(
          title: e["title"] ?? "",
          startTime: e["start"] ?? "",
          endTime: e["end"] ?? "",
        );
      }).toList(),
    );

    aartiTimings.assignAll(
      (home.timings["aarti"] ?? []).map<TimingModel>((e) {
        return TimingModel(
          title: e["title"] ?? "",
          startTime: e["start"] ?? "",
          endTime: e["end"] ?? "",
        );
      }).toList(),
    );

    socialList.assignAll([
      SocialModel(
        platform: "YouTube",
        prefix: "youtube.com/",
        username: "",
        enabled: true,
      ),
      SocialModel(
        platform: "Facebook",
        prefix: "facebook.com/",
        username: "",
        enabled: true,
      ),
      SocialModel(
        platform: "Instagram",
        prefix: "instagram.com/",
        username: "",
        enabled: true,
      ),
    ]);

    galleryImages.assignAll(home.gallery);
  }

  // REQUIRED BY TIMING TAB
  void addDarshanTiming(TimingModel t) => darshanTimings.add(t);
  void addAartiTiming(TimingModel t) => aartiTimings.add(t);

  void changeTab(int idx) => activeTab.value = idx;

  void selectImage(int index) => selectedIndex.value = index;
  void clearSelection() => selectedIndex.value = -1;

  Future<void> pickAndAddImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) galleryImages.add(pickedFile.path);
  }

  Future<void> pickMainImage(BuildContext context) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final cropped = await ImageCropper().cropImage(
      sourcePath: picked.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Crop',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(),
          ],
        ),
      ],
    );

    if (cropped != null) {
      mainImage.value = cropped.path;
    }
  }

  Future<void> saveAll() async {
    await Future.delayed(const Duration(milliseconds: 300));
    Get.snackbar(
      "Saved",
      "All changes updated!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    aboutCtrl.dispose();
    contactCtrl.dispose();
    super.onClose();
  }
}
