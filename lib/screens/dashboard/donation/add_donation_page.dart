// // import 'dart:io';
// // import 'package:dotted_border/dotted_border.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:zamboree_devotion/common/util_method.dart';
// // import 'package:zamboree_devotion/utils/imageconverter.dart';
// //
// // import '../../../controllers/donation_controllers.dart';
// // import '../../../models/donation_model.dart';
// // import '../../../widgets/app_colors.dart';
// // import '../../../widgets/confordaan.dart' show showConfirmDiscard;
// // import '../../../widgets/successdaan.dart';
// //
// // class AddDaanPage extends StatefulWidget {
// //   @override
// //   State<AddDaanPage> createState() => _AddDaanPageState();
// // }
// //
// // class _AddDaanPageState extends State<AddDaanPage> {
// //   final controller = Get.find<DaanController>();
// //   final formKey = GlobalKey<FormState>();
// //
// //   final titleCtrl = TextEditingController();
// //   final buttonLabelCtrl = TextEditingController();
// //   final buttonUrlCtrl = TextEditingController();
// //
// //   String? imagePath;
// //
// //   bool get _hasInput =>
// //       titleCtrl.text.trim().isNotEmpty ||
// //       buttonLabelCtrl.text.trim().isNotEmpty ||
// //       buttonUrlCtrl.text.trim().isNotEmpty ||
// //       imagePath != null;
// //
// //   Future<bool> _onWillPop() async {
// //     if (!_hasInput) return true;
// //     final confirm = await showConfirmDiscard(
// //       title: 'Leave This Page?',
// //       content:
// //           "You've entered some information. If you go back, it will be lost.",
// //     );
// //     return confirm ?? false;
// //   }
// //
// //   // ---------- IMAGE PICKER ----------
// //   Future<String?> pickImage() async {
// //     final img = await ImagePicker().pickImage(source: ImageSource.gallery);
// //     return img?.path;
// //   }
// //
// //   InputDecoration daanFieldDecoration(String hint) {
// //     return InputDecoration(
// //       hintText: hint,
// //       hintStyle: const TextStyle(fontSize: 12, color: Colors.black54),
// //       filled: true,
// //       fillColor: const Color(0xFFF4F4F4),
// //       border: OutlineInputBorder(
// //         borderRadius: BorderRadius.circular(4),
// //         borderSide: BorderSide.none,
// //       ),
// //       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: _onWillPop,
// //       child: Scaffold(
// //         backgroundColor: Colors.white,
// //
// //         // ---------------- APP BAR ----------------
// //         appBar: AppBar(
// //           backgroundColor: AppColors.hinduBase,
// //           title: const Text("Add Daan", style: TextStyle(color: Colors.white)),
// //           shape: const RoundedRectangleBorder(
// //             borderRadius: BorderRadius.only(
// //               bottomLeft: Radius.circular(8),
// //               bottomRight: Radius.circular(8),
// //             ),
// //           ),
// //         ),
// //
// //         // ---------------- BOTTOM BUTTON ----------------
// //         bottomNavigationBar: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             const Divider(height: 0.2),
// //             Container(
// //               padding: const EdgeInsets.all(16),
// //               child: SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: AppColors.hinduBase,
// //                     padding: const EdgeInsets.symmetric(vertical: 10),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(50),
// //                     ),
// //                   ),
// //                   // onPressed: () async {
// //                   //   if (!formKey.currentState!.validate()) return;
// //                   //
// //                   //   if (imagePath == null) {
// //                   //     Get.snackbar(
// //                   //       "Error",
// //                   //       "Please upload an image",
// //                   //       backgroundColor: Colors.red,
// //                   //     );
// //                   //     return;
// //                   //   }
// //                   //
// //                   //   // Loading dialog show karo
// //                   //   Get.dialog(
// //                   //     const Center(child: CircularProgressIndicator()),
// //                   //     barrierDismissible: false,
// //                   //   );
// //                   //
// //                   //   // final newDaan = DaanModel(
// //                   //   //   id: '',
// //                   //   //   image: imagePath!,
// //                   //   //   donation_title: titleCtrl.text.trim(),
// //                   //   //   buttonText: buttonLabelCtrl.text.trim(),
// //                   //   //   buttonLink: buttonUrlCtrl.text.trim(),
// //                   //   // );
// //                   //
// //                   //   try {
// //                   //     // await controller.addDonation(
// //                   //     //   image: imagePath!,
// //                   //     //   title: titleCtrl.text.trim(),
// //                   //     //   button: buttonLabelCtrl.text.trim(),
// //                   //     //   buttonUrl: buttonUrlCtrl.text.trim(),
// //                   //     // );
// //                   //
// //                   //     await controller.addDonation(
// //                   //       title: titleCtrl.text.trim(),
// //                   //       buttonLabel: buttonLabelCtrl.text.trim(),
// //                   //       buttonUrl: buttonUrlCtrl.text.trim(),
// //                   //       imageUrl: imageUrl, // ✅ URL, not file path
// //                   //     );
// //                   //
// //                   //     Get.back(); // loading dialog band karo
// //                   //
// //                   //     // Success dialog dikhao
// //                   //     await showSuccessDialog(
// //                   //       title: "Daan Added Successfully",
// //                   //       subtitle: "Your daan entry is ready.",
// //                   //     );
// //                   //
// //                   //     Get.back(); // 🔥 YE LINE – page back ho jaayega (AddDaanPage se bahar)
// //                   //   } catch (e) {
// //                   //     Get.back(); // loading band (agar error aaya to)
// //                   //     Get.snackbar(
// //                   //       "Error",
// //                   //       e.toString(),
// //                   //       backgroundColor: Colors.red,
// //                   //       duration: const Duration(seconds: 5),
// //                   //     );
// //                   //   }
// //                   // },
// //                   onPressed: () async {
// //                     if (!formKey.currentState!.validate()) return;
// //
// //                     if (imagePath == null) {
// //                       Get.snackbar(
// //                         "Error",
// //                         "Please upload an image",
// //                         backgroundColor: Colors.red,
// //                       );
// //                       return;
// //                     }
// //
// //                     Get.dialog(
// //                       const Center(child: CircularProgressIndicator()),
// //                       barrierDismissible: false,
// //                     );
// //
// //                     try {
// //                       // ✅ STEP 1: image upload → URL
// //                       final String imageUrl =
// //                       await UtilMethod.uploadImageAndGetUrl(imagePath!);
// //
// //                       // ✅ STEP 2: donation create with URL
// //                       await controller.addDonation(
// //                         title: titleCtrl.text.trim(),
// //                         buttonLabel: buttonLabelCtrl.text.trim(),
// //                         buttonUrl: buttonUrlCtrl.text.trim(),
// //                         imageUrl: imageUrl,
// //                       );
// //
// //                       Get.back(); // loader close
// //
// //                       await showSuccessDialog(
// //                         title: "Daan Added Successfully",
// //                         subtitle: "Your daan entry is ready.",
// //                       );
// //
// //                       Get.back(); // page back
// //                     } catch (e) {
// //                       Get.back(); // loader close
// //                       Get.snackbar(
// //                         "Error",
// //                         e.toString(),
// //                         backgroundColor: Colors.red,
// //                         duration: const Duration(seconds: 5),
// //                       );
// //                     }
// //                   },
// //
// //                   child: const Text(
// //                     "Create",
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //
// //         // ---------------- BODY ----------------
// //         body: SingleChildScrollView(
// //           padding: const EdgeInsets.all(12),
// //           child: Form(
// //             key: formKey,
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Container(
// //                   width: double.infinity,
// //                   padding: const EdgeInsets.all(16),
// //                   color: const Color(0xFFFFF1E9),
// //                   child: const Text(
// //                     "Mobile Image\nSupported formats: JPG, PNG, GIF · Max size: 2 MB · 1 file only",
// //                     style: TextStyle(fontSize: 13, color: Colors.black87),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 12),
// //
// //                 GestureDetector(
// //                   onTap: () async {
// //                     final img = await pickImage();
// //                     if (img != null) {
// //                       final imageUrl = await UtilMethod.uploadImageAndGetUrl(
// //                         img,
// //                       );
// //                       setState(() => imagePath = imageUrl);
// //                     }
// //                   },
// //                   child: _uploadBox(imageUrl: imagePath),
// //                 ),
// //
// //                 const SizedBox(height: 24),
// //
// //                 // ---------- TITLE ----------
// //                 const Text(
// //                   "Daan Title *",
// //                   style: TextStyle(fontWeight: FontWeight.w700),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 TextFormField(
// //                   controller: titleCtrl,
// //                   maxLines: 4,
// //                   style: const TextStyle(fontSize: 12),
// //                   validator: (v) => v!.trim().isEmpty ? "Required" : null,
// //                   decoration: daanFieldDecoration("Write title..."),
// //                 ),
// //
// //                 const SizedBox(height: 24),
// //
// //                 // ---------- BUTTON LABEL ----------
// //                 const Text(
// //                   "Button Label *",
// //                   style: TextStyle(fontWeight: FontWeight.w700),
// //                 ),
// //                 const SizedBox(height: 8),
// //
// //                 TextFormField(
// //                   controller: buttonLabelCtrl,
// //                   style: const TextStyle(fontSize: 12),
// //                   validator: (v) => v!.trim().isEmpty ? "Required" : null,
// //                   decoration: daanFieldDecoration("Donate Now"),
// //                 ),
// //
// //                 const SizedBox(height: 24),
// //
// //                 // ---------- BUTTON URL ----------
// //                 const Text(
// //                   "Button URL *",
// //                   style: TextStyle(fontWeight: FontWeight.w700),
// //                 ),
// //                 const SizedBox(height: 8),
// //
// //                 TextFormField(
// //                   controller: buttonUrlCtrl,
// //                   style: const TextStyle(fontSize: 12),
// //                   validator: (v) => v!.trim().isEmpty ? "Required" : null,
// //                   decoration: daanFieldDecoration("Where button redirects..."),
// //                 ),
// //                 const SizedBox(height: 120),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _uploadBox({String? imageUrl}) {
// //     return DottedBorder(
// //       color: const Color(0xFFFF7722),
// //       strokeWidth: 2,
// //       dashPattern: const [6, 4],
// //       borderType: BorderType.RRect,
// //       radius: const Radius.circular(12),
// //       child: Container(
// //         width: double.infinity,
// //         height: 220,
// //         padding: imageUrl == null ? const EdgeInsets.all(24) : EdgeInsets.zero,
// //         child: imageUrl == null
// //             ? const Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Icon(Icons.cloud_upload, size: 50, color: Color(0xFFFF7722)),
// //                   SizedBox(height: 12),
// //                   Text(
// //                     "Upload Image",
// //                     style: TextStyle(
// //                       color: Color(0xFFFF7722),
// //                       fontWeight: FontWeight.w500,
// //                     ),
// //                   ),
// //                   SizedBox(height: 8),
// //                   Text(
// //                     "Please upload JPG / PNG under 2MB",
// //                     style: TextStyle(fontSize: 12, color: Colors.grey),
// //                   ),
// //                 ],
// //               )
// //             : ClipRRect(
// //                 borderRadius: BorderRadius.circular(10),
// //                 child: Image.network(
// //                   ImageConverter.optimizeCloudinaryUrl(imageUrl),
// //                   fit: BoxFit.cover,
// //                   width: double.infinity,
// //                   height: double.infinity,
// //                 ),
// //               ),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'dart:io';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:zamboree_devotion/common/util_method.dart';
// import 'package:zamboree_devotion/utils/imageconverter.dart';
//
// import '../../../controllers/donation_controllers.dart';
// import '../../../models/donation_model.dart';
// import '../../../widgets/app_colors.dart';
// import '../../../widgets/confordaan.dart' show showConfirmDiscard;
// import '../../../widgets/successdaan.dart';
//
// class AddDaanPage extends StatefulWidget {
//   @override
//   State<AddDaanPage> createState() => _AddDaanPageState();
// }
//
// class _AddDaanPageState extends State<AddDaanPage> {
//   final controller = Get.find<DaanController>();
//   final formKey = GlobalKey<FormState>();
//
//   final titleCtrl = TextEditingController();
//   final buttonLabelCtrl = TextEditingController();
//   final buttonUrlCtrl = TextEditingController();
//
//   String? imageUrl; // ✅ Store URL, not path
//   bool isUploading = false;
//
//   bool get _hasInput =>
//       titleCtrl.text.trim().isNotEmpty ||
//           buttonLabelCtrl.text.trim().isNotEmpty ||
//           buttonUrlCtrl.text.trim().isNotEmpty ||
//           imageUrl != null;
//
//   Future<bool> _onWillPop() async {
//     if (!_hasInput) return true;
//     final confirm = await showConfirmDiscard(
//       title: 'Leave This Page?',
//       content:
//       "You've entered some information. If you go back, it will be lost.",
//     );
//     return confirm ?? false;
//   }
//
//   // ✅ IMAGE PICKER + UPLOAD
//   Future<void> pickAndUploadImage() async {
//     try {
//       final img = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (img == null) return;
//
//       setState(() => isUploading = true);
//
//       // Upload to cloudinary
//       final uploadedUrl = await UtilMethod.uploadImageAndGetUrl(img.path);
//
//       setState(() {
//         imageUrl = uploadedUrl;
//         isUploading = false;
//       });
//
//       Get.snackbar(
//         "Success",
//         "Image uploaded successfully",
//         backgroundColor: Colors.green.withOpacity(0.7),
//         colorText: Colors.white,
//         duration: const Duration(seconds: 2),
//       );
//     } catch (e) {
//       setState(() => isUploading = false);
//       Get.snackbar(
//         "Upload Failed",
//         e.toString(),
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//         duration: const Duration(seconds: 3),
//       );
//     }
//   }
//
//   InputDecoration daanFieldDecoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: const TextStyle(fontSize: 12, color: Colors.black54),
//       filled: true,
//       fillColor: const Color(0xFFF4F4F4),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(4),
//         borderSide: BorderSide.none,
//       ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: AppColors.hinduBase,
//           title: const Text("Add Daan", style: TextStyle(color: Colors.white)),
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(8),
//               bottomRight: Radius.circular(8),
//             ),
//           ),
//         ),
//         bottomNavigationBar: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Divider(height: 0.2),
//             Container(
//               padding: const EdgeInsets.all(16),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.hinduBase,
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                   ),
//                   onPressed: () async {
//                     // ✅ Validation
//                     if (!formKey.currentState!.validate()) return;
//
//                     if (imageUrl == null) {
//                       Get.snackbar(
//                         "Error",
//                         "Please upload an image",
//                         backgroundColor: Colors.red,
//                         colorText: Colors.white,
//                       );
//                       return;
//                     }
//
//                     // ✅ Loading dialog
//                     Get.dialog(
//                       const Center(child: CircularProgressIndicator()),
//                       barrierDismissible: false,
//                     );
//
//                     try {
//                       // ✅ Create donation with already uploaded URL
//                       await controller.addDonation(
//                         title: titleCtrl.text.trim(),
//                         buttonLabel: buttonLabelCtrl.text.trim(),
//                         buttonUrl: buttonUrlCtrl.text.trim(),
//                         imageUrl: imageUrl!, // Already uploaded URL
//                       );
//
//                       Get.back(); // Close loader
//
//                       // ✅ Success dialog
//                       await showSuccessDialog(
//                         title: "Daan Added Successfully",
//                         subtitle: "Your daan entry is ready.",
//                       );
//
//                       Get.back(); // Go back to previous page
//                     } catch (e) {
//                       Get.back(); // Close loader
//                       Get.snackbar(
//                         "Error",
//                         e.toString(),
//                         backgroundColor: Colors.red,
//                         colorText: Colors.white,
//                         duration: const Duration(seconds: 5),
//                       );
//                     }
//                   },
//                   child: const Text(
//                     "Create",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(12),
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16),
//                   color: const Color(0xFFFFF1E9),
//                   child: const Text(
//                     "Mobile Image\nSupported formats: JPG, PNG, GIF · Max size: 2 MB · 1 file only",
//                     style: TextStyle(fontSize: 13, color: Colors.black87),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//
//                 // ✅ Upload box with loading state
//                 GestureDetector(
//                   onTap: isUploading ? null : pickAndUploadImage,
//                   child: _uploadBox(imageUrl: imageUrl, isLoading: isUploading),
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // ---------- TITLE ----------
//                 const Text(
//                   "Daan Title *",
//                   style: TextStyle(fontWeight: FontWeight.w700),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: titleCtrl,
//                   maxLines: 4,
//                   style: const TextStyle(fontSize: 12),
//                   validator: (v) =>
//                   v == null || v.trim().isEmpty ? "Title is required" : null,
//                   decoration: daanFieldDecoration("Write title..."),
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // ---------- BUTTON LABEL ----------
//                 const Text(
//                   "Button Label *",
//                   style: TextStyle(fontWeight: FontWeight.w700),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: buttonLabelCtrl,
//                   style: const TextStyle(fontSize: 12),
//                   validator: (v) => v == null || v.trim().isEmpty
//                       ? "Button label is required"
//                       : null,
//                   decoration: daanFieldDecoration("Donate Now"),
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // ---------- BUTTON URL ----------
//                 const Text(
//                   "Button URL *",
//                   style: TextStyle(fontWeight: FontWeight.w700),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: buttonUrlCtrl,
//                   style: const TextStyle(fontSize: 12),
//                   validator: (v) =>
//                   v == null || v.trim().isEmpty ? "Button URL is required" : null,
//                   decoration: daanFieldDecoration("https://example.com"),
//                 ),
//                 const SizedBox(height: 120),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _uploadBox({String? imageUrl, bool isLoading = false}) {
//     return DottedBorder(
//       color: const Color(0xFFFF7722),
//       strokeWidth: 2,
//       dashPattern: const [6, 4],
//       borderType: BorderType.RRect,
//       radius: const Radius.circular(12),
//       child: Container(
//         width: double.infinity,
//         height: 220,
//         padding: imageUrl == null ? const EdgeInsets.all(24) : EdgeInsets.zero,
//         child: isLoading
//             ? const Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(color: Color(0xFFFF7722)),
//               SizedBox(height: 12),
//               Text(
//                 "Uploading image...",
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//         )
//             : imageUrl == null
//             ? const Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.cloud_upload,
//                 size: 50, color: Color(0xFFFF7722)),
//             SizedBox(height: 12),
//             Text(
//               "Upload Image",
//               style: TextStyle(
//                 color: Color(0xFFFF7722),
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               "Please upload JPG / PNG under 2MB",
//               style: TextStyle(fontSize: 12, color: Colors.grey),
//             ),
//           ],
//         )
//             : ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: Image.network(
//             ImageConverter.optimizeCloudinaryUrl(imageUrl),
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//             loadingBuilder: (context, child, loadingProgress) {
//               if (loadingProgress == null) return child;
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             },
//             errorBuilder: (context, error, stackTrace) {
//               return const Center(
//                 child: Icon(Icons.error, color: Colors.red),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     titleCtrl.dispose();
//     buttonLabelCtrl.dispose();
//     buttonUrlCtrl.dispose();
//     super.dispose();
//   }
// }


import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zamboree_devotion/common/util_method.dart';
import 'package:zamboree_devotion/utils/imageconverter.dart';

import '../../../controllers/donation_controllers.dart';
import '../../../models/donation_model.dart';
import '../../../widgets/app_colors.dart';
import '../../../widgets/confordaan.dart' show showConfirmDiscard;
import '../../../widgets/successdaan.dart';

class AddDaanPage extends StatefulWidget {
  @override
  State<AddDaanPage> createState() => _AddDaanPageState();
}

class _AddDaanPageState extends State<AddDaanPage> {
  final controller = Get.find<DaanController>();
  final formKey = GlobalKey<FormState>();

  final titleCtrl = TextEditingController();
  final buttonLabelCtrl = TextEditingController();
  final buttonUrlCtrl = TextEditingController();

  String? imageUrl; // ✅ Store URL, not path
  bool isUploading = false;

  bool get _hasInput =>
      titleCtrl.text.trim().isNotEmpty ||
          buttonLabelCtrl.text.trim().isNotEmpty ||
          buttonUrlCtrl.text.trim().isNotEmpty ||
          imageUrl != null;

  Future<bool> _onWillPop() async {
    if (!_hasInput) return true;
    final confirm = await showConfirmDiscard(
      title: 'Leave This Page?',
      content:
      "You've entered some information. If you go back, it will be lost.",
    );
    return confirm ?? false;
  }

  // ✅ IMAGE PICKER + UPLOAD
  Future<void> pickAndUploadImage() async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img == null) return;

      setState(() => isUploading = true);

      // Upload to cloudinary
      final uploadedUrl = await UtilMethod.uploadImageAndGetUrl(img.path);

      setState(() {
        imageUrl = uploadedUrl;
        isUploading = false;
      });

      Get.snackbar(
        "Success",
        "Image uploaded successfully",
        backgroundColor: Colors.green.withOpacity(0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      setState(() => isUploading = false);
      Get.snackbar(
        "Upload Failed",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  InputDecoration daanFieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 12, color: Colors.black54),
      filled: true,
      fillColor: const Color(0xFFF4F4F4),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,

        // ---------------- APP BAR ----------------
        appBar: AppBar(
          backgroundColor: AppColors.hinduBase,
          title: const Text("Add Daan", style: TextStyle(color: Colors.white)),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
        ),

        // ---------------- BOTTOM BUTTON ----------------
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(height: 0.2),
            Container(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.hinduBase,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () async {
                    // ✅ Validation
                    if (!formKey.currentState!.validate()) return;

                    if (imageUrl == null) {
                      Get.snackbar(
                        "Error",
                        "Please upload an image",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    // ✅ Loading dialog
                    Get.dialog(
                      const Center(child: CircularProgressIndicator()),
                      barrierDismissible: false,
                    );

                    try {
                      // ✅ Create donation with already uploaded URL
                      await controller.addDonation(
                        title: titleCtrl.text.trim(),
                        buttonLabel: buttonLabelCtrl.text.trim(),
                        buttonUrl: buttonUrlCtrl.text.trim(),
                        imageUrl: imageUrl!, // Already uploaded URL
                      );

                      Get.back(); // Close loader

                      // ✅ Success dialog
                      await showSuccessDialog(
                        title: "Daan Added Successfully",
                        subtitle: "Your daan entry is ready.",
                      );

                      Get.back(); // Go back to previous page
                    } catch (e) {
                      Get.back(); // Close loader
                      Get.snackbar(
                        "Error",
                        e.toString(),
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        duration: const Duration(seconds: 5),
                      );
                    }
                  },
                  child: const Text(
                    "Create",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        // ---------------- BODY ----------------
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: const Color(0xFFFFF1E9),
                  child: const Text(
                    "Mobile Image\nSupported formats: JPG, PNG, GIF · Max size: 2 MB · 1 file only",
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ),
                const SizedBox(height: 12),

                // ✅ Upload box with loading state
                GestureDetector(
                  onTap: isUploading ? null : pickAndUploadImage,
                  child: _uploadBox(imageUrl: imageUrl, isLoading: isUploading),
                ),

                const SizedBox(height: 24),

                // ---------- TITLE ----------
                const Text(
                  "Daan Title *",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: titleCtrl,
                  maxLines: 4,
                  style: const TextStyle(fontSize: 12),
                  validator: (v) =>
                  v == null || v.trim().isEmpty ? "Title is required" : null,
                  decoration: daanFieldDecoration("Write title..."),
                ),

                const SizedBox(height: 24),

                // ---------- BUTTON LABEL ----------
                const Text(
                  "Button Label *",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: buttonLabelCtrl,
                  style: const TextStyle(fontSize: 12),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? "Button label is required"
                      : null,
                  decoration: daanFieldDecoration("Donate Now"),
                ),

                const SizedBox(height: 24),

                // ---------- BUTTON URL ----------
                const Text(
                  "Button URL *",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: buttonUrlCtrl,
                  style: const TextStyle(fontSize: 12),
                  validator: (v) =>
                  v == null || v.trim().isEmpty ? "Button URL is required" : null,
                  decoration: daanFieldDecoration("https://example.com"),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _uploadBox({String? imageUrl, bool isLoading = false}) {
    return DottedBorder(
      color: const Color(0xFFFF7722),
      strokeWidth: 2,
      dashPattern: const [6, 4],
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      child: Container(
        width: double.infinity,
        height: 220,
        padding: imageUrl == null ? const EdgeInsets.all(24) : EdgeInsets.zero,
        child: isLoading
            ? const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Color(0xFFFF7722)),
              SizedBox(height: 12),
              Text(
                "Uploading image...",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        )
            : imageUrl == null
            ? const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload,
                size: 50, color: Color(0xFFFF7722)),
            SizedBox(height: 12),
            Text(
              "Upload Image",
              style: TextStyle(
                color: Color(0xFFFF7722),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Please upload JPG / PNG under 2MB",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            ImageConverter.optimizeCloudinaryUrl(imageUrl),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.error, color: Colors.red),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    buttonLabelCtrl.dispose();
    buttonUrlCtrl.dispose();
    super.dispose();
  }
}