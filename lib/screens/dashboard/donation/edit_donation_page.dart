// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../controllers/donation_controllers.dart';
// import '../../../models/donation_model.dart';
// import '../../../utils/imageconverter.dart';
// import '../../../widgets/app_colors.dart';
// import '../../../widgets/imgupfordaan.dart';
// import '../../../widgets/successdaan.dart';
// import '../../../widgets/confordaan.dart';
//
// class EditDaanPage extends StatefulWidget {
//   final DaanModel daan;
//   const EditDaanPage({Key? key, required this.daan}) : super(key: key);
//
//   @override
//   State<EditDaanPage> createState() => _EditDaanPageState();
// }
//
// class _EditDaanPageState extends State<EditDaanPage> {
//   final controller = Get.find<DaanController>();
//   final formKey = GlobalKey<FormState>();
//
//   late TextEditingController titleCtrl;
//   late TextEditingController buttonLabelCtrl;
//   late TextEditingController buttonUrlCtrl;
//
//   String? imagePath;
//
//   @override
//   void initState() {
//     super.initState();
//     titleCtrl = TextEditingController(text: widget.daan.donation_title);
//     buttonLabelCtrl = TextEditingController(text: widget.daan.buttonText);
//     buttonUrlCtrl = TextEditingController(text: widget.daan.buttonLink);
//     imagePath = ImageConverter.optimizeCloudinaryUrl(widget.daan.image);
//
//   }
//
//   Future<void> _updateDaan() async {
//     if (!formKey.currentState!.validate()) return;
//
//     final updated = widget.daan.copyWith(
//       donation_title: titleCtrl.text.trim(),
//       buttonText: buttonLabelCtrl.text.trim(),
//       buttonLink: buttonUrlCtrl.text.trim(),
//       image: imagePath,
//     );
//
//     await controller.updateDonation(updated);
//
//     await showSuccessDialog(
//       title: "Daan Updated Successfully",
//       subtitle: "Your daan entry has been updated.",
//     );
//
//     Get.back();
//   }
//   //
//   // InputDecoration daanFieldDecoration(String hint) {
//   //   return InputDecoration(
//   //     hintText: hint,
//   //     hintStyle: const TextStyle(fontSize: 12, color: Colors.black54),
//   //     filled: true,
//   //     fillColor: const Color(0xFFF4F4F4),
//   //     border: OutlineInputBorder(
//   //       borderRadius: BorderRadius.circular(4),
//   //       borderSide: BorderSide.none,
//   //     ),
//   //     contentPadding:
//   //     const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//   //   );
//   // }
//   InputDecoration daanFieldDecoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: const TextStyle(fontSize: 12, color: Colors.black54),
//       filled: true,
//       fillColor: const Color(0xFFF4F4F4),
//
//       // 🔽 NORMAL BORDER
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(4),
//         borderSide: const BorderSide(
//           color: Colors.grey, // GREY BORDER
//           width: 1,
//         ),
//       ),
//
//       // 🔽 FOCUSED BORDER (jab type kare)
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(4),
//         borderSide: BorderSide(
//           color: AppColors.greyL6, // active color
//           width: 1.2,
//         ),
//       ),
//
//       // 🔽 ERROR BORDER
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(4),
//         borderSide: const BorderSide(
//           color: Colors.red,
//           width: 1,
//         ),
//       ),
//
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(4),
//         borderSide: const BorderSide(
//           color: Colors.grey,
//           width: 1.2,
//         ),
//       ),
//
//       contentPadding:
//       const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//
//       appBar: AppBar(
//         backgroundColor: AppColors.hinduBase,
//         title: const Text("Edit Daan", style: TextStyle(color: Colors.white)
//
//         ),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(8),
//             bottomRight: Radius.circular(8),
//           ),
//         ),
//       ),
//
//       // ---------------- UPDATE BUTTON + DIVIDER FIXED ----------------
//       bottomNavigationBar: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Divider(height: 0.1, color: Colors.grey), // thinner divider
//           Container(
//             padding: const EdgeInsets.all(16),
//             color: Colors.white,
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.hinduBase,
//                   padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8), // thinner button
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                 ),
//                 onPressed: _updateDaan,
//                 child: const Text(
//                   "Update",
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//         child: Form(
//           key: formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // ------------------ UPLOAD IMAGE ------------------
//               // Container(
//               //   width: double.infinity, // full width
//               //   padding: const EdgeInsets.all(12),
//               //   decoration: BoxDecoration(
//               //     color: const Color(0xFFFFF1E9), // light background
//               //     borderRadius: BorderRadius.circular(6),
//               //   ),
//               //   child: Column(
//               //     crossAxisAlignment: CrossAxisAlignment.start,
//               //     children: const [
//               //       // Text(
//               //       //   "Upload Image",
//               //       //   style: TextStyle(fontWeight: FontWeight.w700),
//               //       // ),
//               //       // SizedBox(height: 4),
//               //       // Text(
//               //       //   "Supported formats: JPG, PNG, GIF · Max size: 2 MB · 1 file only",
//               //       //   style: TextStyle(fontSize: 12, color: Colors.grey),
//               //       // ),
//               //
//               //     ],
//               //   ),
//               // ),
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
//               const SizedBox(height: 12),
//
//               ImageUploadWidget(
//                 imagePath: imagePath,
//                 placeholderText: "uploaded_image_compressed.jpg",
//                 onPicked: (p) => setState(() => imagePath = p),
//               ),
//
//               const SizedBox(height: 24),
//
//               // ------------------ DAAN TITLE ------------------
//               const Text("Daan Title *",
//                   style: TextStyle(fontWeight: FontWeight.w700)),
//               const SizedBox(height: 8),
//
//               TextFormField(
//                 controller: titleCtrl,
//                 maxLines: 4,
//                 style: const TextStyle(fontSize: 12),
//                 validator: (v) => v!.trim().isEmpty ? "Required" : null,
//                 decoration: daanFieldDecoration("Write title..."),
//               ),
//
//               const SizedBox(height: 24),
//
//               // ------------------ BUTTON LABEL ------------------
//               const Text("Button Label *",
//                   style: TextStyle(fontWeight: FontWeight.w700)),
//               const SizedBox(height: 8),
//
//               TextFormField(
//                 controller: buttonLabelCtrl,
//                 style: const TextStyle(fontSize: 12),
//                 validator: (v) => v!.trim().isEmpty ? "Required" : null,
//                 decoration: daanFieldDecoration("Donate Now"),
//               ),
//
//               const SizedBox(height: 24),
//
//               // ------------------ BUTTON URL ------------------
//               const Text("Button URL *",
//                   style: TextStyle(fontWeight: FontWeight.w700)),
//               const SizedBox(height: 8),
//
//               TextFormField(
//                 controller: buttonUrlCtrl,
//                 style: const TextStyle(fontSize: 12),
//                 validator: (v) => v!.trim().isEmpty ? "Required" : null,
//                 decoration: daanFieldDecoration("Where button redirects..."),
//               ),
//
//               const SizedBox(height: 120),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zamboree_devotion/common/util_method.dart';

import '../../../controllers/donation_controllers.dart';
import '../../../models/donation_model.dart';
import '../../../utils/imageconverter.dart';
import '../../../widgets/app_colors.dart';
import '../../../widgets/imgupfordaan.dart';
import '../../../widgets/successdaan.dart';
import '../../../widgets/confordaan.dart';

class EditDaanPage extends StatefulWidget {
  final DaanModel daan;
  const EditDaanPage({Key? key, required this.daan}) : super(key: key);

  @override
  State<EditDaanPage> createState() => _EditDaanPageState();
}

class _EditDaanPageState extends State<EditDaanPage> {
  final controller = Get.find<DaanController>();
  final formKey = GlobalKey<FormState>();

  late TextEditingController titleCtrl;
  late TextEditingController buttonLabelCtrl;
  late TextEditingController buttonUrlCtrl;

  String? imageUrl; // ✅ Current image URL
  bool isUploading = false;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(text: widget.daan.donation_title);
    buttonLabelCtrl = TextEditingController(text: widget.daan.buttonText);
    buttonUrlCtrl = TextEditingController(text: widget.daan.buttonLink);

    // ✅ Store existing image URL
    imageUrl = widget.daan.image;
  }

  // ✅ HANDLE IMAGE UPLOAD
  Future<void> _handleImageUpload(String? localPath) async {
    if (localPath == null) return;

    try {
      setState(() => isUploading = true);

      // ✅ Upload new image and get URL
      final uploadedUrl = await UtilMethod.uploadImageAndGetUrl(localPath);

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

      print("✅ New image uploaded: $uploadedUrl");
    } catch (e) {
      setState(() => isUploading = false);

      Get.snackbar(
        "Upload Failed",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

      print("❌ Image upload error: $e");
    }
  }

  // ✅ UPDATE DAAN
  Future<void> _updateDaan() async {
    if (!formKey.currentState!.validate()) return;

    if (imageUrl == null || imageUrl!.isEmpty) {
      Get.snackbar(
        "Error",
        "Image is required",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (isUploading) {
      Get.snackbar(
        "Please Wait",
        "Image is still uploading...",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    try {
      setState(() => isUpdating = true);

      // Show loading dialog
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // ✅ Create updated model with new data
      final updated = widget.daan.copyWith(
        donation_title: titleCtrl.text.trim(),
        buttonText: buttonLabelCtrl.text.trim(),
        buttonLink: buttonUrlCtrl.text.trim(),
        image: imageUrl, // ✅ Use uploaded URL
      );

      print("🔄 Updating donation with ID: ${updated.id}");
      print("📝 New data: ${updated.toString()}");

      await controller.updateDonation(updated);

      Get.back(); // Close loading dialog

      await showSuccessDialog(
        title: "Daan Updated Successfully",
        subtitle: "Your daan entry has been updated.",
      );

      Get.back(); // Go back to previous page
    } catch (e) {
      Get.back(); // Close loading dialog if open

      Get.snackbar(
        "Update Failed",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );

      print("❌ Update error: $e");
    } finally {
      setState(() => isUpdating = false);
    }
  }

  InputDecoration daanFieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 12, color: Colors.black54),
      filled: true,
      fillColor: const Color(0xFFF4F4F4),

      // 🔽 NORMAL BORDER
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),

      // 🔽 FOCUSED BORDER
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: AppColors.greyL6,
          width: 1.2,
        ),
      ),

      // 🔽 ERROR BORDER
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1.2,
        ),
      ),

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: AppColors.hinduBase,
        title: const Text(
          "Edit Daan",
          style: TextStyle(color: Colors.white),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),

      // ---------------- UPDATE BUTTON ----------------
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 0.1, color: Colors.grey),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.hinduBase,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: isUpdating || isUploading ? null : _updateDaan,
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
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------------ IMAGE UPLOAD INFO ------------------
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

              // ------------------ IMAGE UPLOAD WIDGET ------------------
              Stack(
                children: [
                  ImageUploadWidget(
                    imagePath: imageUrl != null
                        ? ImageConverter.optimizeCloudinaryUrl(imageUrl!)
                        : null,
                    placeholderText: "uploaded_image_compressed.jpg",
                    onPicked: _handleImageUpload, // ✅ Handle upload
                  ),

                  // ✅ Show uploading overlay
                  if (isUploading)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: Colors.white),
                              SizedBox(height: 12),
                              Text(
                                "Uploading...",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 24),

              // ------------------ DAAN TITLE ------------------
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

              // ------------------ BUTTON LABEL ------------------
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

              // ------------------ BUTTON URL ------------------
              const Text(
                "Button URL *",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: buttonUrlCtrl,
                style: const TextStyle(fontSize: 12),
                validator: (v) => v == null || v.trim().isEmpty
                    ? "Button URL is required"
                    : null,
                decoration: daanFieldDecoration("https://example.com"),
              ),

              const SizedBox(height: 120),
            ],
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