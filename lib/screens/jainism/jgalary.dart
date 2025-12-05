// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dotted_border/dotted_border.dart';
// import '../../controllers/manage_controller.dart';
//
//
// class GalleryTab extends StatelessWidget {
//   const GalleryTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final ManageController controller = Get.find();
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         const Text("Upload Images", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//         const SizedBox(height: 8),
//         DottedBorder(color: const Color(0xFFFF7722), strokeWidth: 2, dashPattern: const [6, 4], borderType: BorderType.RRect, radius: const Radius.circular(12), child: Container(width: double.infinity, padding: const EdgeInsets.all(30), child: Column(children: [Icon(Icons.cloud_upload, size: 50, color: const Color(0xFFFF7722)), const SizedBox(height: 12), const Text("Click to upload Photo", style: TextStyle(color: Color(0xFFFF7722))), const Text("Please share photos in JPG or PNG under 500 kb", style: TextStyle(fontSize: 12, color: Colors.grey))]))),
//         const SizedBox(height: 20),
//         const Text("Saved Images", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//         const Text("Images can be updated anytime", style: TextStyle(fontSize: 12, color: Colors.grey)),
//         const SizedBox(height: 16),
//         Obx(() => GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 12, mainAxisSpacing: 12),
//           itemCount: controller.galleryImages.length,
//           itemBuilder: (ctx, i) => Stack(children: [
//
//             ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(controller.galleryImages[i], fit: BoxFit.cover, width: double.infinity, height: double.infinity)),
//             Positioned(top: 4, right: 4, child: GestureDetector(onTap: () => controller.removeGalleryImageAt(i), child: const Icon(Icons.delete, color: Colors.red, size: 24))),
//           ]),
//         )),
//         const SizedBox(height: 50),
//       ]),
//     );
//   }
// }
