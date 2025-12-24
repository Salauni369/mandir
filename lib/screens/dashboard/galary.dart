// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:dotted_border/dotted_border.dart';
// // import 'package:cached_network_image/cached_network_image.dart';
// //
// // import '../../controllers/manage_controller.dart';
// // import '../../utils/imageconverter.dart';
// // import 'galaryviewer.dart';
// //
// // class GalleryTab extends StatelessWidget {
// //   const GalleryTab({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final controller = Get.find<ManageController>();
// //
// //     return SingleChildScrollView(
// //       padding: const EdgeInsets.all(16),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // HEADER INFO BOX
// //           Container(
// //             width: double.infinity,
// //             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
// //             decoration: BoxDecoration(
// //               color: const Color(0xFFFFF1E9),
// //               borderRadius: BorderRadius.circular(8),
// //             ),
// //             child: const Text(
// //               "Upload Images\nSupported formats: JPG, PNG, Max size 2MB",
// //               style: TextStyle(fontSize: 12, color: Colors.grey),
// //             ),
// //           ),
// //
// //           const SizedBox(height: 14),
// //
// //           // UPLOAD BUTTON
// //           GestureDetector(
// //             onTap: controller.pickAndAddImage,
// //             child: DottedBorder(
// //               color: const Color(0xFFFF7722),
// //               strokeWidth: 2,
// //               dashPattern: const [6, 4],
// //               borderType: BorderType.RRect,
// //               radius: const Radius.circular(12),
// //               child: Container(
// //                 width: double.infinity,
// //                 padding: const EdgeInsets.all(30),
// //                 child: const Column(
// //                   children: [
// //                     Icon(Icons.cloud_upload, size: 50, color: Color(0xFFFF7722)),
// //                     SizedBox(height: 12),
// //                     Text(
// //                       "Upload Image",
// //                       style: TextStyle(
// //                         color: Color(0xFFFF7722),
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                     ),
// //                     SizedBox(height: 8),
// //                     Text(
// //                       "Please upload JPG / PNG under 2MB",
// //                       style: TextStyle(fontSize: 12, color: Colors.grey),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //
// //           const SizedBox(height: 20),
// //
// //           // SAVED IMAGES HEADER
// //           Text(
// //             "Saved Images",
// //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
// //           ),
// //
// //           const SizedBox(height: 12),
// //
// //           // IMAGES GRID
// //           Obx(() {
// //             print("imges data  =>>> ${controller.galleryImages.length}");
// //             if (controller.galleryImages.isEmpty) {
// //               return const Center(
// //                 child: Padding(
// //                   padding: EdgeInsets.all(40),
// //                   child: Text(
// //                     "No images yet.\nTap 'Upload Image' to add.",
// //                     textAlign: TextAlign.center,
// //                     style: TextStyle(fontSize: 14, color: Colors.grey),
// //                   ),
// //                 ),
// //               );
// //             }
// //
// //              return GridView.builder(
// //               itemCount: galleryImages.length,
// //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                 crossAxisCount: 3,
// //                 crossAxisSpacing: 6,
// //                 mainAxisSpacing: 6,
// //               ),
// //               itemBuilder: (context, index) {
// //                 return GestureDetector(
// //                   onTap: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (_) => GalleryViewerPage(
// //                           images: galleryImages,
// //                           initialIndex: index,
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                   child: Image.network(
// //                     galleryImages[index],
// //                     fit: BoxFit.cover,
// //                   ),
// //                 );
// //               },
// //             );
// //
// //           }),
// //
// //           const SizedBox(height: 50),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// import '../../controllers/manage_controller.dart';
// import '../../utils/imageconverter.dart';
// import 'galaryviewer.dart';
//
// class GalleryTab extends StatelessWidget {
//   const GalleryTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<ManageController>();
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // HEADER INFO BOX
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//             decoration: BoxDecoration(
//               color: const Color(0xFFFFF1E9),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Text(
//               "Upload Images\nSupported formats: JPG, PNG, Max size 2MB",
//               style: TextStyle(fontSize: 12, color: Colors.grey),
//             ),
//           ),
//
//           const SizedBox(height: 14),
//
//           // UPLOAD BUTTON
//           GestureDetector(
//             onTap: controller.pickAndAddImage,
//             child: DottedBorder(
//               color: const Color(0xFFFF7722),
//               strokeWidth: 2,
//               dashPattern: const [6, 4],
//               borderType: BorderType.RRect,
//               radius: const Radius.circular(12),
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(30),
//                 child: const Column(
//                   children: [
//                     Icon(Icons.cloud_upload,
//                         size: 50, color: Color(0xFFFF7722)),
//                     SizedBox(height: 12),
//                     Text(
//                       "Upload Image",
//                       style: TextStyle(
//                         color: Color(0xFFFF7722),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       "Please upload JPG / PNG under 2MB",
//                       style: TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 20),
//
//           // SAVED IMAGES HEADER
//           const Text(
//             "Saved Images",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//
//           const SizedBox(height: 12),
//
//           // IMAGES GRID
//           Obx(() {
//             if (controller.galleryImages.isEmpty) {
//               return const Center(
//                 child: Padding(
//                   padding: EdgeInsets.all(40),
//                   child: Text(
//                     "No images yet.\nTap 'Upload Image' to add.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 14, color: Colors.grey),
//                   ),
//                 ),
//               );
//             }
//
//             return GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: controller.galleryImages.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 6,
//                 mainAxisSpacing: 6,
//               ),
//               itemBuilder: (context, index) {
//                 final imagePath = controller.galleryImages[index];
//
//                 if (imagePath.isEmpty) {
//                   return _brokenImage();
//                 }
//
//                 final isNetwork = imagePath.startsWith('http');
//
//                 final optimizedPath = isNetwork
//                     ? ImageConverter.optimizeCloudinaryUrl(imagePath)
//                     : imagePath;
//
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => GalleryViewerPage(
//                           images: controller.galleryImages,
//                           initialIndex: index,
//                         ),
//                       ),
//                     );
//                   },
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: isNetwork
//                         ? CachedNetworkImage(
//                       imageUrl: optimizedPath,
//                       fit: BoxFit.cover,
//                       placeholder: (_, __) => Container(
//                         color: Colors.grey.shade200,
//                         child: const Center(
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                           ),
//                         ),
//                       ),
//                       errorWidget: (_, __, ___) => _brokenImage(),
//                     )
//                         : _localImage(optimizedPath),
//                   ),
//                 );
//               },
//             );
//           }),
//
//           const SizedBox(height: 50),
//         ],
//       ),
//     );
//   }
//
//   Widget _localImage(String path) {
//     final file = File(path);
//
//     if (!file.existsSync()) {
//       return _brokenImage();
//     }
//
//     return Image.file(
//       file,
//       fit: BoxFit.cover,
//       errorBuilder: (_, __, ___) => _brokenImage(),
//     );
//   }
//
//   Widget _brokenImage() {
//     return Container(
//       color: Colors.grey.shade200,
//       child: const Icon(Icons.broken_image, color: Colors.grey),
//     );
//   }
// }
//
//

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image/image.dart' as img; // Safe decode ke liye

import '../../controllers/manage_controller.dart';
import '../../utils/imageconverter.dart';
import 'galaryviewer.dart';

class GalleryTab extends StatelessWidget {
  const GalleryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ManageController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER INFO BOX
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1E9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Upload Images\nSupported formats: JPG, PNG, Max size 2MB",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),

          const SizedBox(height: 14),

          // UPLOAD BUTTON
          GestureDetector(
            onTap: controller.pickAndAddImage,
            child: DottedBorder(
              color: const Color(0xFFFF7722),
              strokeWidth: 2,
              dashPattern: const [6, 4],
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                child: const Column(
                  children: [
                    Icon(Icons.cloud_upload, size: 50, color: Color(0xFFFF7722)),
                    SizedBox(height: 12),
                    Text(
                      "Upload Image",
                      style: TextStyle(
                        color: Color(0xFFFF7722),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Please upload JPG / PNG under 2MB",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // SAVED IMAGES HEADER
          const Text(
            "Saved Images",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 12),

          // IMAGES GRID
          Obx(() {
            print("Gallery images count =>>> ${controller.galleryImages.length}");

            if (controller.galleryImages.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    "No images yet.\nTap 'Upload Image' to add.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.galleryImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              itemBuilder: (context, index) {
                final imagePath = controller.galleryImages[index];

                if (imagePath.isEmpty) {
                  return _brokenImage();
                }

                final isNetwork = imagePath.startsWith('http');
                final displayPath = isNetwork
                    ? ImageConverter.optimizeCloudinaryUrl(imagePath)
                    : imagePath;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GalleryViewerPage(
                          images: controller.galleryImages,
                          initialIndex: index,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: isNetwork
                        ? CachedNetworkImage(
                      imageUrl: displayPath,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (_, __, ___) => _brokenImage(),
                    )
                        : _safeLocalImage(displayPath),
                  ),
                );
              },
            );
          }),

          // SAVE GALLERY BUTTON (Agar chahiye to)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: controller.isSaving.value ? null : controller.saveGallery,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: controller.isSaving.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  "Save Gallery",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }

  // 🔥 SAFE LOCAL IMAGE – Koi bhi format handle karega (AVIF, WEBP, HEIC bhi)
  Widget _safeLocalImage(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      return _brokenImage();
    }

    try {
      final bytes = file.readAsBytesSync();
      final decoded = img.decodeImage(bytes);

      if (decoded == null) {
        return _brokenImage();
      }

      return Image.memory(
        Uint8List.fromList(img.encodeJpg(decoded, quality: 90)),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _brokenImage(),
      );
    } catch (e) {
      print("Failed to decode local gallery image: $e");
      return _brokenImage();
    }
  }

  Widget _brokenImage() {
    return Container(
      color: Colors.grey.shade200,
      child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
    );
  }
}
