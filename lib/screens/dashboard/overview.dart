//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/dashboard_cotroller.dart';
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
//    late final ManageController controller;
//
//   final manage = Get.find<ManageController>();
//
//
//   // Dynamic sections list
//   final List<AdditionalSection> additionalSections = [
//     AdditionalSection(), // First default section
//   ];
//   //
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   controller = Get.find<ManageController>();
//   // }
//
//    @override
//    void initState() {
//      super.initState();
//      controller = Get.find<ManageController>();
//
//      final homeCtrl = Get.find<TempleHomeController>();
//      if (homeCtrl.homeData.value != null) {
//        controller.fillFromApi(homeCtrl.homeData.value!);
//      }
//    }
//
//   void _addNewSection() {
//     additionalSections.clear();
//     setState(() {
//       additionalSections.assignAll(manage.additionalSections);
//     });
//   }
//
//   void _removeSection(int index) {
//     if (additionalSections.length > 1) {
//       setState(() {
//         additionalSections.removeAt(index);
//       });
//     } else {
//       Get.snackbar("Info", "At least one section is required");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
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
//                       height: 190,
//                       width: 350,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         image: DecorationImage(
//                           image: controller.mainImage.value.isEmpty
//                               ? const AssetImage("assets/images/temp.png")
//                               : controller.mainImage.value.startsWith("http")
//                               ? NetworkImage(controller.mainImage.value)
//                               : FileImage(File(controller.mainImage.value))
//                           as ImageProvider,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     );
//                   }),
//                   Positioned(
//                     bottom: 8,
//                     right: 8,
//                     child: GestureDetector(
//                       onTap: _showImagePickerSheet,
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: const BoxDecoration(
//                           color: Colors.black54,
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.camera_alt,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
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
//                 fillColor: Colors.white,
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(4),
//                   borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(4),
//                   borderSide:
//                   BorderSide(color: Colors.grey.shade600, width: 1.2),
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(4),
//                   borderSide: BorderSide(color: Colors.grey.shade300),
//                 ),
//                 contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
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
//                 fillColor: Colors.white,
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(4),
//                   borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(4),
//                   borderSide:
//                   BorderSide(color: Colors.grey.shade600, width: 1.2),
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(4),
//                   borderSide: BorderSide(color: Colors.grey.shade300),
//                 ),
//                 contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             const Text("Contact Number *",
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
//             const SizedBox(height: 8),
//
//             // DISABLED CONTACT NUMBER FIELD
//             TextField(
//               controller: controller.contactCtrl,
//               enabled: false, // DISABLED
//               keyboardType: TextInputType.phone,
//               style: const TextStyle(fontSize: 12, color: Colors.black54),
//               decoration: InputDecoration(
//                 hintText: "+91 9853228287",
//                 filled: true,
//                 fillColor: Colors.grey.shade100, // Disabled color
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(4),
//                   borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
//                 ),
//                 disabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(4),
//                   borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(4),
//                   borderSide: BorderSide(color: Colors.grey.shade300),
//                 ),
//                 contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//               ),
//             ),
//
//             const SizedBox(height: 30),
//
//             // ADDITIONAL SECTIONS HEADER WITH PLUS ICON
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text("Additional Sections",
//                     style:
//                     TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                 GestureDetector(
//                   onTap: _addNewSection,
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.black87,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Icon(
//                       Icons.add,
//                       color: Colors.white,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 16),
//
//             // DYNAMIC ADDITIONAL SECTIONS
//             // ...List.generate(additionalSections.length, (index) {
//             ...List.generate(controller.additionalSections.length, (index) {
//
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 16),
//                 child: _buildAdditionalSection(
//                   index: index,
//                   section: additionalSections[index],
//                   onRemove: () => _removeSection(index),
//                 ),
//               );
//             }),
//
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showImagePickerSheet() {
//     controller.pickMainImage(context);
//   }
//
//   Widget _buildAdditionalSection({
//     required int index,
//     required AdditionalSection section,
//     required VoidCallback onRemove,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Section Header with Delete Icon
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Section ${index + 1}",
//                 style: const TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87,
//                 ),
//               ),
//               if (additionalSections.length > 1)
//                 GestureDetector(
//                   onTap: onRemove,
//                   child: Icon(
//                     Icons.delete_outline,
//                     color: Colors.red.shade400,
//                     size: 20,
//                   ),
//                 ),
//             ],
//           ),
//
//
//
//           const SizedBox(height: 12),
//
//           // Title Field
//           const Text(
//             "Title *",
//             style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 8),
//           TextField(
//             controller: section.titleCtrl,
//             style: const TextStyle(fontSize: 12, color: Colors.black),
//             decoration: InputDecoration(
//               hintText: "Enter section title",
//               filled: true,
//               fillColor: Colors.white,
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(4),
//                 borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(4),
//                 borderSide: BorderSide(color: Colors.grey.shade600, width: 1.2),
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(4),
//                 borderSide: BorderSide(color: Colors.grey.shade300),
//               ),
//               contentPadding:
//               const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             ),
//           ),
//
//           const SizedBox(height: 12),
//
//           // Content Field (Same size as About Us)
//           const Text(
//             "Content *",
//             style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 8),
//           TextField(
//             controller: section.contentCtrl,
//             maxLines: 6, // Same as About Us field
//             style: const TextStyle(fontSize: 12, color: Colors.black),
//             decoration: InputDecoration(
//               hintText: "Enter section content",
//               filled: true,
//               fillColor: Colors.white,
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(4),
//                 borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(4),
//                 borderSide: BorderSide(color: Colors.grey.shade600, width: 1.2),
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(4),
//                 borderSide: BorderSide(color: Colors.grey.shade300),
//               ),
//               contentPadding:
//               const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Helper class to manage each additional section
// class AdditionalSection {
//   final TextEditingController titleCtrl = TextEditingController();
//   final TextEditingController contentCtrl = TextEditingController();
//
//   void dispose() {
//     titleCtrl.dispose();
//     contentCtrl.dispose();
//   }
// }



import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_cotroller.dart';
import '../../controllers/manage_controller.dart';
import '../../utils/imageconverter.dart';

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
    controller = Get.find<ManageController>();

    final homeCtrl = Get.find<TempleHomeController>();
    if (homeCtrl.homeData.value != null) {
      controller.fillFromApi(homeCtrl.homeData.value!);
    }
  }

  void _addNewSection() {
    controller.additionalSections.add(AdditionalSection());
  }

  void _removeSection(int index) {
    if (controller.additionalSections.length > 1) {
      controller.additionalSections.removeAt(index);
    } else {
      Get.snackbar("Info", "At least one section is required");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      height: 190,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          // image: controller.mainImage.value.isEmpty
                          //     ? const AssetImage("assets/images/temp.png")
                          //     : controller.mainImage.value.startsWith("http")
                          //     ? NetworkImage(controller.mainImage.value)
                          //     : FileImage(File(controller.mainImage.value))
                          // as ImageProvider,

                          image: controller.mainImage.value.isEmpty
                              ? const AssetImage("assets/images/temp.png")
                              : controller.mainImage.value.startsWith("http")
                              ? NetworkImage(
                            ImageConverter.optimizeCloudinaryUrl(
                              controller.mainImage.value,
                            ),
                          )
                              : FileImage(File(controller.mainImage.value))
                          as ImageProvider,

                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => controller.pickMainImage(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
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
              decoration: _inputDecoration("ISKCON Temple Vrindavan"),
            ),

            const SizedBox(height: 20),

            const Text("About us *",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            TextField(
              controller: controller.aboutCtrl,
              maxLines: 6,
              style: const TextStyle(fontSize: 12, color: Colors.black),
              decoration: _inputDecoration("Write about your temple..."),
            ),

            const SizedBox(height: 20),

            const Text("Contact Number *",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            TextField(
              controller: controller.contactCtrl,
              enabled: false,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
              decoration: _inputDecoration("+91 9853228287",
                  fill: Colors.grey.shade100),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Additional Sections",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: _addNewSection,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.add,
                        color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// 🔥 IMPORTANT FIX — OBSERVE CONTROLLER LIST
            Obx(() => Column(
              children: List.generate(
                controller.additionalSections.length,
                    (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildAdditionalSection(
                    index: index,
                    section: controller.additionalSections[index],
                    onRemove: () => _removeSection(index),
                  ),
                ),
              ),
            )),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalSection({
    required int index,
    required AdditionalSection section,
    required VoidCallback onRemove,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Section ${index + 1}",
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600)),
              if (controller.additionalSections.length > 1)
                GestureDetector(
                  onTap: onRemove,
                  child: Icon(Icons.delete_outline,
                      color: Colors.red.shade400, size: 20),
                ),
            ],
          ),
          const SizedBox(height: 12),
          const Text("Title *",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: section.titleCtrl,
            decoration: _inputDecoration("Enter section title"),
          ),
          const SizedBox(height: 12),
          const Text("Content *",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: section.contentCtrl,
            maxLines: 6,
            decoration: _inputDecoration("Enter section content"),
          ),
        ],
      ),
    );
  }
}

/// ---------------- HELPER ----------------
InputDecoration _inputDecoration(String hint,
    {Color fill = Colors.white}) {
  return InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: fill,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Colors.grey.shade600, width: 1.2),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
}

/// ---------------- SECTION MODEL ----------------
class AdditionalSection {
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController contentCtrl = TextEditingController();

  void dispose() {
    titleCtrl.dispose();
    contentCtrl.dispose();
  }
}
