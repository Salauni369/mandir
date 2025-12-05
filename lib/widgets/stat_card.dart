// import 'package:flutter/material.dart';
//
// class StatCard extends StatelessWidget {
//   final String title, value, percent;
//   final Color color;
//   const StatCard({super.key, required this.title, required this.value, required this.percent, required this.color});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: const BoxDecoration(color: Colors.white),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//             Text(percent, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
//           ]),
//           const SizedBox(height: 16),
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             const Text("This Month", style: TextStyle(fontSize: 13, color: Colors.black)),
//             Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//           ]),
//         ],
//       ),
//     );
//   }
// }
