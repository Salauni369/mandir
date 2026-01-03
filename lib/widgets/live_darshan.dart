//
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../models/live_darshan_model.dart';
// import '../screens/dashboard/live_darshan/darshan_details.dart';
// import '../utils/imageconverter.dart';
//
// Widget loadImage(String? path, {double? height, double? width, BoxFit fit = BoxFit.cover}) {
//   if (path == null || path.isEmpty) {
//     return Container(
//       height: height,
//       width: width,
//       color: Colors.grey.shade300,
//       child: Icon(Icons.image),
//     );
//   }
//
//   if (path.startsWith("http")) {
//     return Image.network(ImageConverter.optimizeCloudinaryUrl(path).toString(), height: height, width: width, fit: fit);
//   }
//
//   return Image.file(File(path), height: height, width: width, fit: fit);
// }
//
// // class DarshanCard extends StatelessWidget {
// //   final DarshanModel darshan;
// //   final VoidCallback? onTap;
// //
// //   const DarshanCard({
// //     super.key,
// //     required this.darshan,
// //     this.onTap,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //
// //           Container(
// //             height: 160,
// //             width: 160,
// //             color: Colors.grey.shade200,
// //             child: Stack(
// //               children: [
// //                 Positioned.fill(
// //                   child: loadImage(
// //                     darshan.mobile_image ,
// //                     height: 130,
// //                     width: 130,
// //                   ),
// //                 ),
// //
// //                 if (darshan.isLive)
// //                   Positioned(
// //                     top: 6,
// //                     left: 6,
// //                     child: Container(
// //                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
// //                       decoration: BoxDecoration(
// //                         color: Colors.red,
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                       child: Text(
// //                         "LIVE",
// //                         style: TextStyle(color: Colors.white, fontSize: 10),
// //                       ),
// //                     ),
// //                   ),
// //               ],
// //             ),
// //           ),
// //
// //           SizedBox(height: 6),
// //
// //           SizedBox(
// //             width: 100,
// //             child: Text(
// //               darshan.title,
// //               maxLines: 2,
// //               overflow: TextOverflow.ellipsis,
// //               style: TextStyle(fontSize: 12, color: Colors.black),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// class DarshanCard extends StatelessWidget {
//   final DarshanModel darshan;
//   final VoidCallback? onTap;
//
//   const DarshanCard({
//     super.key,
//     required this.darshan,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(6),
//         ),
//         child: Stack(
//           children: [
//             // IMAGE + TITLE (SAME BOX)
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipRRect(
//                   borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(6)),
//                   child: loadImage(
//                     darshan.mobile_image,
//                     height: 160,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.all(6),
//                   child: Text(
//                     darshan.title.isNotEmpty ? darshan.title : "Untitled",
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//             // 🔴 LIVE TAG — RIGHT TOP
//             if (darshan.isLive)
//               Positioned(
//                 top: 6,
//                 right: 6,
//                 child: Container(
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Text(
//                     "LIVE",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/live_darshan_model.dart';
import '../screens/dashboard/live_darshan/darshan_details.dart';
import '../utils/imageconverter.dart';

// ================= IMAGE LOADER =================
Widget loadImage(
    String? path, {
      double? height,
      double? width,
      BoxFit fit = BoxFit.cover,
    }) {
  if (path == null || path.isEmpty) {
    return Container(
      height: height,
      width: width,
      color: Colors.grey.shade300,
      child: const Icon(Icons.image),
    );
  }

  if (path.startsWith("http")) {
    return Image.network(
      ImageConverter.optimizeCloudinaryUrl(path),
      height: height,
      width: width,
      fit: fit,
    );
  }

  return Image.file(
    File(path),
    height: height,
    width: width,
    fit: fit,
  );
}

// ================= DARSHAN CARD =================
class DarshanCard extends StatelessWidget {
  final DarshanModel darshan;
  final VoidCallback? onTap;

  const DarshanCard({
    super.key,
    required this.darshan,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
              () => Get.to(
                () => DarshanDetailPage(darshan: darshan),
          ),
      child: SizedBox(
        width: 155,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= IMAGE (FULLY ROUNDED) =================
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6), // 🔥 top + bottom
                  child: loadImage(
                    darshan.mobileImage,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // ================= LIVE BADGE =================
                if (darshan.isLive)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "LIVE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 4),

            // ================= TITLE (SEPARATE FROM IMAGE) =================
            Text(
              darshan.title.isNotEmpty ? darshan.title : "Untitled",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
