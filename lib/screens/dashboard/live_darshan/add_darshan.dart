// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// //import '../../../controllers/add_darshan.dart';
// import '../../../controllers/darshan_controller.dart';
// import '../../../utils/imageconverter.dart';
// import '../../../widgets/app_colors.dart';
// import '';
//
//
// class AddDarshanPage extends StatefulWidget {
//   const AddDarshanPage({super.key});
//
//   @override
//   State<AddDarshanPage> createState() => _AddDarshanPageState();
// }
//
// class _AddDarshanPageState extends State<AddDarshanPage> {
//   final addController = Get.put(DarshanController());
//   final darshanController = Get.find<DarshanController>();
//
//   final formKey = GlobalKey<FormState>();
//
//   final titleCtrl = TextEditingController();
//   final linkCtrl = TextEditingController();
//
//   final Rxn<String> mobile_image = Rxn<String>();
//
//   Future<String?> pickImage() async {
//     final img = await ImagePicker().pickImage(source: ImageSource.gallery);
//     return img?.path;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       appBar: AppBar(
//         backgroundColor: AppColors.hinduBase,
//         title: const Text("Add Live Darshan", style: TextStyle(color: Colors.white)),
//         iconTheme: const IconThemeData(color: Colors.white),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
//         ),
//       ),
//
//       // -------------------- BOTTOM BUTTON ----------------------
//       bottomNavigationBar: Obx(() => Container(
//         padding: const EdgeInsets.all(16),
//         color: Colors.white,
//         child: SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.hinduBase,
//               padding: const EdgeInsets.symmetric(vertical: 14),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(40),
//               ),
//             ),
//
//             onPressed: addController.isLoading.value ? null : () async {
//               print("========== CREATE DARSHAN START ==========");
//               print("Title: ${titleCtrl.text.trim()}");
//               print("Embedded Link: ${linkCtrl.text.trim()}");
//               print("Image Path: ${mobile_image.value}");
//
//               if (!formKey.currentState!.validate()) {
//                 print("❌ Validation Failed");
//                 Get.snackbar("Validation Error", "Please fill all required fields");
//                 return;
//               }
//
//               if (mobile_image.value == null || mobile_image.value!.isEmpty) {
//                 print("❌ No Image Selected");
//                 Get.snackbar("Error", "Please upload an image");
//                 return;
//               }
//
//               print("➡️ Calling AddDarshanController.addDarshan()");
//               // final success = await addController.addDarshan(
//               //   title: titleCtrl.text.trim(),
//               //   embeddedLink: linkCtrl.text.trim(),
//               //   mobile_image: mobile_image.value!,
//               // );
//               // 🔥 convert image BEFORE upload
//               final safePath = await forceConvertToJpg(mobile_image.value!);
//
//               final success = await addController.addDarshan(
//                 title: titleCtrl.text.trim(),
//                 embeddedLink: linkCtrl.text.trim(),
//                 mobile_image: safePath,
//               );
//
//
//               print("AddDarshan Returned Success: $success");
//
//               if (success) {
//                 print("➡️ Refreshing DarshanController...");
//                 await darshanController.fetchDarshans();
//
//                 print("➡️ Closing Page...");
//                 Get.back();
//
//                 Get.snackbar("Success", "Darshan Added Successfully");
//               }
//
//               print("========== CREATE DARSHAN END ==========");
//             },
//
//             child: addController.isLoading.value
//                 ? const SizedBox(
//               height: 24,
//               width: 24,
//               child: CircularProgressIndicator(
//                 color: Colors.white,
//                 strokeWidth: 2,
//               ),
//             )
//                 : const Text(
//               "Create",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       )),
//
//       // -------------------- BODY FORM ----------------------
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _label("Upload Image *"),
//               const SizedBox(height: 16),
//
//               GestureDetector(
//                 onTap: () async {
//                   final img = await pickImage();
//                   if (img != null) setState(() => mobile_image.value = img);
//                 },
//                 child: _uploadBox(path: mobile_image.value),
//               ),
//
//               const SizedBox(height: 24),
//
//               _label("Title *"),
//               _textfield(
//                 controller: titleCtrl,
//                 hint: "Enter Live Darshan title",
//               ),
//
//               const SizedBox(height: 20),
//
//               _label("Live Darshan Link *"),
//               _textfield(
//                 controller: linkCtrl,
//                 hint: "Paste the Live Darshan embed link",
//               ),
//
//               const SizedBox(height: 120),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // -------------------- Helper Widgets ----------------------
//
//   Widget _label(String text) => Padding(
//     padding: const EdgeInsets.only(left: 4, bottom: 6),
//     child: Text(
//       text,
//       style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
//     ),
//   );
//
//   Widget _textfield({
//     required TextEditingController controller,
//     required String hint,
//   }) {
//     return TextFormField(
//       controller: controller,
//       validator: (v) => v!.trim().isEmpty ? "This field is required" : null,
//       style: const TextStyle(fontSize: 13),
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: const TextStyle(fontSize: 13, color: Colors.black38),
//         filled: true,
//         fillColor: Colors.grey.shade200,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: BorderSide(color: Colors.grey.shade400),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: BorderSide(color: AppColors.hinduBase),
//         ),
//       ),
//     );
//   }
//
//   Widget _uploadBox({String? path}) {
//     return Container(
//       height: 140,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Center(
//         child: path == null
//             ? Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.cloud_upload_outlined,
//                 color: Colors.grey.shade600, size: 32),
//             const SizedBox(height: 6),
//             const Text(
//               "Upload Mobile Image",
//               style: TextStyle(fontSize: 14, color: Colors.black54),
//             ),
//           ],
//         )
//             : ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Image.file(
//             File(path),
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/darshan_controller.dart';
import '../../../utils/imageconverter.dart';
import '../../../widgets/app_colors.dart';
import '../../../widgets/confordaan.dart' show showConfirmDiscard;

class AddDarshanPage extends StatefulWidget {
  const AddDarshanPage({super.key});

  @override
  State<AddDarshanPage> createState() => _AddDarshanPageState();
}

class _AddDarshanPageState extends State<AddDarshanPage> {
  final DarshanController addController = Get.put(DarshanController());
  final DarshanController darshanController = Get.find<DarshanController>();

  final formKey = GlobalKey<FormState>();

  final titleCtrl = TextEditingController();
  final linkCtrl = TextEditingController();

  final Rxn<String> mobile_image = Rxn<String>();

  // ---------------- DISCARD CHECK ----------------
  bool get _hasInput =>
      titleCtrl.text
          .trim()
          .isNotEmpty ||
          linkCtrl.text
              .trim()
              .isNotEmpty ||
          mobile_image.value != null;

  Future<bool> _onWillPop() async {
    if (!_hasInput) return true;

    final confirm = await showConfirmDiscard(
      title: "Leave This Page?",
      content:
      "You've entered some information. If you go back, it will be lost.",
    );

    return confirm ?? false;
  }

  // ---------------- IMAGE PICKER ----------------
  Future<String?> pickImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    return img?.path;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),

        // ---------------- APP BAR ----------------
        appBar: AppBar(
          backgroundColor: AppColors.hinduBase,
          title: const Text(
            "Add Live Darshan",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
          ),
        ),

        // ---------------- BOTTOM BUTTON ----------------
        bottomNavigationBar: Obx(
              () =>
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.hinduBase,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onPressed: addController.isLoading.value
                        ? null
                        : () async {
                      print("========== CREATE DARSHAN START ==========");
                      print("Title: ${titleCtrl.text.trim()}");
                      print("Embedded Link: ${linkCtrl.text.trim()}");
                      print("Image Path: ${mobile_image.value}");

                      if (!formKey.currentState!.validate()) {
                        Get.snackbar(
                            "Validation Error", "Please fill all fields");
                        return;
                      }

                      if (mobile_image.value == null ||
                          mobile_image.value!.isEmpty) {
                        Get.snackbar("Error", "Please upload an image");
                        return;
                      }

                      // 🔥 CONVERT IMAGE
                      final safePath =
                      await forceConvertToJpg(mobile_image.value!);

                      final success =
                      await addController.addDarshan(
                        title: titleCtrl.text.trim(),
                        embeddedLink: linkCtrl.text.trim(),
                        mobile_image: safePath,
                      );

                      if (success) {
                        await darshanController.fetchDarshans();
                        Get.back();
                        Get.snackbar(
                            "Success", "Darshan Added Successfully");
                      }

                      print("========== CREATE DARSHAN END ==========");
                    },
                    child: addController.isLoading.value
                        ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text(
                      "Create",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
        ),

        // ---------------- BODY ----------------
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label("Upload Image *"),
                const SizedBox(height: 16),

                GestureDetector(
                  onTap: () async {
                    final img = await pickImage();
                    if (img != null) {
                      setState(() => mobile_image.value = img);
                    }
                  },
                  child: _uploadBox(path: mobile_image.value),
                ),

                const SizedBox(height: 24),

                _label("Title *"),
                _textfield(
                  controller: titleCtrl,
                  hint: "Enter Live Darshan title",
                ),

                const SizedBox(height: 20),

                _label("Live Darshan Link *"),
                _textfield(
                  controller: linkCtrl,
                  hint: "Paste the Live Darshan embed link",
                ),

                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- HELPER WIDGETS ----------------

  Widget _label(String text) =>
      Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 6),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      );

  Widget _textfield({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      validator: (v) => v!.trim().isEmpty ? "This field is required" : null,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13, color: Colors.black38),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }



  Widget _uploadBox({String? path}) {
    return DottedBorder(
      color: const Color(0xFFFF7722),
      strokeWidth: 2,
      dashPattern: const [6, 4],
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      child: Container(
        width: double.infinity,
        height: 220,
        padding: path == null
            ? const EdgeInsets.all(24)
            : EdgeInsets.zero, // 🔥 KEY LINE
        child: path == null
            ? const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload,
              size: 50,
              color: Color(0xFFFF7722),
            ),
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
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            File(path),
            fit: BoxFit.cover, // 🔥 FULL COVER
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }

}


