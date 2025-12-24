// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
//
// class AddressCardShimmer extends StatelessWidget {
//   const AddressCardShimmer({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey.shade300,
//       highlightColor: Colors.grey.shade100,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         margin: const EdgeInsets.only(bottom: 8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(width: 0.8, color: Colors.grey.shade200),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 📍 Icon Placeholder
//             Container(
//               width: 30,
//               height: 30,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade400,
//                 borderRadius: BorderRadius.circular(6),
//               ),
//             ),
//             const SizedBox(width: 10),
//
//             // 🏠 Text Placeholders
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: 100,
//                     height: 12,
//                     color: Colors.grey.shade400,
//                   ),
//                   const SizedBox(height: 8),
//                   Container(
//                     width: double.infinity,
//                     height: 10,
//                     color: Colors.grey.shade400,
//                   ),
//                   const SizedBox(height: 6),
//                   Container(
//                     width: 150,
//                     height: 10,
//                     color: Colors.grey.shade400,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
