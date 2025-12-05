// // // lib/screens/darshan/edit_darshan_page.dart
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import '../../../controllers/darshan_controller.dart';
// // import '../../../models/live_darshan_model.dart';
// //
// // import '../../../widgets/app_colors.dart';
// // import '../../../widgets/confirm.dart' as confirm;
// //
// // import '../../../widgets/imageuploadwidget.dart';
// //
// //
// //
// // class EditDarshanPage extends StatelessWidget {
// //   final DarshanModel darshan;
// //
// //   EditDarshanPage({required this.darshan});
// //
// //   final controller = Get.find<DarshanController>();
// //   final formKey = GlobalKey<FormState>();
// //
// //   late final titleCtrl = TextEditingController(text: darshan.title);
// //   late final templeCtrl = TextEditingController(text: darshan.templeName);
// //   late final linkCtrl = TextEditingController(text: darshan.liveLink);
// //
// //   late var webImage = Rxn<String>(darshan.webImage);
// //   late var mobileImage = Rxn<String>(darshan.mobileImage);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async {
// //         if (formKey.currentState!.validate() ||
// //             titleCtrl.text != darshan.title ||
// //             templeCtrl.text != darshan.templeName ||
// //             linkCtrl.text != darshan.liveLink ||
// //             webImage.value != darshan.webImage ||
// //             mobileImage.value != darshan.mobileImage) {
// //             return await showConfirmDialog(
// //             title: "Leave This Page?",
// //             content: "You've entered some information. If you go back, the changes won't be saved.",
// //             confirmText: "Discard",
// //             cancelText: "Keep Editing",
// //           );
// //         }
// //         return true;
// //       },
// //       child: Scaffold(
// //         backgroundColor: AppColors.hinduL1,
// //         appBar: AppBar(
// //           backgroundColor: AppColors.hinduBase,
// //           title: Text("Edit Darshan", style: TextStyle(color: Colors.white, fontSize: 20)),
// //           iconTheme: IconThemeData(color: Colors.white),
// //         ),
// //         body: SingleChildScrollView(
// //           padding: EdgeInsets.all(16),
// //           child: Form(
// //             key: formKey,
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 // Web & Mobile Image
// //                 ImageUploadWidget(
// //                   title: "Web & Mobile Image",
// //                   initialImage: darshan.webImage,
// //                   onPicked: (path) => webImage.value = path,
// //                 ),
// //                 SizedBox(height: 16),
// //
// //                 // Mobile Image
// //                 ImageUploadWidget(
// //                   title: "Upload Mobile Image",
// //                   initialImage: darshan.mobileImage,
// //                   onPicked: (path) => mobileImage.value = path,
// //                 ),
// //                 SizedBox(height: 20),
// //
// //                 // Mandir Name
// //                 TextFormField(
// //                   controller: templeCtrl,
// //                   decoration: InputDecoration(
// //                     labelText: "Mandir *",
// //                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                   ),
// //                   validator: (v) => v!.trim().isEmpty ? "Mandir name is required" : null,
// //                 ),
// //                 SizedBox(height: 16),
// //
// //                 // Title
// //                 TextFormField(
// //                   controller: titleCtrl,
// //                   maxLines: 2,
// //                   decoration: InputDecoration(
// //                     labelText: "Title *",
// //                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                   ),
// //                   validator: (v) => v!.trim().isEmpty ? "Title is required" : null,
// //                 ),
// //                 SizedBox(height: 16),
// //
// //                 // Live Link
// //                 TextFormField(
// //                   controller: linkCtrl,
// //                   decoration: InputDecoration(
// //                     labelText: "Live Darshan Link *",
// //                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                   ),
// //                   validator: (v) => v!.trim().isEmpty ? "Link is required" : null,
// //                 ),
// //                 SizedBox(height: 30),
// //
// //                 // UPDATE BUTTON
// //                 SizedBox(
// //                   width: double.infinity,
// //                   child: ElevatedButton(
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: AppColors.hinduBase,
// //                       padding: EdgeInsets.symmetric(vertical: 18),
// //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //                     ),
// //                     onPressed: () {
// //                       if (formKey.currentState!.validate()) {
// //                         final updatedDarshan = DarshanModel(
// //                           id: darshan.id,
// //                           title: titleCtrl.text.trim(),
// //                           templeName: templeCtrl.text.trim(),
// //                           liveLink: linkCtrl.text.trim(),
// //                           webImage: webImage.value ?? darshan.webImage,
// //                           mobileImage: mobileImage.value ?? darshan.mobileImage,
// //                           createdAt: darshan.createdAt,
// //                           isLive: darshan.isLive, description: '', subtitle: '', image: '',
// //                         );
// //
// //                         controller.updateDarshan(updatedDarshan);
// //                       }
// //                     },
// //                     child: Text(
// //                       "Update",
// //                       style: TextStyle(fontSize: 16,color: Colors.white)),
// //                     ),
// //                   ),
// //                 ),
// //
// //                 SizedBox(height: 12),
// //
// //                 // DELETE BUTTON (Optional)
// //                 SizedBox(
// //                   width: double.infinity,
// //                   child: OutlinedButton(
// //                     style: OutlinedButton.styleFrom(
// //                       foregroundColor: AppColors.red,
// //                       side: BorderSide(color: AppColors.red),
// //                       padding: EdgeInsets.symmetric(vertical: 16),
// //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //                     ),
// //                     onPressed: () async {
// //                       final confirm = await showConfirmDialog(
// //                         title: "Delete Darshan?",
// //                         content: "This action cannot be undone.",
// //                         confirmText: "Delete",
// //                         cancelText: "Cancel",
// //                         isDanger: true,
// //                       );
// //                       if (confirm == true) {
// //                         controller.deleteDarshan(darshan.id);
// //                       }
// //                     },
// //                     child: Text("Delete Darshan", style: TextStyle(fontSize: 16,color: Colors.red)),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// //
// //
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../controllers/darshan_controller.dart';
// import '../../../models/live_darshan_model.dart';
// import '../../../widgets/confirm.dart'; // <- ensure this path is valid
//
// class EditDarshanPage extends StatefulWidget {
//   final DarshanModel darshan;
//   const EditDarshanPage({Key? key, required this.darshan}) : super(key: key);
//
//   @override
//   _EditDarshanPageState createState() => _EditDarshanPageState();
// }
//
// class _EditDarshanPageState extends State<EditDarshanPage> {
//   final controller = Get.find<DarshanController>();
//   final formKey = GlobalKey<FormState>();
//
//   late final TextEditingController titleCtrl;
//   late final TextEditingController templeCtrl;
//   late final TextEditingController linkCtrl;
//
//   late final Rxn<String> webImage;
//   late final Rxn<String> mobileImage;
//
//   @override
//   void initState() {
//     super.initState();
//     titleCtrl = TextEditingController(text: widget.darshan.title);
//     templeCtrl = TextEditingController(text: widget.darshan.templeName);
//     linkCtrl = TextEditingController(text: widget.darshan.liveLink);
//
//     webImage = Rxn<String>(widget.darshan.webImage);
//     mobileImage = Rxn<String>(widget.darshan.mobileImage);
//   }
//
//   @override
//   void dispose() {
//     titleCtrl.dispose();
//     templeCtrl.dispose();
//     linkCtrl.dispose();
//     super.dispose();
//   }
//
//   bool get hasChanges {
//     return titleCtrl.text.trim() != (widget.darshan.title ?? '') ||
//         templeCtrl.text.trim() != (widget.darshan.templeName ?? '') ||
//         linkCtrl.text.trim() != (widget.darshan.liveLink ?? '') ||
//         webImage.value != widget.darshan.webImage ||
//         mobileImage.value != widget.darshan.mobileImage;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (hasChanges) {
//           final confirm = await showConfirmDialog(
//             title: "Leave This Page?",
//             content: "You've entered some information. If you go back, the changes won't be saved.",
//             confirmText: "Discard",
//             cancelText: "Keep Editing",
//           );
//
//           return confirm == true;
//         }
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Edit Darshan')),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: formKey,
//             child: Column(
//               children: [
//                 // ... your fields and buttons ...
//                 TextFormField(controller: templeCtrl, decoration: const InputDecoration(labelText: 'Mandir')),
//                 TextFormField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
//                 TextFormField(controller: linkCtrl, decoration: const InputDecoration(labelText: 'Link')),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (formKey.currentState!.validate()) {
//                       final updated = widget.darshan.copyWith(
//                         title: titleCtrl.text.trim(),
//                         templeName: templeCtrl.text.trim(),
//                         liveLink: linkCtrl.text.trim(),
//                         webImage: webImage.value ?? widget.darshan.webImage,
//                         mobileImage: mobileImage.value ?? widget.darshan.mobileImage,
//                       );
//                       controller.updateDarshan(updated);
//                     }
//                   },
//                   child: const Text('Update'),
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
// // lib/screens/darshan/edit_darshan_page.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../controllers/darshan_controller.dart';
// import '../../../models/live_darshan_model.dart';
// import '../../../widgets/app_colors.dart';
// import '../../../widgets/confirm.dart';
// import '../../../widgets/imageuploadwidget.dart';
//
// class EditDarshanPage extends StatefulWidget {
//   final DarshanModel darshan;
//
//   const EditDarshanPage({Key? key, required this.darshan}) : super(key: key);
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
//   final Rxn<String> webImage = Rxn<String>();
//   final Rxn<String> mobileImage = Rxn<String>();
//
//   @override
//   void initState() {
//     super.initState();
//     titleCtrl = TextEditingController(text: widget.darshan.title);
//     templeCtrl = TextEditingController(text: widget.darshan.templeName);
//     linkCtrl = TextEditingController(text: widget.darshan.liveLink);
//
//     webImage.value = widget.darshan.webImage;
//     mobileImage.value = widget.darshan.mobileImage;
//   }
//
//   bool get hasChanges {
//     return titleCtrl.text.trim() != widget.darshan.title ||
//         templeCtrl.text.trim() != widget.darshan.templeName ||
//         linkCtrl.text.trim() != widget.darshan.liveLink ||
//         webImage.value != widget.darshan.webImage ||
//         mobileImage.value != widget.darshan.mobileImage;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (hasChanges) {
//           final confirm = await showConfirmDialog(
//             title: "Leave This Page?",
//             content:
//             "You've modified some data. If you exit, changes will be lost.",
//             confirmText: "Discard",
//             cancelText: "Stay",
//           );
//           return confirm == true;
//         }
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.hinduL1,
//         appBar: AppBar(
//           backgroundColor: AppColors.hinduBase,
//           title: const Text("Edit Darshan",
//               style: TextStyle(color: Colors.white, fontSize: 20)),
//           iconTheme: const IconThemeData(color: Colors.white),
//         ),
//
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// Web Image
//                 ImageUploadWidget(
//                   title: "Web Image",
//                   initialImage: widget.darshan.webImage,
//                   onPicked: (path) => webImage.value = path,
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 /// Mobile Image
//                 ImageUploadWidget(
//                   title: "Mobile Image",
//                   initialImage: widget.darshan.mobileImage,
//                   onPicked: (path) => mobileImage.value = path,
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 /// Temple Name
//                 TextFormField(
//                   controller: templeCtrl,
//                   decoration: InputDecoration(
//                     labelText: "Mandir *",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                   validator: (v) =>
//                   v!.trim().isEmpty ? "Mandir name is required" : null,
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 /// Title
//                 TextFormField(
//                   controller: titleCtrl,
//                   maxLines: 2,
//                   decoration: InputDecoration(
//                     labelText: "Title *",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                   validator: (v) =>
//                   v!.trim().isEmpty ? "Title is required" : null,
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 /// Live Link
//                 TextFormField(
//                   controller: linkCtrl,
//                   decoration: InputDecoration(
//                     labelText: "Live Darshan Link *",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                   validator: (v) =>
//                   v!.trim().isEmpty ? "Link is required" : null,
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 /// UPDATE BUTTON
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.hinduBase,
//                       padding: const EdgeInsets.symmetric(vertical: 18),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30)),
//                     ),
//                     onPressed: () {
//                       if (formKey.currentState!.validate()) {
//                         final updated = widget.darshan.copyWith(
//                           title: titleCtrl.text.trim(),
//                           templeName: templeCtrl.text.trim(),
//                           liveLink: linkCtrl.text.trim(),
//                           webImage: webImage.value,
//                           mobileImage: mobileImage.value,
//                         );
//
//                         controller.updateDarshan(updated);
//                       }
//                     },
//                     child: const Text("Update",
//                         style: TextStyle(fontSize: 16, color: Colors.white)),
//                   ),
//                 ),
//
//                 const SizedBox(height: 12),
//
//                 // /// DELETE BUTTON
//                 // SizedBox(
//                 //   width: double.infinity,
//                 //  // child: OutlinedButton(
//                 //     style: OutlinedButton.styleFrom(
//                 //       foregroundColor: AppColors.red,
//                 //       side: BorderSide(color: AppColors.red),
//                 //       padding: const EdgeInsets.symmetric(vertical: 16),
//                 //       shape: RoundedRectangleBorder(
//                 //           borderRadius: BorderRadius.circular(12)),
//                 //     ),
//                 //     onPressed: () async {
//                 //       final confirm = await showConfirmDialog(
//                 //         title: "Delete Darshan?",
//                 //         content: "This action cannot be undone.",
//                 //         confirmText: "Delete",
//                 //         cancelText: "Cancel",
//                 //         isDanger: true,
//                 //       );
//                 //
//                 //       if (confirm == true) {
//                 //         controller.deleteDarshan(widget.darshan.id);
//                 //       }
//                 //     },
//                 //    // child: const Text("Delete Darshan",
//                 //      //   style: TextStyle(fontSize: 16, color: Colors.red)),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../controllers/darshan_controller.dart';
// import '../../../models/live_darshan_model.dart';
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
//   final Rxn<String> webImage = Rxn<String>();
//   final Rxn<String> mobileImage = Rxn<String>();
//
//   bool isLive = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     titleCtrl = TextEditingController(text: widget.darshan.title);
//     templeCtrl = TextEditingController(text: widget.darshan.templeName);
//     linkCtrl = TextEditingController(text: widget.darshan.liveLink);
//
//     webImage.value = widget.darshan.webImage;
//     mobileImage.value = widget.darshan.mobileImage;
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
//         title: const Text(
//           "Edit Darshan",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
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
//       // FIXED: ZERO TOP PADDING
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             // ---------------------------------------------------------
//             // BLOCK 0 : RICHTEXT BOX (FULL WIDTH, NO RADIUS)
//             // ---------------------------------------------------------
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               decoration: const BoxDecoration(
//                 color: Color(0xFFFFF1E9),   // Very light peach
//                 borderRadius: BorderRadius.zero, // SQUARE SHAPE
//               ),
//
//               child:  RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: "Web & Mobile Image\n",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     TextSpan(
//                       text:
//                       "Supported formats: JPG, PNG, GIF · Max size: 2 MB · 1 file only",
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.black54,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 0),
//
//             // ---------------------------------------------------------
//             // BLOCK 1 : IMAGE UPLOAD SECTION
//             // ---------------------------------------------------------
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFFE7D6), // Figma Peach Box
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   ImageUploadWidget(
//                     initialImage: webImage.value,
//                     onPicked: (path) => webImage.value = path,
//                     showInfo: false,
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   ImageUploadWidget(
//                     initialImage: mobileImage.value,
//                     onPicked: (path) => mobileImage.value = path,
//                     showInfo: false,
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 25),
//
//             // ---------------------------------------------------------
//             // BLOCK 2 : FORM FIELDS
//             // ---------------------------------------------------------
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _label("Mandir *"),
//                   _textbox(templeCtrl),
//
//                   const SizedBox(height: 20),
//
//                   _label("Title *"),
//                   _textbox(titleCtrl, maxLines: 2),
//
//                   const SizedBox(height: 20),
//
//                   _label("Live Darshan Link *"),
//                   _textbox(linkCtrl),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 30),
//
//             // ---------------------------------------------------------
//             // BLOCK 3 : UPDATE BUTTON (PILL SHAPE)
//             // ---------------------------------------------------------
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.hinduBase,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(40),
//                     ),
//                   ),
//                   onPressed: () {
//                     if (formKey.currentState!.validate()) {
//                       final updated = widget.darshan.copyWith(
//                         title: titleCtrl.text.trim(),
//                         templeName: templeCtrl.text.trim(),
//                         liveLink: linkCtrl.text.trim(),
//                         webImage: webImage.value,
//                         mobileImage: mobileImage.value,
//                         isLive: isLive,
//                       );
//
//                       controller.updateDarshan(updated);
//                     }
//                   },
//                   child: const Text(
//                     "Update",
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ---------------------------------------------------------
//   // LABEL STYLE
//   // ---------------------------------------------------------
//   Widget _label(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 4),
//       child: Text(
//         text,
//         style: const TextStyle(
//           fontSize: 15,
//           fontWeight: FontWeight.w600,
//           color: Colors.black87,
//         ),
//       ),
//     );
//   }
//
//   // ---------------------------------------------------------
//   // TEXTBOX STYLE (SQUARE, FONT SIZE 12)
//   // ---------------------------------------------------------
//   Widget _textbox(TextEditingController c, {int maxLines = 1}) {
//     return Container(
//       margin: const EdgeInsets.only(top: 6),
//       child: TextFormField(
//         controller: c,
//         maxLines: maxLines,
//         style: const TextStyle(
//           fontSize: 12,
//           color: Colors.black87,
//         ),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.grey.shade100,
//
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.zero,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.zero,
//             borderSide: BorderSide(color: Colors.grey.shade400),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.zero,
//             borderSide: BorderSide(color: Colors.grey, width: 1),
//           ),
//
//           contentPadding:
//           const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//         ),
//         validator: (v) => v!.trim().isEmpty ? "Required" : null,
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/darshan_controller.dart';
import '../../../models/live_darshan_model.dart';
import '../../../widgets/app_colors.dart';
import '../../../widgets/imageuploadwidget.dart';

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
  late TextEditingController templeCtrl;
  late TextEditingController linkCtrl;

  final Rxn<String> webImage = Rxn<String>();
  final Rxn<String> mobileImage = Rxn<String>();

  bool isLive = false;

  @override
  void initState() {
    super.initState();

    titleCtrl = TextEditingController(text: widget.darshan.title);
    templeCtrl = TextEditingController(text: widget.darshan.templeName);
    linkCtrl = TextEditingController(text: widget.darshan.liveLink);

    webImage.value = widget.darshan.webImage;
    mobileImage.value = widget.darshan.mobileImage;

    isLive = widget.darshan.isLive;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: AppColors.hinduBase,
        title: const Text("Edit Darshan",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Switch(
            value: isLive,
            onChanged: (v) => setState(() => isLive = v),
            activeColor: Colors.white,
          ),
        ],
      ),

      // ******** FIXED FORM KEY WRAPPING ********
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ---------------- RICHTEXT BOX ----------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: const Color(0xFFFFF1E9),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Web & Mobile Image\n",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text:
                        "Supported formats: JPG, PNG, GIF · Max size: 2 MB · 1 file only",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 0),

              // --------//------//-- IMAGE UPLOAD SECTION -----//--------//---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE7D6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ImageUploadWidget(
                      initialImage: webImage.value,
                      onPicked: (path) => webImage.value = path,
                      showInfo: false,
                    ),
                    const SizedBox(height: 20),
                    ImageUploadWidget(
                      initialImage: mobileImage.value,
                      onPicked: (path) => mobileImage.value = path,
                      showInfo: false,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ---------------- FORM FIELDS ----------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label("Mandir *"),
                    _textbox(templeCtrl),

                    const SizedBox(height: 20),

                    _label("Title *"),
                    _textbox(titleCtrl, maxLines: 2),

                    const SizedBox(height: 20),

                    _label("Live Darshan Link *"),
                    _textbox(linkCtrl),
                  ],
                ),
              ),

              const SizedBox(height: 30),


              // ---------------- UPDATE BUTTON ----------------
              Padding(
                padding: const EdgeInsets.only(bottom: 5,left: 16,right: 16 ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.hinduBase,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),

                    // ******** FIXED UPDATE LOGIC ********
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;

                      final updated = widget.darshan.copyWith(
                        title: titleCtrl.text.trim(),
                        templeName: templeCtrl.text.trim(),
                        liveLink: linkCtrl.text.trim(),
                        webImage: webImage.value,
                        mobileImage: mobileImage.value,
                        isLive: isLive,
                      );

                      controller.updateDarshan(updated);

                      Get.back(); // Go back after updating
                    },

                    child: const Text(
                      "Update",
                      style: TextStyle(fontSize: 16, color: Colors.white),
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

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _textbox(TextEditingController c, {int maxLines = 1}) {
    return Container(
      margin: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
      child: TextFormField(
        controller: c,
        maxLines: maxLines,
        validator: (v) => v!.trim().isEmpty ? "Required" : null,
        style: const TextStyle(fontSize: 12),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(borderRadius: BorderRadius.zero),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      ),
    );
  }
}





