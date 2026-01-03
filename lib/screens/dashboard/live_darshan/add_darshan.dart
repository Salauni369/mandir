// // import 'dart:io';
// // import 'package:dotted_border/dotted_border.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:image_picker/image_picker.dart';
// //
// // import '../../../controllers/darshan_controller.dart';
// // import '../../../widgets/app_colors.dart';
// //
// // class AddDarshanPage extends StatefulWidget {
// //   const AddDarshanPage({super.key});
// //
// //   @override
// //   State<AddDarshanPage> createState() => _AddDarshanPageState();
// // }
// //
// // class _AddDarshanPageState extends State<AddDarshanPage> {
// //   final controller = Get.find<DarshanController>();
// //   final formKey = GlobalKey<FormState>();
// //
// //   final titleCtrl = TextEditingController();
// //   final linkCtrl = TextEditingController();
// //
// //   String? imagePath;
// //   bool isUploading = false;
// //
// //   @override
// //   void dispose() {
// //     titleCtrl.dispose();
// //     linkCtrl.dispose();
// //     super.dispose();
// //   }
// //
// //   Future<void> _pickImage() async {
// //     try {
// //       final img = await ImagePicker().pickImage(source: ImageSource.gallery);
// //       if (img == null) return;
// //
// //       setState(() {
// //         imagePath = img.path;
// //       });
// //
// //       Get.snackbar(
// //         "Success",
// //         "Image selected successfully",
// //         backgroundColor: Colors.green.withOpacity(0.7),
// //         colorText: Colors.white,
// //         duration: const Duration(seconds: 2),
// //       );
// //     } catch (e) {
// //       Get.snackbar(
// //         "Error",
// //         e.toString(),
// //         backgroundColor: Colors.red,
// //         colorText: Colors.white,
// //       );
// //     }
// //   }
// //
// //   Future<void> _handleCreate() async {
// //     if (!formKey.currentState!.validate()) return;
// //
// //     if (imagePath == null) {
// //       Get.snackbar(
// //         "Error",
// //         "Please select an image",
// //         backgroundColor: Colors.red,
// //         colorText: Colors.white,
// //       );
// //       return;
// //     }
// //
// //     // ✅ Show loading dialog
// //     Get.dialog(
// //       const Center(child: CircularProgressIndicator()),
// //       barrierDismissible: false,
// //     );
// //
// //     try {
// //       await controller.addDarshan(
// //         title: titleCtrl.text.trim(),
// //         embeddedLink: linkCtrl.text.trim(),
// //         imagePath: imagePath!,
// //       );
// //
// //       // ✅ Controller will handle success dialog and navigation
// //
// //     } catch (e) {
// //       Get.back(); // Close loading
// //       Get.snackbar(
// //         "Error",
// //         e.toString(),
// //         backgroundColor: Colors.red,
// //         colorText: Colors.white,
// //       );
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //
// //       // ---------------- APP BAR ----------------
// //       appBar: AppBar(
// //         backgroundColor: AppColors.hinduBase,
// //         title: const Text(
// //           "Add Live Darshan",
// //           style: TextStyle(color: Colors.white, fontSize: 20),
// //         ),
// //         iconTheme: const IconThemeData(color: Colors.white),
// //         shape: const RoundedRectangleBorder(
// //           borderRadius: BorderRadius.only(
// //             bottomLeft: Radius.circular(8),
// //             bottomRight: Radius.circular(8),
// //           ),
// //         ),
// //       ),
// //
// //       // ---------------- CREATE BUTTON ----------------
// //       bottomNavigationBar: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           //const Divider(height: 0.2),
// //           Container(
// //             padding: const EdgeInsets.all(16),
// //             child: SizedBox(
// //               width: double.infinity,
// //               child: ElevatedButton(
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: AppColors.hinduBase,
// //                   padding: const EdgeInsets.symmetric(vertical: 10),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(50),
// //                   ),
// //                 ),
// //                 onPressed: _handleCreate,
// //                 child: const Text(
// //                   "Create",
// //                   style: TextStyle(
// //                     color: Colors.white,
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.w600,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //
// //       // ---------------- BODY ----------------
// //       body: SingleChildScrollView(
// //         child: Form(
// //           key: formKey,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               // INFO BOX
// //               Container(
// //                 width: double.infinity,
// //                 padding: const EdgeInsets.all(16),
// //                 color: const Color(0xFFFFF1E9),
// //                 child: const Text(
// //                   "Mobile Image\nSupported formats: JPG, PNG, GIF · Max size: 2 MB · 1 file only",
// //                   style: TextStyle(fontSize: 13, color: Colors.black87),
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 16),
// //
// //               // IMAGE UPLOAD
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// //                 child: GestureDetector(
// //                   onTap: _pickImage,
// //                   child: _buildImageBox(),
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 24),
// //
// //               // FORM FIELDS
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     _label("Title *"),
// //                     _textbox(titleCtrl, maxLines: 2),
// //
// //                     const SizedBox(height: 20),
// //
// //                     _label("Live Darshan Link *"),
// //                     _textbox(linkCtrl),
// //                   ],
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 100),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildImageBox() {
// //     return DottedBorder(
// //       color: const Color(0xFFFF7722),
// //       strokeWidth: 2,
// //       dashPattern: const [6, 4],
// //       borderType: BorderType.RRect,
// //       radius: const Radius.circular(12),
// //       child: Container(
// //         height: 220,
// //         width: double.infinity,
// //         child: imagePath == null
// //             ? const Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(
// //               Icons.cloud_upload,
// //               size: 50,
// //               color: Color(0xFFFF7722),
// //             ),
// //             SizedBox(height: 12),
// //             Text(
// //               "Upload Image",
// //               style: TextStyle(
// //                 color: Color(0xFFFF7722),
// //                 fontWeight: FontWeight.w500,
// //               ),
// //             ),
// //             SizedBox(height: 8),
// //             Text(
// //               "Please upload JPG / PNG under 2MB",
// //               style: TextStyle(fontSize: 12, color: Colors.grey),
// //             ),
// //           ],
// //         )
// //             : ClipRRect(
// //           borderRadius: BorderRadius.circular(10),
// //           child: Image.file(
// //             File(imagePath!),
// //             fit: BoxFit.cover,
// //             width: double.infinity,
// //             height: double.infinity,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _label(String text) => Padding(
// //     padding: const EdgeInsets.only(bottom: 8),
// //     child: Text(
// //       text,
// //       style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
// //     ),
// //   );
// //
// //   Widget _textbox(TextEditingController c, {int maxLines = 1}) {
// //     return TextFormField(
// //       controller: c,
// //       maxLines: maxLines,
// //       validator: (v) =>
// //       v == null || v.trim().isEmpty ? "This field is required" : null,
// //       style: const TextStyle(fontSize: 14),
// //       decoration: InputDecoration(
// //         filled: true,
// //         fillColor: Colors.grey.shade50,
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(8),
// //           borderSide: BorderSide(color: Colors.grey.shade300),
// //         ),
// //         enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(8),
// //           borderSide: BorderSide(color: Colors.grey.shade300),
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(8),
// //           borderSide: BorderSide(color: AppColors.hinduBase, width: 2),
// //         ),
// //         contentPadding: const EdgeInsets.all(16),
// //       ),
// //     );
// //   }
// // }
//
// import 'dart:io';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../../common/util_method.dart';
// import '../../../controllers/darshan_controller.dart';
// import '../../../services/livedarshan.dart';
// import '../../../widgets/app_colors.dart';
// import '../../../utils/imageconverter.dart';
//
// class AddDarshanPage extends StatefulWidget {
//   const AddDarshanPage({super.key});
//
//   @override
//   State<AddDarshanPage> createState() => _AddDarshanPageState();
// }
//
// class _AddDarshanPageState extends State<AddDarshanPage> {
//   final controller = Get.find<DarshanController>();
//   final formKey = GlobalKey<FormState>();
//
//   final titleCtrl = TextEditingController();
//   final linkCtrl = TextEditingController();
//
//   String? imageUrl; // ✅ ONLY URL (NO FILE PATH)
//   bool isUploading = false;
//
//   @override
//   void dispose() {
//     titleCtrl.dispose();
//     linkCtrl.dispose();
//     super.dispose();
//   }
//
//   Future<void> _pickImage() async {
//     try {
//       final img = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (img == null) return;
//
//       setState(() => isUploading = true);
//
//       // ✅ Convert → Upload → URL only
//       final safePath = await forceConvertToJpg(img.path);
//       final uploadedUrl = await UtilMethod.uploadImageAndGetUrl(img.path);
//       imageUrl = uploadedUrl;
//
//
//       setState(() {
//         imageUrl = url;
//         isUploading = false;
//       });
//
//       Get.snackbar(
//         "Success",
//         "Image uploaded successfully",
//         backgroundColor: Colors.green.withOpacity(0.7),
//         colorText: Colors.white,
//       );
//     } catch (e) {
//       setState(() => isUploading = false);
//       Get.snackbar(
//         "Error",
//         "Image upload failed",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   Future<void> _handleCreate() async {
//     if (!formKey.currentState!.validate()) return;
//
//     if (imageUrl == null) {
//       Get.snackbar(
//         "Error",
//         "Please upload an image",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }
//
//     Get.dialog(
//       const Center(child: CircularProgressIndicator()),
//       barrierDismissible: false,
//     );
//
//     try {
//       await controller.addDarshan(
//         title: titleCtrl.text.trim(),
//         embeddedLink: linkCtrl.text.trim(),
//         imagePath: imageUrl!, imageUrl: '', // ✅ URL only
//       );
//     } catch (e) {
//       if (Get.isDialogOpen ?? false) Get.back();
//       Get.snackbar(
//         "Error",
//         e.toString(),
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//
//       appBar: AppBar(
//         backgroundColor: AppColors.hinduBase,
//         title: const Text(
//           "Add Live Darshan",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(8),
//             bottomRight: Radius.circular(8),
//           ),
//         ),
//       ),
//
//       bottomNavigationBar: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.hinduBase,
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                 ),
//                 onPressed: _handleCreate,
//                 child: const Text(
//                   "Create",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//
//       body: SingleChildScrollView(
//         child: Form(
//           key: formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(16),
//                 color: const Color(0xFFFFF1E9),
//                 child: const Text(
//                   "Mobile Image\nSupported formats: JPG, PNG, GIF · Max size: 2 MB · 1 file only",
//                   style: TextStyle(fontSize: 13, color: Colors.black87),
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: GestureDetector(
//                   onTap: _pickImage,
//                   child: _buildImageBox(),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _label("Title *"),
//                     _textbox(titleCtrl, maxLines: 2),
//                     const SizedBox(height: 20),
//                     _label("Live Darshan Link *"),
//                     _textbox(linkCtrl),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 100),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildImageBox() {
//     return DottedBorder(
//       color: const Color(0xFFFF7722),
//       strokeWidth: 2,
//       dashPattern: const [6, 4],
//       borderType: BorderType.RRect,
//       radius: const Radius.circular(12),
//       child: Container(
//         height: 220,
//         width: double.infinity,
//         child: imageUrl == null
//             ? const Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.cloud_upload, size: 50, color: Color(0xFFFF7722)),
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
//             imageUrl!,
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//             errorBuilder: (_, __, ___) =>
//             const Icon(Icons.broken_image),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _label(String text) => Padding(
//     padding: const EdgeInsets.only(bottom: 8),
//     child: Text(
//       text,
//       style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//     ),
//   );
//
//   Widget _textbox(TextEditingController c, {int maxLines = 1}) {
//     return TextFormField(
//       controller: c,
//       maxLines: maxLines,
//       validator: (v) =>
//       v == null || v.trim().isEmpty ? "This field is required" : null,
//       style: const TextStyle(fontSize: 14),
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.grey.shade50,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: AppColors.hinduBase, width: 2),
//         ),
//         contentPadding: const EdgeInsets.all(16),
//       ),
//     );
//   }
// }


import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../address/repository/temple_service.dart';
import '../../../common/util_method.dart';
import '../../../controllers/darshan_controller.dart';
import '../../../widgets/app_colors.dart';

class AddDarshanPage extends StatefulWidget {
  const AddDarshanPage({super.key});

  @override
  State<AddDarshanPage> createState() => _AddDarshanPageState();
}

class _AddDarshanPageState extends State<AddDarshanPage> {
  final controller = Get.find<DarshanController>();
  final formKey = GlobalKey<FormState>();

  final titleCtrl = TextEditingController();
  final linkCtrl = TextEditingController();

  String? imageUrl; // ✅ URL ONLY
  bool isUploading = false;

  @override
  void dispose() {
    titleCtrl.dispose();
    linkCtrl.dispose();
    super.dispose();
  }

  // =========================
  // PICK + UPLOAD IMAGE (DAAN FLOW)
  // =========================
  Future<void> _pickImage() async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img == null) return;

      setState(() => isUploading = true);

      // ✅ ONLY THIS (same as DAAN)
      final uploadedUrl =
      await UtilMethod.uploadImageAndGetUrl(img.path);

      setState(() {
        imageUrl = uploadedUrl;
        isUploading = false;
      });

      Get.snackbar(
        "Success",
        "Image uploaded successfully",
        backgroundColor: Colors.green.withOpacity(0.7),
        colorText: Colors.white,
      );
    } catch (e) {
      setState(() => isUploading = false);
      Get.snackbar(
        "Error",
        "Image upload failed",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // =========================
  // CREATE DARSHAN
  // =========================
  Future<void> _handleCreate() async {
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

    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      await controller.addDarshan(
        title: titleCtrl.text.trim(),
        embeddedLink: linkCtrl.text.trim(),
        imageUrl: imageUrl!, // ✅ URL ONLY
      );
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: AppColors.hinduBase,
        title: const Text(
          "Add Live Darshan",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),

      bottomNavigationBar: Container(
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
            onPressed: isUploading ? null : _handleCreate,
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

      body: SingleChildScrollView(
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

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: isUploading ? null : _pickImage,
                  child: _buildImageBox(),
                ),
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label("Title *"),
                    _textbox(titleCtrl, maxLines: 2),
                    const SizedBox(height: 20),
                    _label("Live Darshan Link *"),
                    _textbox(linkCtrl),
                  ],
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // IMAGE BOX (UI SAME)
  // =========================
  Widget _buildImageBox() {
    return DottedBorder(
      color: const Color(0xFFFF7722),
      strokeWidth: 2,
      dashPattern: const [6, 4],
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      child: Container(
        height: 220,
        width: double.infinity,
        child: imageUrl == null
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
            ImageConverter.optimizeCloudinaryUrl(imageUrl!),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (_, __, ___) =>
            const Icon(Icons.broken_image),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  );

  Widget _textbox(TextEditingController c, {int maxLines = 1}) {
    return TextFormField(
      controller: c,
      maxLines: maxLines,
      validator: (v) =>
      v == null || v.trim().isEmpty ? "This field is required" : null,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.hinduBase, width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}

