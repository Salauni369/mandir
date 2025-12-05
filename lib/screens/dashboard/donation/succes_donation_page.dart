// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:untitled/screens/dashboard/donation/donation_list_page.dart';
//
// import '../../../myRoutes/mypagesname.dart';
//
//
// class DaanSuccessPage extends StatelessWidget {
//   final bool isEdit;
//   const DaanSuccessPage({super.key, required this.isEdit});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.check_circle, size: 100, color: Colors.green),
//             const SizedBox(height: 24),
//             Text(
//               isEdit ? "Daan Changed Successfully" : "Daan Added Successfully",
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 12),
//             Text(
//               isEdit
//                   ? "Your daan entry is changed. You can review it or make changes whenever required."
//                   : "Your daan entry is ready. You can review it or make changes whenever required.",
//               textAlign: TextAlign.center,
//               style: const TextStyle(color: Colors.grey),
//             ),
//             const SizedBox(height: 40),
//             SizedBox(
//               width: 200,
//               height: 56,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF7722), shape: const StadiumBorder()),
//                 onPressed: () => Get.offAll(()=> DaanPage()),
//                 // onPressed: () => Get.offAllNamed(MyPagesName.donation),
//                 child: const Text("Continue", style: TextStyle(fontSize: 18, color: Colors.white)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }