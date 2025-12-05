// // lib/screens/darshan/add_darshan_page.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../controllers/darshan_controller.dart';
// import '../../../models/live_darshan_model.dart';
// import '../../../widgets/app_colors.dart';
// import '../../../widgets/confirm.dart';
// import '../../../widgets/imageuploadwidget.dart';
//
// class AddDarshanPage extends StatelessWidget {
//   final controller = Get.find<DarshanController>();
//   final formKey = GlobalKey<FormState>();
//
//   final titleCtrl = TextEditingController();
//   final templeCtrl = TextEditingController();
//   final linkCtrl = TextEditingController();
//   var webImage = Rxn<String>();
//   var mobileImage = Rxn<String>();
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () =>
//         showConfirmDialog(),
//       //  },
//       child: Scaffold(
//         backgroundColor: AppColors.hinduL1,
//         appBar: AppBar(
//           backgroundColor: AppColors.hinduBase,
//           title: Text("Add Darshan", style: TextStyle(color: Colors.white)),
//         ),
//         body: SingleChildScrollView(
//           padding: EdgeInsets.all(16),
//           child: Form(
//             key: formKey,
//             child: Column(
//               children: [
//                 ImageUploadWidget(title: "Web & Mobile Image", onPicked: (path) => webImage.value = path),
//                 SizedBox(height: 16),
//                 ImageUploadWidget(title: "Upload Mobile Image", onPicked: (path) => mobileImage.value = path),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: templeCtrl,
//                   decoration: InputDecoration(labelText: "Mandir *", border: OutlineInputBorder()),
//                   validator: (v) => v!.isEmpty ? "Required" : null,
//                 ),
//                 SizedBox(height: 16),
//                 TextFormField(
//                   controller: titleCtrl,
//                   decoration: InputDecoration(labelText: "Title *", border: OutlineInputBorder()),
//                   validator: (v) => v!.isEmpty ? "Required" : null,
//                 ),
//                 SizedBox(height: 16),
//                 TextFormField(
//                   controller: linkCtrl,
//                   decoration: InputDecoration(labelText: "Live Darshan Link *", border: OutlineInputBorder()),
//                   validator: (v) => v!.isEmpty ? "Required" : null,
//                 ),
//                 SizedBox(height: 30),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: AppColors.hinduBase, padding: EdgeInsets.all(16)),
//                     onPressed: () {
//                       if (formKey.currentState!.validate()) {
//                         final newDarshan = DarshanModel(
//                           id: "",
//                           title: titleCtrl.text,
//                           templeName: templeCtrl.text,
//                           liveLink: linkCtrl.text,
//                           webImage: webImage.value,
//                           mobileImage: mobileImage.value,
//                           createdAt: DateTime.now(),
//                           // ye to sab m likha jayga na
//                           isLive: true, description: '', subtitle: '', image: '',
//                         );
//                         controller.addDarshan(newDarshan);
//                       }
//                     },
//                     child: Text("Create", style: TextStyle(fontSize: 18, color: Colors.white)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



//
// // lib/screens/darshan/add_darshan_page.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../controllers/darshan_controller.dart';
// import '../../../models/live_darshan_model.dart';
// import '../../../widgets/app_colors.dart';
// import '../../../widgets/confirm.dart';
// import '../../../widgets/imageuploadwidget.dart';
//
// class AddDarshanPage extends StatelessWidget {
//   final controller = Get.find<DarshanController>();
//   final formKey = GlobalKey<FormState>();
//
//   final titleCtrl = TextEditingController();
//   final templeCtrl = TextEditingController();
//   final linkCtrl = TextEditingController();
//
//   final Rxn<String> webImage = Rxn<String>();
//   final Rxn<String> mobileImage = Rxn<String>();
//
//   AddDarshanPage({super.key});
//
//   bool get _hasInput {
//     return templeCtrl.text.trim().isNotEmpty ||
//         titleCtrl.text.trim().isNotEmpty ||
//         linkCtrl.text.trim().isNotEmpty ||
//         webImage.value != null ||
//         mobileImage.value != null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (_hasInput) {
//           final confirm = await showConfirmDialog(
//             title: "Discard Changes?",
//             content: "You have unsaved data. Do you want to leave?",
//             confirmText: "Discard",
//             cancelText: "Cancel",
//           );
//           return confirm == true;
//         }
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.hinduL1,
//         appBar: AppBar(
//           backgroundColor: AppColors.hinduBase,
//           title: const Text("Add Darshan", style: TextStyle(color: Colors.white)),
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: formKey,
//             child: Column(
//               children: [
//                 ImageUploadWidget(
//                   //title: "Web & Mobile Image",
//                   onPicked: (path) => webImage.value = path,
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 ImageUploadWidget(
//                   //title: "Upload Mobile Image",
//                   onPicked: (path) => mobileImage.value = path,
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 TextFormField(
//                   controller: templeCtrl,
//                   decoration: const InputDecoration(
//                     labelText: "Mandir *",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (v) => v!.trim().isEmpty ? "Required" : null,
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 TextFormField(
//                   controller: titleCtrl,
//                   decoration: const InputDecoration(
//                     labelText: "Title *",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (v) => v!.trim().isEmpty ? "Required" : null,
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 TextFormField(
//                   controller: linkCtrl,
//                   decoration: const InputDecoration(
//                     labelText: "Live Darshan Link *",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (v) => v!.trim().isEmpty ? "Required" : null,
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.hinduBase,
//                       padding: const EdgeInsets.all(16),
//                     ),
//                     onPressed: () {
//                       if (formKey.currentState!.validate()) {
//                         final newDarshan = DarshanModel(
//                           id: "",
//                           title: titleCtrl.text.trim(),
//                           templeName: templeCtrl.text.trim(),
//                           liveLink: linkCtrl.text.trim(),
//
//                           // required fields
//                           subtitle: "",
//                           description: "",
//                           image: webImage.value ?? "", // fallback
//
//                           webImage: webImage.value,
//                           mobileImage: mobileImage.value,
//
//                           createdAt: DateTime.now(),
//                           isLive: true,
//                         );
//
//                         controller.addDarshan(newDarshan);
//                       }
//                     },
//                     child: const Text("Create",
//                         style: TextStyle(fontSize: 16, color: Colors.white)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/darshan_controller.dart';
import '../../../models/live_darshan_model.dart';
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
  final templeCtrl = TextEditingController();
  final linkCtrl = TextEditingController();

  final Rxn<String> webImage = Rxn<String>();
  final Rxn<String> mobileImage = Rxn<String>();

  // REAL IMAGE PICKER
  Future<String?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);
    return img?.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor: AppColors.hinduBase,
        title: const Text("Add Darshan", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Switch(
            value: true,
            onChanged: (_) {},
            activeColor: Colors.white,
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // -------------------------------------------------
              // TOP HEADING SECTION
              // -------------------------------------------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE8D8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Web & Mobile Image",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Supported formats: JPG, PNG, GIF · Max size: 2 MB · 1 file only",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // -------------------------------------------------
              // UPLOAD WEB IMAGE
              // -------------------------------------------------
              GestureDetector(
                onTap: () async {
                  final img = await pickImage();
                  if (img != null) setState(() => webImage.value = img);
                },
                child: uploadBox(
                  text: "Upload Web Image",
                  path: webImage.value,
                ),
              ),

              const SizedBox(height: 16),

              // -------------------------------------------------
              // UPLOAD MOBILE IMAGE
              // -------------------------------------------------
              GestureDetector(
                onTap: () async {
                  final img = await pickImage();
                  if (img != null) setState(() => mobileImage.value = img);
                },
                child: uploadBox(
                  text: "Upload Mobile Image",
                  path: mobileImage.value,
                ),
              ),

              const SizedBox(height: 24),

              // -------------------------------------------------
              // MANDIR FIELD
              // -------------------------------------------------
              _label("Mandir *"),
              _textfield(
                controller: templeCtrl,
                hint: "ISKCON Temple Vrindavan",
              ),

              const SizedBox(height: 20),

              // -------------------------------------------------
              // TITLE FIELD
              // -------------------------------------------------
              _label("Title *"),
              _textfield(
                controller: titleCtrl,
                hint: "Enter Live Darshan title",
              ),

              const SizedBox(height: 20),

              // -------------------------------------------------
              // LINK FIELD
              // -------------------------------------------------
              _label("Live Darshan Link *"),
              _textfield(
                controller: linkCtrl,
                hint: "Paste the Live Darshan embed link",
              ),

              const SizedBox(height: 28),

              // -------------------------------------------------
              // CREATE BUTTON
              // -------------------------------------------------
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.hinduBase,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final newDarshan = DarshanModel(
                        id: "",
                        title: titleCtrl.text.trim(),
                        templeName: templeCtrl.text.trim(),
                        liveLink: linkCtrl.text.trim(),
                        subtitle: "",
                        description: "",
                        image: webImage.value ?? "",
                        webImage: webImage.value,
                        mobileImage: mobileImage.value,
                        createdAt: DateTime.now(),
                        isLive: true,
                      );

                      controller.addDarshan(newDarshan);
                    }
                  },
                  child: const Text(
                    "Create",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------
  // LABEL
  // -------------------------------------------------
  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(left: 4, bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
    ),
  );

  // -------------------------------------------------
  // TEXTFIELD
  // -------------------------------------------------
  Widget _textfield({required TextEditingController controller, required String hint}) {
    return TextFormField(
      controller: controller,
      validator: (v) => v!.trim().isEmpty ? "Required" : null,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13, color: Colors.black38),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: AppColors.hinduBase),
        ),
      ),
    );
  }

  // -------------------------------------------------
  // UPLOAD BOX
  // -------------------------------------------------
  Widget uploadBox({required String text, String? path}) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: path == null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload_outlined, color: Colors.grey.shade600, size: 32),
            const SizedBox(height: 6),
            Text(text, style: const TextStyle(fontSize: 14, color: Colors.black54)),
          ],
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(path),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}


