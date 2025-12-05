// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import '../../../models/live_darshan_model.dart';
// //
// //
// // class DarshanDetailPage extends StatelessWidget {
// //   const DarshanDetailPage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final DarshanModel m = Get.arguments;
// //
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Details")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(14),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             ClipRRect(
// //               borderRadius: BorderRadius.circular(12),
// //               child: Image.network(m.image, height: 220, width: double.infinity, fit: BoxFit.cover),
// //             ),
// //             const SizedBox(height: 12),
// //             Text(m.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
// //             const SizedBox(height: 8),
// //             if (m.date != null) Text(m.date!, style: TextStyle(color: Colors.grey.shade700)),
// //             const SizedBox(height: 12),
// //             Text(m.description ?? "No description", style: const TextStyle(height: 1.4)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import '../../../models/live_darshan_model.dart';
// //
// // class DarshanDetailPage extends StatelessWidget {
// //   const DarshanDetailPage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final DarshanModel m = Get.arguments;
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFFFF7A00),
// //         title: const Text("Darshan Details"),
// //       ),
// //
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(14),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //
// //             // Top Temple Image
// //             ClipRRect(
// //               borderRadius: BorderRadius.circular(12),
// //               child: Image.network(
// //                 "https://images.unsplash.com/photo-1581349481720-7132fe1f944d",
// //                 height: 200,
// //                 width: double.infinity,
// //                 fit: BoxFit.cover,
// //               ),
// //             ),
// //
// //             const SizedBox(height: 14),
// //
// //             // YouTube Link
// //             Container(
// //               padding: const EdgeInsets.all(10),
// //               decoration: BoxDecoration(
// //                 border: Border.all(color: Colors.grey.shade300),
// //                 borderRadius: BorderRadius.circular(8),
// //               ),
// //               child: Row(
// //                 children: [
// //                   Expanded(child: Text("https://www.youtube.com/watch?v=grgY...")),
// //                   const Icon(Icons.open_in_new, size: 18),
// //                 ],
// //               ),
// //             ),
// //
// //             const SizedBox(height: 15),
// //
// //             // Title
// //             Text(
// //               m.title,
// //               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
// //             ),
// //
// //             const SizedBox(height: 15),
// //
// //             // Web & Mobile Images
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 _boxImage("Web Image", m.image),
// //                 _boxImage("Mobile Image", m.image),
// //               ],
// //             ),
// //
// //             const SizedBox(height: 20),
// //
// //             // Buttons
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 _whiteBtn("Back", () => Get.back()),
// //                 _orangeBtn("Edit", () {}),
// //               ],
// //             ),
// //
// //             const SizedBox(height: 30),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _boxImage(String title, String img) {
// //     return Container(
// //       width: 150,
// //       height: 150,
// //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
// //       child: Stack(
// //         children: [
// //           ClipRRect(
// //             borderRadius: BorderRadius.circular(12),
// //             child: Image.network(img, width: 150, height: 150, fit: BoxFit.cover),
// //           ),
// //           Container(
// //             alignment: Alignment.bottomCenter,
// //             padding: const EdgeInsets.all(6),
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(12),
// //               gradient: LinearGradient(
// //                 colors: [Colors.black.withOpacity(.7), Colors.transparent],
// //                 begin: Alignment.bottomCenter,
// //                 end: Alignment.topCenter,
// //               ),
// //             ),
// //             child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _whiteBtn(String txt, VoidCallback onTap) {
// //     return Expanded(
// //       child: OutlinedButton(
// //         onPressed: onTap,
// //         child: Text(txt),
// //       ),
// //     );
// //   }
// //
// //   Widget _orangeBtn(String txt, VoidCallback onTap) {
// //     return Expanded(
// //       child: ElevatedButton(
// //         onPressed: onTap,
// //         style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF7A00)),
// //         child: Text(txt),
// //       ),
// //     );
// //   }
// // }
//
//
//
//
// // -----------------------------
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../models/live_darshan_model.dart';
//
//
// class DarshanDetailPage extends StatelessWidget {
//   final DarshanModel ? darshan;
//
//   const DarshanDetailPage({super.key, this.darshan});
//
//
//   @override
//   Widget build(BuildContext context) {
//     final DarshanModel model = Get.arguments as DarshanModel;
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Darshan Details'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             model.image.startsWith('http')
//                 ? Image.network(model.image, height: 220, width: double.infinity, fit: BoxFit.cover)
//                 : Image.file(File(model.image), height: 220, width: double.infinity, fit: BoxFit.cover),
//             const SizedBox(height: 12),
//             Text(model.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
//             const SizedBox(height: 8),
//             Text(model.subtitle, style: const TextStyle(color: Colors.grey)),
//             const SizedBox(height: 12),
//             Text(model.description ?? ''),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 OutlinedButton(onPressed: () => Get.back(), child: const Text('Back')),
//                 ElevatedButton(onPressed: () => Get.toNamed('/add_edit', arguments: {'isEdit': true, 'model': model}), child: const Text('Edit')),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../models/live_darshan_model.dart';
// import 'edit_darshan.dart';
//
// class DarshanDetailPage extends StatelessWidget {
//   final DarshanModel? darshan;
//
//   const DarshanDetailPage({super.key, this.darshan});
//
//   @override
//   Widget build(BuildContext context) {
//     final DarshanModel model = Get.arguments as DarshanModel;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Darshan Details'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             model.image.startsWith('http')
//                 ? Image.network(
//               model.image,
//               height: 220,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             )
//                 : Image.file(
//               File(model.image),
//               height: 220,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//
//             const SizedBox(height: 12),
//
//             Text(
//               model.title,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//
//             const SizedBox(height: 8),
//
//             Text(
//               model.subtitle,
//               style: const TextStyle(color: Colors.grey),
//             ),
//
//             const SizedBox(height: 12),
//
//             Text(model.description),
//
//             const SizedBox(height: 20),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 OutlinedButton(
//                   onPressed: () => Get.back(),
//                   child: const Text('Back'),
//                 ),
//
//                 ElevatedButton(
//                   onPressed: () {
//                     Get.to(() => EditDarshanPage(darshan: model));
//                   },
//                   child: const Text('Edit'),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../models/live_darshan_model.dart';
// import 'edit_darshan.dart';
//
// class DarshanDetailPage extends StatelessWidget {
//   final DarshanModel? darshan;
//
//   const DarshanDetailPage({super.key, this.darshan});
//
//   @override
//   Widget build(BuildContext context) {
//     final model = darshan!;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFFFF7722),
//         title: const Text('Darshan Details',style: TextStyle(color: Colors.white),),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             model.image.startsWith('http')
//                 ? Image.network(
//               model.image,
//               height: 220,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             )
//                 : Image.file(
//               File(model.image),
//               height: 220,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//
//             const SizedBox(height: 12),
//
//             Text(
//               model.title,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//
//             const SizedBox(height: 8),
//
//             Text(
//               model.subtitle,
//               style: const TextStyle(color: Colors.grey),
//             ),
//
//             const SizedBox(height: 12),
//
//             Text(model.description),
//
//             const SizedBox(height: 20),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 OutlinedButton(
//                   onPressed: () => Get.back(),
//                   child: const Text('Back'),
//                 ),
//
//                 ElevatedButton(
//                   onPressed: () {
//                     Get.to(() => EditDarshanPage(darshan: model));
//                   },
//                   child: const Text('Edit'),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/live_darshan_model.dart';
import 'edit_darshan.dart';

class DarshanDetailPage extends StatelessWidget {
  final DarshanModel? darshan;

  const DarshanDetailPage({super.key, this.darshan});

  @override
  Widget build(BuildContext context) {
    final model = darshan!;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7722),
        title: const Text(
          'Darshan Details',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // ----------------------
            //  TEMPLE IMAGE (big)
            // ----------------------
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: model.image.startsWith("http")
                  ? Image.network(
                model.image,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              )
                  : Image.file(
                File(model.image),
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 12),

            // ----------------------
            //  LIVE LINK
            // ----------------------
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      model.liveLink,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const Icon(Icons.open_in_new, size: 18),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ----------------------
            // TITLE CENTER
            // ----------------------
            Text(
              model.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 22),

            // ----------------------
            //  TWO SQUARE IMAGE BOXES
            // ----------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _squareImageBox(
                  label: "Web Image",
                  img: model.webImage,
                ),
                _squareImageBox(
                  label: "Mobile Image",
                  img: model.mobileImage,
                ),
              ],
            ),

            const SizedBox(height: 120), // space for bottom buttons
          ],
        ),
      ),

      // ----------------------
      // FIXED BOTTOM BUTTONS
      // ----------------------
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            // Back Button
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.only(left:  16,right: 16,top: 8,bottom: 8),
                  side: BorderSide(color: Colors.grey.shade400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                onPressed: () => Get.back(),
                child: const Text(
                  "Back",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Edit Button
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7722),
                  padding: const EdgeInsets.only(left:  16,right: 16,top: 8,bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                onPressed: () {
                  Get.to(() => EditDarshanPage(darshan: model));
                },
                child: const Text(
                  "Edit",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // SQUARE IMAGE BOX (for Web Image / Mobile Image)
  // -------------------------------------------------------------------
  Widget _squareImageBox({required String label, required String? img}) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: img == null
              ? Container(
            width: 150,
            height: 150,
            color: Colors.grey.shade300,
            child: const Icon(Icons.image, size: 40),
          )
              : img.startsWith("http")
              ? Image.network(img, width: 150, height: 150, fit: BoxFit.cover)
              : Image.file(File(img), width: 150, height: 150, fit: BoxFit.cover),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}


