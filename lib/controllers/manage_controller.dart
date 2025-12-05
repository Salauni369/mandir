// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../models/location_model.dart';
// import '../models/social_media.dart';
//
// import '../models/timming_model.dart';
//
// class ManageController extends GetxController {
//   // tab index (replaces setState and local selectedIndex)
//   final activeTab = 0.obs;
//
//   // Overview fields controllers (preserve input values across rebuilds)
//
//   final RxString mainImage = "".obs;
//
//   final nameCtrl = TextEditingController();
//   final aboutCtrl = TextEditingController();
//   final contactCtrl = TextEditingController();
//
//   // Location model
//   final location = LocationModel(
//     address: '',
//     area: '',
//     pincode: '',
//     city: '',
//   ).obs;
//
//   // Timings
//   final darshanTimings = <TimingModel>[].obs;
//   final aartiTimings = <TimingModel>[].obs;
//
//   // Social media list
//   final socialList = <SocialModel>[].obs;
//
//   final selectedIndex = (-1).obs;
//
//   // Gallery images (asset paths or network URLs)
//   final galleryImages = <String>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _loadMockData(); // load mocked data for now
//   }
//
//   void changeTab(int idx) => activeTab.value = idx;
//
//   // ---------- Mock loading (replace with service calls later) ----------
//   void _loadMockData() {
//     nameCtrl.text = "ISKCON Temple Vrindavan";
//     aboutCtrl.text = "Write about your temple...";
//     contactCtrl.text = "+91 9853228287";
//
//     location.value = LocationModel(
//       address: "HMRB-182",
//       area: "Raman Reti",
//       pincode: "281121",
//       city: "Vrindavan",
//     );
//
//     darshanTimings.assignAll([
//       TimingModel(
//         title: "Morning Darshan",
//         startTime: "04:30 AM",
//         endTime: "01:00 PM",
//       ),
//       TimingModel(
//         title: "Evening Darshan",
//         startTime: "04:00 PM",
//         endTime: "09:00 PM",
//       ),
//     ]);
//
//     aartiTimings.assignAll([
//       TimingModel(
//         title: "Morning Aarti",
//         startTime: "04:30 AM",
//         endTime: "05:15 AM",
//       ),
//     ]);
//
//     socialList.assignAll([
//       SocialModel(
//         platform: "YouTube",
//         prefix: "youtube.com/",
//         username: "@ISKCONVrindavan",
//         enabled: true,
//       ),
//       SocialModel(
//         platform: "Facebook",
//         prefix: "facebook.com/",
//         username: "iskconvrindavan",
//         enabled: true,
//       ),
//       SocialModel(
//         platform: "Instagram",
//         prefix: "instagram.com/",
//         username: "iskcon_vrindavana",
//         enabled: true,
//       ),
//       SocialModel(
//         platform: "LinkedIn",
//         prefix: "linkedin.com/in/",
//         username: "N/A",
//         enabled: false,
//       ),
//     ]);
//     // Future<void> pickMainImage() async {
//     //   final picker = ImagePicker();
//     //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     //
//     //   if (pickedFile != null) {
//     //     mainImage.value = pickedFile.path; // UI will auto update
//     //   }
//     // }
//
//     //galleryImages.assignAll(List.filled(8, "assets/images/temp.png"));
//   }
//
//   void addDarshanTiming(TimingModel t) => darshanTimings.add(t);
//   void removeDarshanTimingAt(int idx) => darshanTimings.removeAt(idx);
//
//   void selectImage(int index) {
//     selectedIndex.value = index;
//   }
//
//   void clearSelection() {
//     selectedIndex.value = -1;
//   }
//
//   void addAartiTiming(TimingModel t) => aartiTimings.add(t);
//   void removeAartiTimingAt(int idx) => aartiTimings.removeAt(idx);
//   Future<void> pickAndAddImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       galleryImages.add(pickedFile.path);
//     }
//   }
//
//   void updateSocialUsername(int idx, String value) {
//     if (idx < 0 || idx >= socialList.length) return;
//     socialList[idx].username = value;
//     socialList.refresh();
//   }
//
//   void addGalleryImage(String path) => galleryImages.add(path);
//   void removeGalleryImageAt(int idx) => galleryImages.removeAt(idx);
//
//   Future<void> saveAll() async {
//     // placeholder: call service to persist data
//     // ManageService.updateTempleDetails(...)
//     await Future.delayed(const Duration(milliseconds: 300));
//     Get.snackbar(
//       "Saved",
//       "All changes updated!",
//       backgroundColor: Colors.green,
//       colorText: Colors.white,
//     );
//   }
//   // PICK IMAGE FROM CAMERA
//   Future<void> pickMainImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(
//       source: ImageSource.camera,
//       imageQuality: 80,
//     );
//
//     if (pickedFile != null) {
//       mainImage.value = pickedFile.path;
//     }
//   }
//
//
//   @override
//   void onClose() {
//     // dispose controllers to prevent memory leaks
//     nameCtrl.dispose();
//     aboutCtrl.dispose();
//     contactCtrl.dispose();
//     super.onClose();
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/dashboard_model.dart';
import '../models/location_model.dart';
import '../models/social_media.dart';
import '../models/timming_model.dart';
import '../../controllers/dashboard_cotroller.dart';

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

  // ------------------------------------------------------------------
  // 🔥 FINAL CORRECT FILL FUNCTION – 100% MATCHED WITH YOUR MODEL
  // ------------------------------------------------------------------
  void fillFromApi(TempleHomeModel home) {
    // Overview fields
    nameCtrl.text = home.name;
    aboutCtrl.text = home.about;
    contactCtrl.text = home.contactNumber;

    // Main image
    mainImage.value = home.image;

    // Location (API me sirf yahi data hai)
    location.value = LocationModel(
      address: "",
      area: "",
      pincode: "",
      state: "",
      city: home.location["city"] ?? "",
    );

    // Timings
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

    // Social not present in API → empty
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


    // Gallery
    galleryImages.assignAll(home.gallery);
  }

  // ------------------------------------------------------------------

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

  Future<void> pickMainImage() async {
    final picker = ImagePicker();
    final pickedFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    if (pickedFile != null) mainImage.value = pickedFile.path;
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

