// import 'dart:io';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:zamboree_devotion/common/util_method.dart';
//
// import '../../../controllers/darshan_controller.dart';
// import '../../../models/live_darshan_model.dart';
// import '../../../utils/imageconverter.dart';
// import '../../../widgets/app_colors.dart';
//
// class EditDarshanPage extends StatefulWidget {
//   final DarshanModel darshan;
//
//   const EditDarshanPage({super.key, required this.darshan});
//
//   @override
//   State<EditDarshanPage> createState() => _EditDarshanPageState();
// }
//
// class _EditDarshanPageState extends State<EditDarshanPage> {
//   final controller = Get.find<DarshanController>();
//   final formKey = GlobalKey<FormState>();
//
//   late TextEditingController titleCtrl;
//   late TextEditingController linkCtrl;
//
//   String? mobile_image;
//   bool isLive = false;
//   bool isUpdating = false;
//   bool isUploadingImage = false;
//
//   @override
//   void initState() {
//     super.initState();
//     titleCtrl = TextEditingController(text: widget.darshan.title);
//     linkCtrl = TextEditingController(text: widget.darshan.embeddedLink);
//     mobile_image = widget.darshan.mobileImage;
//     isLive = widget.darshan.isLive;
//
//     print("🔵 EDIT PAGE INITIALIZED");
//     print("➡️ Title: ${widget.darshan.title}");
//     print("➡️ Link: ${widget.darshan.embeddedLink}");
//     print("➡️ Image: ${widget.darshan.mobileImage}");
//     print("➡️ Status: ${widget.darshan.status}");
//   }
//
//   @override
//   void dispose() {
//     titleCtrl.dispose();
//     linkCtrl.dispose();
//     super.dispose();
//   }
//
//   // =========================
//   // TOGGLE LIVE/PAST STATUS
//   // =========================
//   Future<void> _handleToggleChange(bool newValue) async {
//     if (isUpdating) return;
//
//     setState(() => isUpdating = true);
//
//     Get.dialog(
//       const Center(child: CircularProgressIndicator()),
//       barrierDismissible: false,
//     );
//
//     try {
//       print("🔄 TOGGLE STATUS CHANGE");
//       print("➡️ New Status: ${newValue ? 'ACTIVE' : 'INACTIVE'}");
//
//       final updated = widget.darshan.copyWith(
//         status: newValue ? "ACTIVE" : "INACTIVE",
//       );
//
//       await controller.updateDarshan(updated);
//
//     } catch (e) {
//       Get.back(); // Close loading
//       Get.snackbar(
//         "Error",
//         "Failed to update status",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       setState(() => isLive = !newValue);
//     } finally {
//       setState(() => isUpdating = false);
//     }
//   }
//
//   // =========================
//   // IMAGE PICKER + UPLOAD
//   // =========================
//   Future<void> _pickAndUploadImage() async {
//     try {
//       final img = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (img == null) return;
//
//       setState(() => isUploadingImage = true);
//
//       print("📤 UPLOADING NEW IMAGE...");
//
//       setState(() {
//         mobile_image = img.path; // Store local path
//         isUploadingImage = false;
//       });
//
//       print("✅ IMAGE SELECTED: ${img.path}");
//
//       Get.snackbar(
//         "Success",
//         "Image selected successfully",
//         backgroundColor: Colors.green.withOpacity(0.7),
//         colorText: Colors.white,
//         duration: const Duration(seconds: 2),
//       );
//
//     } catch (e) {
//       setState(() => isUploadingImage = false);
//       print("❌ IMAGE SELECTION ERROR: $e");
//       Get.snackbar(
//         "Selection Failed",
//         e.toString(),
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//         duration: const Duration(seconds: 3),
//       );
//     }
//   }
//
//   // =========================
//   // UPDATE BUTTON - SAVE ALL CHANGES
//   // =========================
//   Future<void> _handleUpdate() async {
//     if (!formKey.currentState!.validate()) return;
//     if (isUpdating || isUploadingImage) return;
//
//     print("🔄 UPDATE BUTTON CLICKED");
//     print("➡️ Title: ${titleCtrl.text.trim()}");
//     print("➡️ Link: ${linkCtrl.text.trim()}");
//     print("➡️ Image: $mobile_image");
//     print("➡️ Status: ${isLive ? 'ACTIVE' : 'INACTIVE'}");
//
//     setState(() => isUpdating = true);
//
//     // 🔥 Show loading dialog
//     Get.dialog(
//       const Center(child: CircularProgressIndicator()),
//       barrierDismissible: false,
//     );
//
//     try {
//       final updated = widget.darshan.copyWith(
//         title: titleCtrl.text.trim(),
//         embeddedLink: linkCtrl.text.trim(),
//         mobileImage: mobile_image,
//         status: isLive ? "ACTIVE" : "INACTIVE",
//       );
//
//       print("📤 SENDING UPDATE REQUEST");
//       await controller.updateDarshan(updated);
//
//       // 🔥 Controller will handle everything
//
//     } catch (e) {
//       // 🔥 Close dialog on error
//       if (Get.isDialogOpen ?? false) Get.back();
//       print("❌ UPDATE ERROR: $e");
//     } finally {
//       setState(() => isUpdating = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//
//       // -------------------- APP BAR --------------------
//       appBar: AppBar(
//         backgroundColor: AppColors.hinduBase,
//         title: const Text(
//           "Edit Live Darshan",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//         actions: [
//           // TOGGLE SWITCH
//           Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: Row(
//               children: [
//                 Text(
//                   isLive ? "Live" : "Past",
//                   style: const TextStyle(color: Colors.white, fontSize: 14),
//                 ),
//                 Switch(
//                   value: isLive,
//                   onChanged: isUpdating
//                       ? null
//                       : (v) {
//                     setState(() => isLive = v);
//                     _handleToggleChange(v);
//                   },
//                   activeColor: Colors.white,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//
//       // -------------------- UPDATE BUTTON --------------------
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.hinduBase,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               disabledBackgroundColor: Colors.grey.shade300,
//             ),
//             onPressed: (isUpdating || isUploadingImage) ? null : _handleUpdate,
//             child: isUpdating
//                 ? const SizedBox(
//               height: 20,
//               width: 20,
//               child: CircularProgressIndicator(
//                 color: Colors.white,
//                 strokeWidth: 2,
//               ),
//             )
//                 : const Text(
//               "Update",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ),
//
//       // -------------------- BODY --------------------
//       body: SingleChildScrollView(
//         child: Form(
//           key: formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // INFO BOX
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
//               // IMAGE UPLOAD
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: GestureDetector(
//                   onTap: isUploadingImage ? null : _pickAndUploadImage,
//                   child: _buildImageBox(),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               // FORM FIELDS
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _label("Title *"),
//                     _textbox(titleCtrl, maxLines: 2),
//
//                     const SizedBox(height: 20),
//
//                     _label("Live Darshan Link *"),
//                     _textbox(linkCtrl),
//
//                     // ❌ REMOVED "Current Link" TEXT
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
//   // -------------------- IMAGE UPLOAD BOX --------------------
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
//         child: isUploadingImage
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
//             : mobile_image == null
//             ? const Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.cloud_upload,
//               size: 50,
//               color: Color(0xFFFF7722),
//             ),
//             SizedBox(height: 12),
//             Text(
//               "Tap to upload image",
//               style: TextStyle(
//                 color: Color(0xFFFF7722),
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         )
//             : ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: mobile_image!.startsWith('http')
//               ? Image.network(
//             ImageConverter.optimizeCloudinaryUrl(mobile_image!),
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           )
//               : Image.file(
//             File(mobile_image!),
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//         ),
//       ),
//     );
//   }
//
//   // -------------------- HELPER WIDGETS --------------------
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
//       validator: (v) => v == null || v.trim().isEmpty
//           ? "This field is required"
//           : null,
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
import 'package:zamboree_devotion/common/util_method.dart';

import '../../../controllers/darshan_controller.dart';
import '../../../models/live_darshan_model.dart';
import '../../../utils/imageconverter.dart';
import '../../../widgets/app_colors.dart';

class EditDarshanPage extends StatefulWidget {
  final DarshanModel darshan;

  const EditDarshanPage({super.key, required this.darshan});

  @override
  State<EditDarshanPage> createState() => _EditDarshanPageState();
}

class _EditDarshanPageState extends State<EditDarshanPage> {
  final controller = Get.find<DarshanController>();
  final formKey = GlobalKey<FormState>();

  late TextEditingController titleCtrl;
  late TextEditingController linkCtrl;

  String? mobile_image; // ✅ URL ONLY
  bool isLive = false;
  bool isUpdating = false;
  bool isUploadingImage = false;

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(text: widget.darshan.title);
    linkCtrl = TextEditingController(text: widget.darshan.embeddedLink);
    mobile_image = widget.darshan.mobileImage; // ✅ URL
    isLive = widget.darshan.isLive;
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    linkCtrl.dispose();
    super.dispose();
  }

  // =========================
  // TOGGLE LIVE/PAST STATUS
  // =========================
  Future<void> _handleToggleChange(bool newValue) async {
    if (isUpdating) return;

    setState(() => isUpdating = true);

    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final updated = widget.darshan.copyWith(
        status: newValue ? "ACTIVE" : "INACTIVE",
      );

      await controller.updateDarshan(updated);
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      setState(() => isLive = !newValue);

      Get.snackbar(
        "Error",
        "Failed to update status",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() => isUpdating = false);
    }
  }

  // =========================
  // IMAGE PICK + UPLOAD (URL ONLY)
  // =========================
  Future<void> _pickAndUploadImage() async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img == null) return;

      setState(() => isUploadingImage = true);

      // ✅ Upload and get URL
      final uploadedUrl =
      await UtilMethod.uploadImageAndGetUrl(img.path);

      setState(() {
        mobile_image = uploadedUrl; // ✅ URL ONLY
        isUploadingImage = false;
      });

      Get.snackbar(
        "Success",
        "Image uploaded successfully",
        backgroundColor: Colors.green.withOpacity(0.7),
        colorText: Colors.white,
      );
    } catch (e) {
      setState(() => isUploadingImage = false);

      Get.snackbar(
        "Error",
        "Image upload failed",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // =========================
  // UPDATE DARSHAN
  // =========================
  Future<void> _handleUpdate() async {
    if (!formKey.currentState!.validate()) return;
    if (isUpdating || isUploadingImage) return;

    if (mobile_image == null || !mobile_image!.startsWith('http')) {
      Get.snackbar(
        "Error",
        "Please upload an image",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    setState(() => isUpdating = true);

    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final updated = widget.darshan.copyWith(
        title: titleCtrl.text.trim(),
        embeddedLink: linkCtrl.text.trim(),
        mobileImage: mobile_image, // ✅ URL
        status: isLive ? "ACTIVE" : "INACTIVE",
      );

      await controller.updateDarshan(updated);
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();

      Get.snackbar(
        "Error",
        "Update failed",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() => isUpdating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: AppColors.hinduBase,
        title: const Text(
          "Edit Live Darshan",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                Text(
                  isLive ? "Live" : "Past",
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Switch(
                  value: isLive,
                  onChanged: isUpdating
                      ? null
                      : (v) {
                    setState(() => isLive = v);
                    _handleToggleChange(v);
                  },
                  activeColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
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
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: (isUpdating || isUploadingImage)
                ? null
                : _handleUpdate,
            child: isUpdating
                ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
                : const Text(
              "Update",
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
                  style: TextStyle(fontSize: 13),
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: isUploadingImage ? null : _pickAndUploadImage,
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
        child: isUploadingImage
            ? const Center(child: CircularProgressIndicator())
            : mobile_image == null
            ? const Center(
          child: Icon(Icons.cloud_upload,
              size: 50, color: Color(0xFFFF7722)),
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            ImageConverter.optimizeCloudinaryUrl(mobile_image!),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.w600),
    ),
  );

  Widget _textbox(TextEditingController c, {int maxLines = 1}) {
    return TextFormField(
      controller: c,
      maxLines: maxLines,
      validator: (v) =>
      v == null || v.trim().isEmpty ? "This field is required" : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}
