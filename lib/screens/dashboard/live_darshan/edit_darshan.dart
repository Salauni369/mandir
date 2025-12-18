//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../controllers/darshan_controller.dart';
// import '../../../models/live_darshan_model.dart';
// import '../../../utils/imageconverter.dart';
// import '../../../widgets/app_colors.dart';
// import '../../../widgets/imageuploadwidget.dart';
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
//   late TextEditingController templeCtrl;
//   late TextEditingController linkCtrl;
//
//  // final Rxn<String> webImage = Rxn<String>();
//   final Rxn<String> mobile_image = Rxn<String>();
//
//   bool isLive = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     titleCtrl = TextEditingController(text: widget.darshan.title);
//     //templeCtrl = TextEditingController(text: widget.darshan.templeName);
//     linkCtrl = TextEditingController(text: widget.darshan.liveLink);
//
//    // webImage.value = widget.darshan.webImage;
//     mobile_image.value = widget.darshan.mobile_image;
//
//     isLive = widget.darshan.isLive;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//
//       appBar: AppBar(
//         backgroundColor: AppColors.hinduBase,
//         title: const Text("Edit Live Darshan",
//             style: TextStyle(color: Colors.white, fontSize: 20)),
//         iconTheme: const IconThemeData(color: Colors.white),
//         actions: [
//           Switch(
//             value: isLive,
//             onChanged: (v) => setState(() => isLive = v),
//             activeColor: Colors.white,
//           ),
//         ],
//       ),
//
//       // ---------------- FIXED BUTTON (Correct Place) ----------------
//       bottomNavigationBar: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//          // Divider(height: 0.5, color: Colors.grey), // Divider added correctly
//           Container(
//             padding:  EdgeInsets.all(16),
//             color: Colors.white,
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.hinduBase,
//                   padding:  EdgeInsets.all(18),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(40),
//                   ),
//                 ),
//                 // onPressed: () async {
//                 //   if (formKey.currentState!.validate()) {
//                 //     final updated = widget.darshan.copyWith(
//                 //       title: titleCtrl.text.trim(),
//                 //       liveLink: linkCtrl.text.trim(),
//                 //       mobile_image: mobile_image.value,
//                 //       status: isLive ? "ACTIVE" : "INACTIVE",
//                 //     );
//                 //
//                 //
//                 //
//                 //    //  controller.updateDarshan(updated);
//                 //    //  Get.snackbar("Success", "Darshan Updated Successfully");
//                 //      //Get.back();
//                 //   }
//                 //onPressed: () async {
//                 //   if (formKey.currentState!.validate()) {
//                 //     Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
//                 //
//                 //     final updated = widget.darshan.copyWith(
//                 //       title: titleCtrl.text.trim(),
//                 //       liveLink: linkCtrl.text.trim(),
//                 //       mobile_image: mobile_image.value,
//                 //       status: isLive ? "ACTIVE" : "INACTIVE",
//                 //     );
//                 //
//                 //     try {
//                 //       await controller.updateDarshan(updated);
//                 //       Get.back(); // dialog close
//                 //       Get.back(); // page close
//                 //     } catch (e) {
//                 //       Get.back(); // dialog close
//                 //       // error already snackbar se dikha diya gaya updateDarshan mein
//                 //     }
//                 //   }
//                 // },
//                 onPressed: () async {
//                   if (formKey.currentState!.validate()) {
//                     Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
//
//                     final updated = widget.darshan.copyWith(
//                       title: titleCtrl.text.trim(),
//                       liveLink: linkCtrl.text.trim(),
//                       mobile_image: mobile_image.value,
//                       status: isLive ? "ACTIVE" : "INACTIVE",
//                     );
//
//                     try {
//                       await controller.updateDarshan(updated);
//                       Get.back(); // dialog close
//                       Get.back(); // page close
//                     } catch (e) {
//                       Get.back(); // dialog close
//                       // error already snackbar se dikha diya gaya updateDarshan mein
//                     }
//                   }
//                 },
//
//                 child: const Text("Update",
//                     style: TextStyle(color: Colors.white, fontSize: 16)),
//               ),
//             ),
//           ),
//         ],
//       ),
//
//       // ---------------- BODY SCROLL CONTENT ----------------
//       body: SingleChildScrollView(
//         child: Form(
//           key: formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               // ---------------- RICHTEXT BOX ----------------
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(16),
//                 color: const Color(0xFFFFF1E9),
//                 child: RichText(
//                   text: const TextSpan(
//                     children: [
//                       TextSpan(
//                         text: "Mobile Image\n",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.black,
//                         ),
//                       ),
//                       TextSpan(
//                         text:
//                         "Supported formats: JPG, PNG, GIF · Max size: 2 MB · 1 file only",
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Colors.black54,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 10),
//
//               // ---------------- IMAGE UPLOAD SECTION ----------------
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFFFE7D6),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   children: [
//                     // ImageUploadWidget(
//                     //   initialImage: webImage.value,
//                     //   onPicked: (path) => webImage.value = path,
//                     //   showInfo: false,
//                     // ),
//                     const SizedBox(height: 20),
//                     // ImageUploadWidget(
//                     //   initialImageWidget: mobile_image.value != null &&
//                     //       mobile_image.value!.startsWith("http")
//                     //       ? CachedNetworkImage(
//                     //     imageUrl: mobile_image.value!,
//                     //     fit: BoxFit.cover,
//                     //     placeholder: (_, __) =>
//                     //     const Center(child: CircularProgressIndicator()),
//                     //     errorWidget: (_, __, ___) =>
//                     //     const Icon(Icons.broken_image, size: 40),
//                     //   )
//                     //       : null,
//                     //   initialImage: mobile_image.value,
//                     //   onPicked: (path) => mobile_image.value = path,
//                     //   showInfo: false,
//                     // ),
//                     ImageUploadWidget(
//                       initialImage: mobile_image.value == null
//                           ? null
//                           : ImageConverter.optimizeCloudinaryUrl(mobile_image.value!),
//
//                       onPicked: (path) => mobile_image.value = path,
//                       showInfo: false,
//                     ),
//
//
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//
//               // ---------------- FORM FIELDS ----------------
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // _label("Mandir *"),
//                     // _textbox(templeCtrl),
//
//                     const SizedBox(height: 20),
//
//                     _label("Title *"),
//                     _textbox(titleCtrl, maxLines: 2),
//
//                     const SizedBox(height: 20),
//
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
//   Widget _label(String text) => Padding(
//     padding: const EdgeInsets.only(left: 4, bottom: 6),
//     child: Text(
//       text,
//       style: const TextStyle(
//         fontSize: 15,
//         fontWeight: FontWeight.w600,
//       ),
//     ),
//   );
//
//   Widget _textbox(TextEditingController c, {int maxLines = 1}) {
//     return TextFormField(
//       controller: c,
//       maxLines: maxLines,
//       validator: (v) => v!.trim().isEmpty ? "Required" : null,
//       style: const TextStyle(fontSize: 12),
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.grey.shade100,
//         border: OutlineInputBorder(borderRadius: BorderRadius.zero),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.zero,
//           borderSide: BorderSide(color: Colors.grey.shade400),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.zero,
//           borderSide: BorderSide(color: Colors.grey, width: 1),
//         ),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//       ),
//     );
//   }
// }
//
//
//
//
//

// ========================================
// 1. EDIT DARSHAN PAGE - PROFESSIONAL VERSION
// ========================================
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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

  String? mobile_image;
  bool isLive = false;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(text: widget.darshan.title);
    linkCtrl = TextEditingController(text: widget.darshan.liveLink);
    mobile_image = widget.darshan.mobile_image;
    isLive = widget.darshan.isLive;
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    linkCtrl.dispose();
    super.dispose();
  }

  // TOGGLE CHANGE - DIRECT ACTION
  Future<void> _handleToggleChange(bool newValue) async {
    if (isUpdating) return; // Prevent multiple clicks

    setState(() => isUpdating = true);

    // Show loading
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      // Create updated model with new status
      final updated = widget.darshan.copyWith(
        status: newValue ? "ACTIVE" : "INACTIVE",
      );

      await controller.updateDarshan(updated);

      Get.back(); // Close loading dialog

      // Show success dialog
      await _showSuccessDialog(
        title: newValue ? "Moved to Live!" : "Moved to Past!",
        message: newValue
            ? "Darshan is now active and visible in Live section"
            : "Darshan moved to Past section",
      );

      Get.back(); // Close edit page

    } catch (e) {
      Get.back(); // Close loading
      Get.snackbar(
        "Error",
        "Failed to update status",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      setState(() => isLive = !newValue); // Revert toggle
    } finally {
      setState(() => isUpdating = false);
    }
  }

  // UPDATE BUTTON - EDIT FIELDS
  Future<void> _handleUpdate() async {
    if (!formKey.currentState!.validate()) return;
    if (isUpdating) return;

    setState(() => isUpdating = true);

    // Show loading
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final updated = widget.darshan.copyWith(
        title: titleCtrl.text.trim(),
        liveLink: linkCtrl.text.trim(),
        mobile_image: mobile_image,
        status: isLive ? "ACTIVE" : "INACTIVE",
      );

      await controller.updateDarshan(updated);

      Get.back(); // Close loading

      // Show success dialog
      await _showSuccessDialog(
        title: "Updated Successfully!",
        message: "Your darshan details have been updated",
      );

      Get.back(); // Close edit page

    } catch (e) {
      Get.back(); // Close loading
      // Error already shown in controller
    } finally {
      setState(() => isUpdating = false);
    }
  }

  // SUCCESS DIALOG
  Future<void> _showSuccessDialog({
    required String title,
    required String message,
  }) async {
    await Get.dialog(
      Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    await Future.delayed(const Duration(seconds: 2));
    Get.back(); // Close success dialog
  }

  // IMAGE PICKER
  Future<void> _pickImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() => mobile_image = img.path);
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
          // TOGGLE SWITCH
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
                  onChanged: isUpdating ? null : (v) {
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

      // UPDATE BUTTON
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.hinduBase,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              disabledBackgroundColor: Colors.grey.shade300,
            ),
            onPressed: isUpdating ? null : _handleUpdate,
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

      // BODY
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // INFO BOX
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

              // IMAGE UPLOAD
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: _pickImage,
                  child: _buildImageBox(),
                ),
              ),

              const SizedBox(height: 24),

              // FORM FIELDS
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
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: mobile_image == null
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_upload, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 8),
          Text(
            "Tap to upload image",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
        ],
      )
          : ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: mobile_image!.startsWith('http')
            ? Image.network(
          ImageConverter.optimizeCloudinaryUrl(mobile_image!),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        )
            : Image.file(
          File(mobile_image!),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
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
      validator: (v) => v!.trim().isEmpty ? "This field is required" : null,
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
