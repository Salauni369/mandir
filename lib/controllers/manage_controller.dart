import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:zamboree_devotion/widgets/app_colors.dart';

import '../address/repository/temple_service.dart';
import '../models/dashboard_model.dart';
import '../models/location_model.dart';
import '../models/social_media.dart';
import '../models/timming_model.dart';
import '../../controllers/dashboard_cotroller.dart';
import '../screens/dashboard/overview.dart';
import '../widgets/imageuploadwidget.dart';
import '../../utils/api_header.dart';
import '../../utils/apiconstants.dart';
import 'package:get_storage/get_storage.dart';


class ManageController extends GetxController {
  final box = GetStorage();

  final activeTab = 0.obs;
  final RxString mainImage = "".obs;

  // 🔥 TEXT CONTROLLERS (DECLARE AT TOP)
  final nameCtrl = TextEditingController();
  final aboutCtrl = TextEditingController();
  final contactCtrl = TextEditingController();

  // 🔥 SOCIAL MEDIA CONTROLLERS (MOVED TO TOP)
  final youtubeCtrl = TextEditingController();
  final facebookCtrl = TextEditingController();
  final instagramCtrl = TextEditingController();
  final linkedinCtrl = TextEditingController();

  // 🔥 NEW: SAVED LOCATION OBSERVABLES
  final savedLat = 0.0.obs;
  final savedLng = 0.0.obs;
  final savedCity = ''.obs;
  final savedState = ''.obs;
  final savedAddress = ''.obs;

  final location = LocationModel(
    address: '',
    area: '',
    pincode: '',
    city: '',
    state: '',
  ).obs;

  final darshanTimings = <TimingModel>[].obs;
  final aartiTimings = <TimingModel>[].obs;
  final socialList = <SocialModel>[].obs;
  final selectedIndex = (-1).obs;
  final galleryImages = <String>[].obs;
  final additionalSections = <AdditionalSection>[].obs;
  final isSaving = false.obs;

  // 🔥 SELECTION MODE
  final isSelectionMode = false.obs;
  final selectedImages = <int>[].obs;

  @override
  void onInit() {
    super.onInit();

    // 🔥 LOAD SAVED LOCATION FROM GETSTORAGE
    loadSavedLocation();

    final dash = Get.find<TempleHomeController>();

    if (dash.homeData.value != null) {
      fillFromApi(dash.homeData.value!);
    }

    ever(dash.homeData, (dynamic data) {
      if (data is TempleHomeModel) {
        fillFromApi(data);
      }
    });
  }

  // 🔥 NEW FUNCTION - LOAD FROM GETSTORAGE
  void loadSavedLocation() {
    savedLat.value = (box.read("saved_lat") ?? 0.0).toDouble();
    savedLng.value = (box.read("saved_lng") ?? 0.0).toDouble();
    savedCity.value = box.read("saved_city") ?? '';
    savedState.value = box.read("saved_state") ?? '';
    savedAddress.value = box.read("saved_address") ?? '';

    print("📍 Loaded Location: $savedCity, $savedState");
    print("🗺️ Lat: $savedLat, Lng: $savedLng");
  }

  // ============================
  // TAB NAVIGATION
  // ============================
  void nextTab() {
    if (activeTab.value < 4) activeTab.value++;
  }

  void previousTab() {
    if (activeTab.value > 0) activeTab.value--;
  }

  void changeTab(int idx) => activeTab.value = idx;

  // ============================
  // FILL FROM API
  // ============================
  void fillFromApi(TempleHomeModel home) {
    if (home == null) return;

    nameCtrl.text = home.name ?? "";
    aboutCtrl.text = home.about ?? "";
    contactCtrl.text = home.contactNumber ?? "";

    // Main Image
    final String? apiImage = home.image;
    if (apiImage != null &&
        apiImage.isNotEmpty &&
        apiImage.startsWith("http") &&
        !apiImage.contains("image-url")) {
      mainImage.value = apiImage;
      print("🖼️ Loaded existing image: $apiImage");
    } else {
      mainImage.value = "";
      print("⚠️ No valid image found in API");
    }

    // Location
    location.value = LocationModel(
      address: "",
      area: "",
      pincode: "",
      state: home.location["state"]?.toString() ?? "",
      city: home.location["city"]?.toString() ?? "",
    );

    // Darshan Timings
    final darshanList = home.timings["darshan"] as List<dynamic>? ?? [];
    darshanTimings.assignAll(darshanList.map<TimingModel>((e) {
      final map = e as Map<String, dynamic>? ?? {};
      return TimingModel(
        title: map["title"]?.toString() ?? "",
        startTime: map["start"]?.toString() ?? "",
        endTime: map["end"]?.toString() ?? "",
      );
    }).toList());

    // Aarti Timings
    final aartiList = home.timings["aarti"] as List<dynamic>? ?? [];
    aartiTimings.assignAll(aartiList.map<TimingModel>((e) {
      final map = e as Map<String, dynamic>? ?? {};
      return TimingModel(
        title: map["title"]?.toString() ?? "",
        startTime: map["start"]?.toString() ?? "",
        endTime: map["end"]?.toString() ?? "",
      );
    }).toList());

    // 🔥 SOCIAL LINKS - TEXT CONTROLLERS FILL
    youtubeCtrl.text = home.socialLinks["youtube"]?.toString() ?? "";
    facebookCtrl.text = home.socialLinks["facebook"]?.toString() ?? "";
    instagramCtrl.text = home.socialLinks["instagram"]?.toString() ?? "";
    linkedinCtrl.text = home.socialLinks["linkedIn"]?.toString() ?? "";

    // Social Links (for display list if needed)
    socialList.assignAll([
      SocialModel(
        platform: "YouTube",
        prefix: "youtube.com/",
        username: home.socialLinks["youtube"]?.toString() ?? "",
        enabled: true,
      ),
      SocialModel(
        platform: "Facebook",
        prefix: "facebook.com/",
        username: home.socialLinks["facebook"]?.toString() ?? "",
        enabled: true,
      ),
      SocialModel(
        platform: "Instagram",
        prefix: "instagram.com/",
        username: home.socialLinks["instagram"]?.toString() ?? "",
        enabled: true,
      ),
      SocialModel(
        platform: "LinkedIn",
        prefix: "linkedin.com/in/",
        username: home.socialLinks["linkedIn"]?.toString() ?? "",
        enabled: false,
      ),
    ]);

    // Gallery
    galleryImages.assignAll(home.galleryImages ?? []);

    // Additional Info
    additionalSections.clear();
    final infoList = home.additionalInfo ?? [];
    if (infoList.isEmpty) {
      additionalSections.add(AdditionalSection());
    } else {
      for (var item in infoList) {
        final section = AdditionalSection();
        section.titleCtrl.text = item.title?.toString() ?? "";
        section.contentCtrl.text = item.content?.toString() ?? "";
        additionalSections.add(section);
      }
    }
  }

  Future<void> saveLocation() async {
    if (isSaving.value) return;

    isSaving(true);

    try {
      final box = GetStorage();

      final double lat = (box.read("saved_lat") ?? 0.0).toDouble();
      final double lng = (box.read("saved_lng") ?? 0.0).toDouble();

      final String city = box.read("saved_city") ?? '';
      final String state = box.read("saved_state") ?? '';
      final String country = box.read("saved_country") ?? 'India';

      if (lat == 0.0 || lng == 0.0) {
        throw "Please select location first";
      }

      // 🔥 NO API CALL - JUST LOCAL STORAGE
      print("📍 Location saved locally:");
      print("   LAT: $lat, LNG: $lng");
      print("   City: $city, State: $state");

      // ✅ Success message
      Get.snackbar(
        "Success ✅",
        "Location saved successfully!",
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );

      // 🔄 Reload to update UI
      loadSavedLocation();

    } catch (e) {
      Get.snackbar(
        "Error ❌",
        e.toString(),
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        icon: const Icon(Icons.error, color: Colors.white),
      );
    } finally {
      isSaving(false);
    }
  }

  // TIMING MANAGEMENT
  // ============================
  void addDarshanTiming(TimingModel t) => darshanTimings.add(t);
  void addAartiTiming(TimingModel t) => aartiTimings.add(t);

  // ============================
  // GALLERY MANAGEMENT
  // ============================
  void selectImage(int index) => selectedIndex.value = index;
  void clearSelection() => selectedIndex.value = -1;

  Future<void> pickAndAddImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      galleryImages.add(pickedFile.path);
    }
  }

  // ============================
  // 🔥 MAIN IMAGE PICKER (OVERVIEW)
  // ============================
  Future<void> pickMainImage(BuildContext context) async {
    final picker = ImagePicker();

    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (picked == null) return;

    final cropped = await ImageCropper().cropImage(
      sourcePath: picked.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppColors.hinduBase,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: 'Crop Image'),
      ],
    );

    if (cropped != null) {
      mainImage.value = cropped.path;
    }
  }

  // ============================
  // 🔥 PICK MULTIPLE IMAGES
  // ============================
  Future<void> pickMultipleImages() async {
    final picker = ImagePicker();

    final pickedFiles = await picker.pickMultiImage(
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (pickedFiles.isEmpty) {
      print("No images selected");
      return;
    }

    Get.dialog(
      Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
              ),
              const SizedBox(height: 16),
              Text(
                "Adding ${pickedFiles.length} images...",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    for (var file in pickedFiles) {
      galleryImages.add(file.path);
    }

    Get.back();

    Get.snackbar(
      "Images Added ✅",
      "${pickedFiles.length} images added. Don't forget to save!",
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );

    print("✅ Added ${pickedFiles.length} images to gallery");
  }

  // ============================
  // 🔥 SELECTION MODE FUNCTIONS
  // ============================
  void startSelection(int index) {
    isSelectionMode.value = true;
    selectedImages.add(index);
    print("🔥 Selection mode started with index $index");
  }

  void toggleImageSelection(int index) {
    if (selectedImages.contains(index)) {
      selectedImages.remove(index);
      print("❌ Deselected index $index");
    } else {
      selectedImages.add(index);
      print("✅ Selected index $index");
    }

    if (selectedImages.isEmpty) {
      cancelSelection();
    }
  }

  void cancelSelection() {
    isSelectionMode.value = false;
    selectedImages.clear();
    print("🔥 Selection mode cancelled");
  }

  void deleteSelectedImages() {
    final sortedIndices = selectedImages.toList()..sort((a, b) => b.compareTo(a));

    for (int index in sortedIndices) {
      if (index >= 0 && index < galleryImages.length) {
        final removedPath = galleryImages[index];
        galleryImages.removeAt(index);
        print("🗑️ Removed image at index $index: $removedPath");
      }
    }

    cancelSelection();
  }

  void removeImage(int index) {
    if (index >= 0 && index < galleryImages.length) {
      final removedPath = galleryImages[index];
      galleryImages.removeAt(index);
      print("🗑️ Removed image at index $index: $removedPath");
    }
  }

  void clearAllImages() {
    galleryImages.clear();
    print("🗑️ Cleared all gallery images");
  }

  // ============================
  // 🔥 1. SAVE OVERVIEW
  // ============================
  Future<void> saveAll() async {
    if (isSaving.value) return;

    if (nameCtrl.text.trim().isEmpty) {
      Get.snackbar(
        "Error ❌",
        "Temple name is required",
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error, color: Colors.white),
      );
      return;
    }

    if (aboutCtrl.text.trim().isEmpty) {
      Get.snackbar(
        "Error ❌",
        "About us is required",
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error, color: Colors.white),
      );
      return;
    }

    isSaving(true);

    Get.dialog(
      Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
              ),
              SizedBox(height: 20),
              Text(
                "Uploading Images...",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Please wait",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    try {
      print("🚀 Starting saveAll...");
      print("📝 Temple Name: ${nameCtrl.text.trim()}");
      print("📝 About Us: ${aboutCtrl.text.trim()}");
      print("📝 Contact: ${contactCtrl.text.trim()}");

      final aboutTemple = additionalSections
          .where((s) =>
      s.titleCtrl.text.trim().isNotEmpty &&
          s.contentCtrl.text.trim().isNotEmpty)
          .map((s) => {
        "title": s.titleCtrl.text.trim(),
        "content": s.contentCtrl.text.trim(),
      })
          .toList();

      print("📝 About Temple Sections: ${aboutTemple.length}");

      String? localImagePath;
      String? existingHttpUrl;

      if (mainImage.value.isNotEmpty) {
        if (mainImage.value.startsWith('/')) {
          localImagePath = mainImage.value;
          print("🖼️ Local image detected: $localImagePath");
        } else if (mainImage.value.startsWith('http')) {
          existingHttpUrl = mainImage.value;
          print("🖼️ Existing HTTP image: $existingHttpUrl");
        }
      } else {
        print("⚠️ No image selected");
      }

      final responseJson = await TempleAllService.updateTempleOverview(
        templeName: nameCtrl.text.trim(),
        mainImagePath: localImagePath,
        existingImageUrl: existingHttpUrl,
        aboutUs: aboutCtrl.text.trim(),
        aboutTemple: aboutTemple,
        contactNumber: contactCtrl.text.trim(),
      );

      Get.back();

      print("✅ Update Response: $responseJson");

      Get.snackbar(
        "Success ✅",
        responseJson["message"] ?? "Temple overview updated successfully!",
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );

      await Get.find<TempleHomeController>().fetchHomeData();

      final dash = Get.find<TempleHomeController>();
      if (dash.homeData.value != null) {
        fillFromApi(dash.homeData.value!);
      }
    } catch (e) {
      Get.back();
      print("❌ SaveAll Error: $e");

      Get.snackbar(
        "Error ❌",
        "Failed to update: $e",
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 5),
        icon: const Icon(Icons.error, color: Colors.white),
      );
    } finally {
      isSaving(false);
    }
  }

  // ============================
  // 🔥 2. SAVE TIMING
  // ============================
  Future<void> saveTiming() async {
    if (isSaving.value) return;

    if (darshanTimings.isEmpty && aartiTimings.isEmpty) {
      Get.snackbar(
        "Error ❌",
        "Please add at least one timing",
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error, color: Colors.white),
      );
      return;
    }

    isSaving(true);
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      print("🕐 Starting timing update...");

      final darshanList = darshanTimings
          .where((t) => t.title.trim().isNotEmpty)
          .map((t) => {
        "title": t.title.trim(),
        "start": t.startTime.trim(),
        "end": t.endTime.trim(),
      })
          .toList();

      final aartiList = aartiTimings
          .where((t) => t.title.trim().isNotEmpty)
          .map((t) => {
        "title": t.title.trim(),
        "start": t.startTime.trim(),
        "end": t.endTime.trim(),
      })
          .toList();

      print("📝 Darshan Timings: ${darshanList.length}");
      print("📝 Aarti Timings: ${aartiList.length}");

      final responseJson = await TempleAllService.updateTempleTiming(
        darshan: darshanList,
        aarti: aartiList,
      );

      Get.back();

      print("✅ Timing Response: $responseJson");

      Get.snackbar(
        "Success ✅",
        responseJson["message"] ?? "Temple timings updated successfully!",
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );

      await Get.find<TempleHomeController>().fetchHomeData();
    } catch (e) {
      Get.back();
      print("❌ Timing Error: $e");

      Get.snackbar(
        "Error ❌",
        "Failed to update timings: $e",
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 5),
        icon: const Icon(Icons.error, color: Colors.white),
      );
    } finally {
      isSaving(false);
    }
  }

  // ============================
  // 🔥 3. SAVE SOCIAL MEDIA
  // ============================
  Future<void> saveSocial() async {
    if (isSaving.value) return;

    isSaving(true);
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      print("🌐 Starting social media update...");
      final responseJson = await TempleAllService.updateTempleSocial(
        facebook: facebookCtrl.text,
        instagram: instagramCtrl.text,
        youtube: youtubeCtrl.text,
        linkedin: linkedinCtrl.text,
      );

      Get.back();

      if (responseJson.isNotEmpty) {
        final social = responseJson["data"]["social_links"] ?? {};

        youtubeCtrl.text = social["youtube"] ?? "";
        facebookCtrl.text = social["facebook"] ?? "";
        instagramCtrl.text = social["instagram"] ?? "";
        linkedinCtrl.text = social["linkedin"] ?? "";
      }

      Get.snackbar(
        "Success ✅",
        responseJson["message"] ?? "Social links updated successfully!",
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );

      await Get.find<TempleHomeController>().fetchHomeData();
    } catch (e) {
      Get.back();
      print("❌ Social Error: $e");

      Get.snackbar(
        "Error ❌",
        "Failed to update social links: $e",
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 5),
        icon: const Icon(Icons.error, color: Colors.white),
      );
    } finally {
      isSaving(false);
    }
  }

  // ============================
  // 🔥 SAVE GALLERY IMAGES
  // ============================
  Future<void> saveGallery() async {
    if (isSaving.value) return;

    isSaving(true);
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final List<String> localPaths = [];
      final List<String> existingUrls = [];

      for (String path in galleryImages) {
        if (path.startsWith('/')) {
          localPaths.add(path);
        } else if (path.startsWith('http')) {
          existingUrls.add(path);
        }
      }

      print("Local images to upload: ${localPaths.length}");
      print("Existing URLs: ${existingUrls.length}");

      final responseJson = await TempleAllService.updateTempleGallery(
        localImagePaths: localPaths,
        existingUrls: existingUrls,
      );

      Get.back();

      final newGallery = List<String>.from(responseJson["data"]["gallery_images"] ?? []);
      galleryImages.assignAll(newGallery);

      Get.snackbar(
        "Success ✅",
        "Gallery updated successfully!",
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );

      await Get.find<TempleHomeController>().fetchHomeData();
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error ❌",
        "Failed to update gallery: $e",
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error, color: Colors.white),
      );
      print("Gallery Save Error: $e");
    } finally {
      isSaving(false);
    }
  }

  // ============================
  // CLEANUP
  // ============================
  @override
  void onClose() {
    nameCtrl.dispose();
    aboutCtrl.dispose();
    contactCtrl.dispose();
    youtubeCtrl.dispose();
    facebookCtrl.dispose();
    instagramCtrl.dispose();
    linkedinCtrl.dispose();

    for (var section in additionalSections) {
      section.titleCtrl.dispose();
      section.contentCtrl.dispose();
    }

    super.onClose();
  }
}