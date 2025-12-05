// import 'package:get/get.dart';
//
// import '../models/live_darshan_model.dart';
//
// class DarshanController extends GetxController {
//   final list = <DarshanModel>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     list.assignAll([
//       DarshanModel(
//         id: '1',
//         title: 'ISKCON Krishna Janmashtami Celebration',
//         subtitle: 'Live Darshan from Vrindavan',
//         image: 'https://via.placeholder.com/200',
//         isLive: true,
//         date: 'Today • Live',
//         description: 'Full Janmashtami celebration darshan…',
//       ),
//       DarshanModel(
//         id: '2',
//         title: 'Evening Aarti Special',
//         subtitle: 'Live Darshan from Vrindavan',
//         image: 'https://via.placeholder.com/200',
//         isLive: true,
//         date: 'Today • Live',
//         description: 'Evening aarti bhajans…',
//       ),
//     ]);
//   }
// }


// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../models/live_darshan_model.dart';
//
//
// class DarshanController extends GetxController {
//   final list = <DarshanModel>[].obs;
//
//   var webImage = "".obs;
//   var mobileImage = "".obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     list.assignAll([
//       DarshanModel(
//         id: '1',
//         title: 'ISKCON Krishna Janmashtami',
//         subtitle: 'Vrindavan Live',
//         webImage: 'https://via.placeholder.com/200',
//         mobileImage: 'https://via.placeholder.com/200',
//         isLive: true,
//         date: 'Today',
//         description: 'Darshan...',
//       ),
//     ]);
//   }
//
//   Future<void> pickWebImage() async {
//     final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (picked != null) webImage.value = picked.path;
//   }
//
//   Future<void> pickMobileImage() async {
//     final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (picked != null) mobileImage.value = picked.path;
//   }
//
//   void addDarshan(String title, String subtitle, String date) {
//     list.add(
//       DarshanModel(
//         id: DateTime.now().millisecondsSinceEpoch.toString(),
//         title: title,
//         subtitle: subtitle,
//         webImage: webImage.value,
//         mobileImage: mobileImage.value,
//         isLive: true,
//         date: date,
//       ),
//     );
//   }
// }

// lib/controllers/darshan_controller.dart
// import 'package:get/get.dart';
// import '../models/live_darshan_model.dart';
// import '../services/livedarshan.dart';
//
// class DarshanController extends GetxController {
//   var darshans = <DarshanModel>[].obs;
//   var isLoading = true.obs;
//
//   @override
//   void onInit() {
//     fetchDarshans();
//     super.onInit();
//   }
//
//   Future<void> fetchDarshans() async {
//     try {
//       isLoading(true);
//       darshans.value = await DarshanService.getAll();
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<void> addDarshan(DarshanModel darshan) async {
//     await DarshanService.add(darshan);
//     await fetchDarshans();
//     Get.back();
//     Get.snackbar("Success", "Darshan Added Successfully");
//   }
//
//   Future<void> updateDarshan(DarshanModel darshan) async {
//     await DarshanService.update(darshan);
//     await fetchDarshans();
//     Get.back();
//     Get.snackbar("Success", "Darshan Updated Successfully");
//   }
//
//   Future<void> deleteDarshan(String id) async {
//     await DarshanService.delete(id);
//     await fetchDarshans();
//     Get.snackbar("Deleted", "Darshan removed");
//   }
// }



import 'package:get/get.dart';
import '../models/live_darshan_model.dart';
import '../services/livedarshan.dart';

class DarshanController extends GetxController {
  var darshans = <DarshanModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDarshans();
  }

  Future<void> fetchDarshans() async {
    try {
      isLoading(true);
      final data = await DarshanService.getAll();

      // Sort newest first (optional but recommended)
      data.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      darshans.value = data;
    } catch (e) {
      print("Fetch error: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> addDarshan(DarshanModel darshan) async {
    try {
      await DarshanService.add(darshan);
      await fetchDarshans();
      Get.back();
      Get.snackbar("Success", "Darshan Added Successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to add Darshan");
    }
  }

  Future<void> updateDarshan(DarshanModel darshan) async {
    try {
      await DarshanService.update(darshan);
      await fetchDarshans();
      Get.back();
      Get.snackbar("Success", "Darshan Updated Successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to update Darshan");
    }
  }

  Future<void> deleteDarshan(String id) async {
    try {
      await DarshanService.delete(id);
      await fetchDarshans();
      Get.snackbar("Deleted", "Darshan removed");
    } catch (e) {
      Get.snackbar("Error", "Failed to delete Darshan");
    }
  }
}
