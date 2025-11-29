import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/location_model.dart';
import '../models/social_media.dart';

import '../models/timming_model.dart';

class ManageController extends GetxController {
  // tab index (replaces setState and local selectedIndex)
  final activeTab = 0.obs;

  // Overview fields controllers (preserve input values across rebuilds)
  final nameCtrl = TextEditingController();
  final aboutCtrl = TextEditingController();
  final contactCtrl = TextEditingController();

  // Location model
  final location = LocationModel(address: '', area: '', pincode: '', city: '').obs;

  // Timings
  final darshanTimings = <TimingModel>[].obs;
  final aartiTimings = <TimingModel>[].obs;

  // Social media list
  final socialList = <SocialModel>[].obs;

  // Gallery images (asset paths or network URLs)
  final galleryImages = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockData(); // load mocked data for now
  }

  void changeTab(int idx) => activeTab.value = idx;

  // ---------- Mock loading (replace with service calls later) ----------
  void _loadMockData() {
    nameCtrl.text = "ISKCON Temple Vrindavan";
    aboutCtrl.text = "Write about your temple...";
    contactCtrl.text = "+91 9853228287";

    location.value = LocationModel(address: "HMRB-182", area: "Raman Reti", pincode: "281121", city: "Vrindavan");

    darshanTimings.assignAll([
      TimingModel(title: "Morning Darshan", startTime: "04:30 AM", endTime: "01:00 PM"),
      TimingModel(title: "Evening Darshan", startTime: "04:00 PM", endTime: "09:00 PM"),
    ]);

    aartiTimings.assignAll([
      TimingModel(title: "Morning Aarti", startTime: "04:30 AM", endTime: "05:15 AM"),
    ]);

    socialList.assignAll([
      SocialModel(platform: "YouTube", prefix: "youtube.com/", username: "@ISKCONVrindavan", enabled: true),
      SocialModel(platform: "Facebook", prefix: "facebook.com/", username: "iskconvrindavan", enabled: true),
      SocialModel(platform: "Instagram", prefix: "instagram.com/", username: "iskcon_vrindavana", enabled: true),
      SocialModel(platform: "LinkedIn", prefix: "linkedin.com/in/", username: "N/A", enabled: false),
    ]);

    galleryImages.assignAll(List.filled(8, "assets/images/temp.png"));
  }


  void addDarshanTiming(TimingModel t) => darshanTimings.add(t);
  void removeDarshanTimingAt(int idx) => darshanTimings.removeAt(idx);

  void addAartiTiming(TimingModel t) => aartiTimings.add(t);
  void removeAartiTimingAt(int idx) => aartiTimings.removeAt(idx);

  void updateSocialUsername(int idx, String value) {
    if (idx < 0 || idx >= socialList.length) return;
    socialList[idx].username = value;
    socialList.refresh();
  }

  void addGalleryImage(String path) => galleryImages.add(path);
  void removeGalleryImageAt(int idx) => galleryImages.removeAt(idx);

  Future<void> saveAll() async {
    // placeholder: call service to persist data
    // ManageService.updateTempleDetails(...)
    await Future.delayed(const Duration(milliseconds: 300));
    Get.snackbar("Saved", "All changes updated!", backgroundColor: Colors.green, colorText: Colors.white);
  }

  @override
  void onClose() {
    // dispose controllers to prevent memory leaks
    nameCtrl.dispose();
    aboutCtrl.dispose();
    contactCtrl.dispose();
    super.onClose();
  }
}
