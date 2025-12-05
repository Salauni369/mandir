// // // import 'package:get/get.dart';
// // // import 'package:image_picker/image_picker.dart';
// // //
// // // class GalleryController extends GetxController {
// // //   var images = <String>[].obs;
// // //   @override
// // //   void onInit() {
// // //     super.onInit();
// // //     images.assignAll(List.filled(8, "assets/images/temp.png"));
// // //   }
// // //
// // //   void deleteImage(int i) {
// // //     images.removeAt(i);
// // //   }
// // //
// // //   Future<void> pickAndAddImage() async {
// // //     final picker = ImagePicker();
// // //     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
// // //
// // //     if (pickedFile != null) {
// // //       images.add(pickedFile.path);
// // //     }
// // //   }
// // //
// // //
// // //   void addImage(String path) {
// // //     images.add(path);
// // //   }
// // // }
// //
// //
// // import 'dart:io';
// // import 'package:get/get.dart';
// // import 'package:image_picker/image_picker.dart';
// //
// // class GalleryController extends GetxController {
// //
// //   // All gallery images (assets or uploaded)
// //   var images = <String>[].obs;
// //
// //   final picker = ImagePicker();
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //
// //     // Start with empty (your screenshot matches this)
// //     images.assignAll([]);
// //   }
// //
// //   // Upload
// //   Future<void> pickAndAddImage() async {
// //     final picked = await picker.pickImage(source: ImageSource.gallery);
// //
// //     if (picked != null) {
// //       images.add(picked.path);
// //     }
// //   }
// //
// //   // Single delete
// //   void deleteImage(int index) {
// //     images.removeAt(index);
// //   }
// // }
import 'dart:io';
import 'dart:math' as math;   // <-- correct & safe name
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GalleryController extends GetxController {
  var images = <String>[].obs;

  // --- Upload progress list ---
  var uploadingList = <UploadingItem>[].obs;

  var selectedIndex = (1).obs;

  Future<void> pickAndAddImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final uploadItem = UploadingItem(
        file: File(pickedFile.path),
        progress: 0,
      );

      uploadingList.add(uploadItem);

      for (int p = 0; p <= 100; p += 10) {
        await Future.delayed(const Duration(milliseconds: 150));
        uploadItem.progress = p;
        uploadingList.refresh();
      }

      await Future.delayed(const Duration(seconds: 1));
      images.add(pickedFile.path);
      uploadingList.remove(uploadItem);

      showUploadSuccessPopup(); // popup call
    }
  }

  void deleteImage(int index) {
    images.removeAt(index);
  }

  void selectImage(int index) {
    selectedIndex.value = index;
  }

  void clearSelection() {
    selectedIndex.value = -1;
  }
}

void showUploadSuccessPopup() {
  Get.dialog(
    Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 10),
            Text(
              "Image uploaded successfully",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );

  Future.delayed(const Duration(seconds: 1), () {
    Get.back();
  });
}

class UploadingItem {
  File file;
  int progress;
  UploadingItem({required this.file, required this.progress});
}


//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// class GalleryController extends GetxController {
//   // All gallery images paths
//   final images = <String>[].obs;
//
//   // Uploading progress list
//   final uploadingList = <UploadingItem>[].obs;
//
//   // Optionally track selected index
//   final selectedIndex = (-1).obs;
//
//   final ImagePicker _picker = ImagePicker();
//
//   @override
//   void onInit() {
//     super.onInit();
//     images.assignAll([]); // start empty
//   }
//
//   // SINGLE image picker
//   Future<void> pickAndAddImage() async {
//     final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
//     if (picked == null) return;
//     await _processFile(picked);
//   }
//
//   // MULTI image picker
//   Future<void> pickAndAddImages() async {
//     final List<XFile>? pickedFiles = await _picker.pickMultiImage();
//     if (pickedFiles == null || pickedFiles.isEmpty) return;
//
//     for (final file in pickedFiles) {
//       await _processFile(file);
//     }
//
//     // optional final popup after all complete
//     showUploadSuccessPopup();
//   }
//
//   // Common processing: fake upload, add to images, remove progress item
//   Future<void> _processFile(XFile file) async {
//     final uploadItem = UploadingItem(file: File(file.path), progress: 0);
//     uploadingList.add(uploadItem);
//     uploadingList.refresh();
//
//     // fake upload progress loop (replace with real upload)
//     for (int p = 0; p <= 100; p += 10) {
//       await Future.delayed(const Duration(milliseconds: 120));
//       uploadItem.progress = p;
//       uploadingList.refresh();
//     }
//
//     // small delay after upload
//     await Future.delayed(const Duration(milliseconds: 300));
//
//     images.add(file.path);
//     uploadingList.remove(uploadItem);
//   }
//
//   void deleteImage(int index) {
//     if (index >= 0 && index < images.length) images.removeAt(index);
//   }
//
//   void selectImage(int index) {
//     selectedIndex.value = index;
//   }
//
//   void clearSelection() => selectedIndex.value = -1;
//
//   // Show a popup — define inside controller to avoid undefined-reference errors
//   void showUploadSuccessPopup() {
//     Get.dialog(
//       Center(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.15),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               )
//             ],
//           ),
//           child: const Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(Icons.check_circle, color: Colors.green, size: 28),
//               SizedBox(width: 10),
//               Text(
//                 "Image(s) uploaded successfully",
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//         ),
//       ),
//       barrierDismissible: true,
//     );
//
//     Future.delayed(const Duration(seconds: 1), () {
//       if (Get.isDialogOpen ?? false) Get.back();
//     });
//   }
// }
//
// // Simple UploadingItem model (keep in same file or import from where defined)
// class UploadingItem {
//   File file;
//   int progress; // 0 - 100
//   UploadingItem({required this.file, required this.progress});
// }
//
//
