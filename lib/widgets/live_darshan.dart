// // lib/widgets/darshan_card.dart
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../models/live_darshan_model.dart';
// import '../screens/dashboard/live_darshan/darshan_details.dart';
// import 'My_text.dart';
// import 'app_colors.dart';
//
// class DarshanCard extends StatelessWidget {
//   final DarshanModel darshan;
//
//   const DarshanCard({required this.darshan});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Get.to(() => DarshanDetailPage(darshan: darshan)),
//       child: Container(
//         margin: EdgeInsets.only(bottom: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                   child: Image.network(
//                     darshan.mobileImage ?? darshan.webImage ?? "https://picsum.photos/400",
//                     height: 180,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 if (darshan.isLive)
//                   Positioned(
//                     top: 12,
//                     left: 12,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.circle, color: Colors.white, size: 12),
//                           SizedBox(width: 6),
//                           Text("LIVE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(darshan.title, style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.white),),
//                   SizedBox(height: 8),
//                   Text(darshan.templeName, style:TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.white)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// lib/widgets/darshan_card.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/live_darshan_model.dart';
import '../screens/dashboard/live_darshan/darshan_details.dart';
import 'app_colors.dart';

class DarshanCard extends StatelessWidget {
  final DarshanModel darshan;
  final VoidCallback? onTap;

  const DarshanCard({
    Key? key,
    required this.darshan,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Get.to(() => DarshanDetailPage(darshan: darshan)),//
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    darshan.mobileImage ?? darshan.webImage ?? "https://picsum.photos/400",
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                if (darshan.isLive)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.circle, color: Colors.white, size: 12),
                          SizedBox(width: 6),
                          Text("LIVE",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(darshan.title,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                  SizedBox(height: 8),
                  Text(darshan.templeName,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



