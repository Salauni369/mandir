// import 'package:flutter/material.dart';
//
// import '../models/live_darshan_model.dart';
// import '../utils/imageconverter.dart';
// import 'app_colors.dart';
//
// class PastDarshanCard extends StatelessWidget {
//   final DarshanModel darshan;
//   final VoidCallback? onTap;
//
//   const PastDarshanCard({
//     super.key,
//     required this.darshan,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final imageUrl = (darshan.image.isNotEmpty)
//         ? ImageConverter.optimizeCloudinaryUrl(darshan.image)
//         : "https://picsum.photos/200";
//
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 16),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // IMAGE
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 imageUrl,
//                 width: 90,
//                 height: 90,
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => Container(
//                   width: 90,
//                   height: 90,
//                   color: Colors.grey.shade300,
//                   child: const Icon(Icons.image_not_supported),
//                 ),
//               ),
//             ),
//
//             const SizedBox(width: 12),
//
//             // TITLE + TAG
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     darshan.title,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//
//                   const SizedBox(height: 8),
//
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       "Ended on ${formatDate(darshan.createdAt)}",
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 11,
//                         //color: AppColors.greyL7,
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String formatDate(DateTime date) {
//     return "${date.day} ${_month(date.month)}, ${date.year}";
//   }
//
//   String _month(int m) {
//     const months = [
//       "Jan","Feb","Mar","Apr","May","Jun",
//       "Jul","Aug","Sep","Oct","Nov","Dec"
//     ];
//     return months[m - 1];
//   }
// }

import 'package:flutter/material.dart';

import '../models/live_darshan_model.dart';
import '../utils/imageconverter.dart';
import 'app_colors.dart';

class PastDarshanCard extends StatelessWidget {
  final DarshanModel darshan;
  final VoidCallback? onTap;

  const PastDarshanCard({
    super.key,
    required this.darshan,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 🔥 FIXED: Changed from darshan.image to darshan.mobile_image
    final imageUrl = (darshan.mobileImage != null && darshan.mobileImage!.isNotEmpty)
        ? ImageConverter.optimizeCloudinaryUrl(darshan.mobileImage!)
        : "https://picsum.photos/200";

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 90,
                  height: 90,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // TITLE + TAG
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    darshan.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Ended on ${formatDate(darshan.createdAt)}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return "${date.day} ${_month(date.month)}, ${date.year}";
  }

  String _month(int m) {
    const months = [
      "Jan","Feb","Mar","Apr","May","Jun",
      "Jul","Aug","Sep","Oct","Nov","Dec"
    ];
    return months[m - 1];
  }
}