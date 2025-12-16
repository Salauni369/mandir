//
//
// // lib/widgets/darshan_card.dart
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../models/live_darshan_model.dart';
// import '../screens/dashboard/live_darshan/darshan_details.dart';
// import 'app_colors.dart';
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
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//           /// --- SQUARE IMAGE CARD (100x100) ---
//           Padding(
//             padding: const EdgeInsets.only(bottom: 4),
//             child: Container(
//               height: 160,
//               width: 160,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.zero,  // full square
//               ),
//               child: Stack(
//                 children: [
//                   Positioned.fill(
//                     child: Image.network(
//                       darshan.mobileImage ??
//                           darshan.webImage ??
//                           "https://picsum.photos/200",
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//
//                   /// LIVE TAG
//                   if (darshan.isLive)
//                     Positioned(
//                       top: 6,
//                       left: 6,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           "LIVE",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 10,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//
//           SizedBox(height: 6),
//
//           /// --- TEXT BELOW THE CARD ---
//           SizedBox(
//             width: 100,
//             child: Text(
//               darshan.title,
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/live_darshan_model.dart';
import '../screens/dashboard/live_darshan/darshan_details.dart';

Widget loadImage(String? path, {double? height, double? width, BoxFit fit = BoxFit.cover}) {
  if (path == null || path.isEmpty) {
    return Container(
      height: height,
      width: width,
      color: Colors.grey.shade300,
      child: Icon(Icons.image),
    );
  }

  if (path.startsWith("http")) {
    return Image.network(path, height: height, width: width, fit: fit);
  }

  return Image.file(File(path), height: height, width: width, fit: fit);
}

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
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            height: 160,
            width: 160,
            color: Colors.grey.shade200,
            child: Stack(
              children: [
                // Positioned.fill(
                //   child: loadImage(
                //     darshan.mobileImage ?? darshan.webImage,
                //     height: 130,
                //     width: 130,
                //   ),
                // ),

                if (darshan.isLive)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "LIVE",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 6),

          SizedBox(
            width: 100,
            child: Text(
              darshan.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
