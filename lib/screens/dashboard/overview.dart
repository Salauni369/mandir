import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/manage_controller.dart';

class OverviewTab extends StatefulWidget {
  const OverviewTab({super.key});

  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  late final ManageController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ManageController>();   // FIXED
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Obx(() {
                    return Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: controller.mainImage.value.isEmpty
                              ? const AssetImage("assets/images/temp.png")
                          as ImageProvider
                              : FileImage(File(controller.mainImage.value)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),

                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => controller.pickMainImage(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text("Name *",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            TextField(
              controller: controller.nameCtrl,
              style: const TextStyle(fontSize: 12, color: Colors.black),
              decoration: InputDecoration(
                hintText: "ISKCON Temple Vrindavan",
                filled: true,
                fillColor: const Color(0xFFF4F4F4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),

            const SizedBox(height: 20),

            const Text("About us *",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            TextField(
              controller: controller.aboutCtrl,
              maxLines: 6,
              style: const TextStyle(fontSize: 12, color: Colors.black),
              decoration: InputDecoration(
                hintText: "Write about your temple...",
                filled: true,
                fillColor: const Color(0xFFF4F4F4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),

            const SizedBox(height: 20),

            const Text("Contact Number *",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            TextField(
              controller: controller.contactCtrl,
              keyboardType: TextInputType.phone,
              style: const TextStyle(fontSize: 12, color: Colors.black),
              decoration: InputDecoration(
                hintText: "+91 9853228287",
                filled: true,
                fillColor: const Color(0xFFEBEBEA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),

            const SizedBox(height: 30),

            const Text("Additional Sections",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            _sectionTile("Title *", "****"),
            const SizedBox(height: 12),
            _sectionTile("Content *", "****"),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _sectionTile(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF4F4F4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}


//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/manage_controller.dart';
//
// class OverviewTab extends StatefulWidget {
//   const OverviewTab({super.key});
//
//   @override
//   State<OverviewTab> createState() => _OverviewTabState();
// }
//
// class _OverviewTabState extends State<OverviewTab> {
//   late final ManageController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = Get.put(ManageController());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Stack(
//                 children: [
//                   Obx(() {
//                     return Container(
//                       height: 160,
//                       width: 160,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         image: DecorationImage(
//                           image: controller.mainImage.value.isEmpty
//                               ? const AssetImage("assets/images/temp.png")
//                           as ImageProvider
//                               : FileImage(File(controller.mainImage.value)),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     );
//                   }),
//
//                   Positioned(
//                     bottom: 8,
//                     right: 8,
//                     child: GestureDetector(
//                       onTap: () => controller.pickMainImage(),
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: const BoxDecoration(
//                           color: Colors.black54,
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(Icons.camera_alt,
//                             color: Colors.white, size: 20),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             // NAME
//             const Text("Name *",
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
//             const SizedBox(height: 8),
//
//             TextField(
//               controller: controller.nameCtrl,
//               style: const TextStyle(fontSize: 12, color: Colors.black),
//               decoration: InputDecoration(
//                 hintText: "ISKCON Temple Vrindavan",
//                 filled: true,
//                 fillColor: const Color(0xFFF4F4F4),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(4),
//                   borderSide: BorderSide.none,
//                 ),
//                 contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             // ABOUT
//             const Text("About us *",
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
//             const SizedBox(height: 8),
//
//             TextField(
//               controller: controller.aboutCtrl,
//               maxLines: 6,
//               style: const TextStyle(fontSize: 12, color: Colors.black),
//               decoration: InputDecoration(
//                 hintText: "Write about your temple...",
//                 filled: true,
//                 fillColor: const Color(0xFFF4F4F4),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(4),
//                   borderSide: BorderSide.none,
//                 ),
//                 contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             // CONTACT
//             const Text("Contact Number *",
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
//             const SizedBox(height: 8),
//
//             TextField(
//               controller: controller.contactCtrl,
//               keyboardType: TextInputType.phone,
//               style: const TextStyle(fontSize: 12, color: Colors.black),
//               decoration: InputDecoration(
//                 hintText: "+91 9853228287",
//                 filled: true,
//                 fillColor: const Color(0xFFEBEBEA),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(4),
//                   borderSide: BorderSide.none,
//                 ),
//                 contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//               ),
//             ),
//
//             const SizedBox(height: 30),
//
//             const Text("Additional Sections",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 16),
//
//             _sectionTile("Title *", "****"),
//             const SizedBox(height: 12),
//             _sectionTile("Content *", "****"),
//
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _sectionTile(String label, String hint) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label,
//             style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
//         const SizedBox(height: 8),
//         TextField(
//           decoration: InputDecoration(
//             hintText: hint,
//             filled: true,
//             fillColor: const Color(0xFFF4F4F4),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(4),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding:
//             const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           ),
//         ),
//       ],
//     );
//   }
// }
