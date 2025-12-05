// // YE LINE ADD KAR (EditDaanPage ke upar)
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../controllers/donation_controllers.dart';
// import '../../../models/donation_model.dart';
// import '../../../widgets/app_colors.dart';
// import '../../../widgets/confordaan.dart';
// import '../../../widgets/imgupfordaan.dart';
// import '../../../widgets/successdaan.dart';
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
//   String? imagePath;
//
//   @override
//   void initState() {
//     super.initState();
//     titleCtrl = TextEditingController(text: widget.daan.title);
//     buttonLabelCtrl = TextEditingController(text: widget.daan.buttonLabel);
//     buttonUrlCtrl = TextEditingController(text: widget.daan.buttonUrl);
//     imagePath = widget.daan.imageUrl;
//   }
//
//   bool get hasChanges {
//     return titleCtrl.text.trim() != widget.daan.title ||
//         buttonLabelCtrl.text.trim() != widget.daan.buttonLabel ||
//         buttonUrlCtrl.text.trim() != widget.daan.buttonUrl ||
//         imagePath != widget.daan.imageUrl;
//   }
//
//   Future<bool> _onWillPop() async {
//     if (!hasChanges) return true;
//     final result = await showConfirmDiscard(title: '', content: '');
//     return result ?? false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         backgroundColor: AppColors.hinduL1,
//         appBar: AppBar(
//
//           backgroundColor: AppColors.hinduBase,
//           title: Text('Edit Daan', style: TextStyle(color: Colors.white)),
//         ),
// //         body: SingleChildScrollView(
// //           padding: EdgeInsets.all(16),
// //           child: Form(
// //             key: formKey,
// //             child: Column(
// //               children: [
// //                 // IMAGE UPLOAD
// //                 ImageUploadWidget(
// //                   imagePath: imagePath,
// //                   placeholderText: 'uploaded_image_compressed.jpg',
// //                   onPicked: (p) => setState(() => imagePath = p),
// //                 ),
// //                 SizedBox(height: 18),
// //
// //                 TextFormField(
// //                   controller: titleCtrl,
// //                   maxLines: 4,
// //                   validator: (v) => v!.trim().isEmpty ? 'Required' : null,
// //                   decoration: InputDecoration(
// //                     labelText: 'Daan Title *',
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                     border: OutlineInputBorder(),
// //                   ),
// //                 ),
// //                 SizedBox(height: 16),
// //
// //                 TextFormField(
// //                   controller: buttonLabelCtrl,
// //                   validator: (v) => v!.trim().isEmpty ? 'Required' : null,
// //                   decoration: InputDecoration(
// //                     labelText: 'Button Label *',
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                     border: OutlineInputBorder(),
// //                   ),
// //                 ),
// //                 SizedBox(height: 16),
// //
// //                 TextFormField(
// //                   controller: buttonUrlCtrl,
// //                   validator: (v) => v!.trim().isEmpty ? 'Required' : null,
// //                   decoration: InputDecoration(
// //                     labelText: 'Button URL *',
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                     border: OutlineInputBorder(),
// //                   ),
// //                 ),
// //                 SizedBox(height: 30),
// //
// //                 Row(
// //                   children: [
// //                     // Expanded(
// //                     //   child: OutlinedButton(
// //                     //     style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
// //                     //     onPressed: () => Get.back(),
// //                     //     child: Text('Back'),
// //                     //   ),
// //                     // ),
// //                     SizedBox(width: 12),
// //                     Expanded(
// //                       child: ElevatedButton(
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: AppColors.hinduBase,
// //                           padding: const EdgeInsets.only(bottom: 5,left: 16,right: 16 ),
// //                         ),
// //                         onPressed: () async {
// //                           if (formKey.currentState!.validate()) {
// //                             final updated = widget.daan.copyWith(
// //                               title: titleCtrl.text.trim(),
// //                               buttonLabel: buttonLabelCtrl.text.trim(),
// //                               buttonUrl: buttonUrlCtrl.text.trim(),
// //                               imageUrl: imagePath,
// //                             );
// //                             await controller.updateDaan(updated);
// //                             await showSuccessDialog(
// //                               title: 'Daan Changed Successfully',
// //                               subtitle: 'Your daan entry is changed.',
// //                             );
// //                             Get.back();
// //                           }
// //                         },
// //                         child: Text('Update', style: TextStyle(color: Colors.white)),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(height: 12),
// //                 // SizedBox(
// //                 //   width: double.infinity,
// //                 //   child: OutlinedButton(
// //                 //     style: OutlinedButton.styleFrom(
// //                 //       side: BorderSide(color: Colors.red),
// //                 //       padding: EdgeInsets.symmetric(vertical: 16),
// //                 //     ),
// //                 //     onPressed: () async {
// //                 //       final confirm = await showConfirmDiscard(
// //                 //         title: "Delete Daan?",
// //                 //         content: "This action cannot be undone.",
// //                 //         isDanger: true,
// //                 //       );
// //                 //       if (confirm == true) {
// //                 //         await controller.deleteDaan(widget.daan.id);
// //                 //         Get.back();
// //                 //       }
// //                 //     },
// //                 //     //child: Text('Delete Daan', style: TextStyle(color: Colors.red)),
// //                 //   ),
// //                 // ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
//           body: SingleChildScrollView(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 // ------------------ UPLOAD IMAGE SECTION ------------------
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Upload Image",
//                         style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         "Supported formats: JPG, PNG, GIF · Max size: 2 MB · 1 file only",
//                         style: TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                       SizedBox(height: 16),
//
//                       ImageUploadWidget(
//                         imagePath: imagePath,
//                         placeholderText: 'uploaded_image_compressed.jpg',
//                         onPicked: (p) => setState(() => imagePath = p),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 18),
//
//                 // ------------------ DAAN TITLE SECTION ------------------
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Daan Title *",
//                           style: TextStyle(fontWeight: FontWeight.w600)),
//                       SizedBox(height: 8),
//                       TextFormField(
//                         controller: titleCtrl,
//                         maxLines: 4,
//                         decoration: InputDecoration(
//                           hintText: "Help...",
//                           filled: true,
//                           fillColor: Colors.grey.shade50,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 18),
//
//                 // ------------------ BUTTON LABEL ------------------
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Button Label *",
//                           style: TextStyle(fontWeight: FontWeight.w600)),
//                       SizedBox(height: 8),
//                       TextFormField(
//                         controller: buttonLabelCtrl,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.grey.shade50,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 18),
//
//                 // ------------------ BUTTON URL ------------------
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Button URL *",
//                           style: TextStyle(fontWeight: FontWeight.w600)),
//                       SizedBox(height: 8),
//                       TextFormField(
//                         controller: buttonUrlCtrl,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.grey.shade50,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 30),
//
//                 // ------------------ UPDATE BUTTON ------------------
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.hinduBase,
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                     ),
//                     onPressed: _updateDaan,
//                     child: Text("Update",
//                         style: TextStyle(color: Colors.white, fontSize: 16)),
//                   ),
//                 ),
//
//                 SizedBox(height: 30),
//               ],
//             ),
//           ),
//
//           }
//  }


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/donation_controllers.dart';
import '../../../models/donation_model.dart';
import '../../../widgets/app_colors.dart';
import '../../../widgets/confordaan.dart';
import '../../../widgets/imgupfordaan.dart';
import '../../../widgets/successdaan.dart';

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
  String? imagePath;

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(text: widget.daan.title);
    buttonLabelCtrl = TextEditingController(text: widget.daan.buttonLabel);
    buttonUrlCtrl = TextEditingController(text: widget.daan.buttonUrl);
    imagePath = widget.daan.imageUrl;
  }

  bool get hasChanges {
    return titleCtrl.text.trim() != widget.daan.title ||
        buttonLabelCtrl.text.trim() != widget.daan.buttonLabel ||
        buttonUrlCtrl.text.trim() != widget.daan.buttonUrl ||
        imagePath != widget.daan.imageUrl;
  }

  Future<bool> _onWillPop() async {
    if (!hasChanges) return true;
    final result = await showConfirmDiscard(title: '', content: '');
    return result ?? false;
  }

  // --------------------------
  // FINAL UPDATE METHOD
  // --------------------------
  Future<void> _updateDaan() async {
    if (!formKey.currentState!.validate()) return;

    final updated = widget.daan.copyWith(
      title: titleCtrl.text.trim(),
      buttonLabel: buttonLabelCtrl.text.trim(),
      buttonUrl: buttonUrlCtrl.text.trim(),
      imageUrl: imagePath,
    );

    await controller.updateDaan(updated);

    await showSuccessDialog(
      title: "Daan Updated Successfully",
      subtitle: "Your daan entry has been updated.",
    );

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.hinduL1,

        appBar: AppBar(
          backgroundColor: AppColors.hinduBase,
          title: Text("Edit Daan", style: TextStyle(color: Colors.white)),
        ),

        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ------------------ UPLOAD IMAGE ------------------
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Upload Image",
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      SizedBox(height: 4),
                      Text(
                        "Supported formats: JPG, PNG, GIF · Max size: 2 MB · 1 file only",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 16),

                      ImageUploadWidget(
                        imagePath: imagePath,
                        placeholderText: "uploaded_image_compressed.jpg",
                        onPicked: (p) => setState(() => imagePath = p),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 18),

                // ------------------ TITLE ------------------
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Daan Title *",
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      SizedBox(height: 8),

                      TextFormField(
                        controller: titleCtrl,
                        maxLines: 4,
                        validator: (v) =>
                        v!.trim().isEmpty ? "Required" : null,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 18),

                // ------------------ BUTTON LABEL ------------------
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Button Label *",
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      SizedBox(height: 8),

                      TextFormField(
                        controller: buttonLabelCtrl,
                        validator: (v) =>
                        v!.trim().isEmpty ? "Required" : null,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 18),

                // ------------------ BUTTON URL ------------------
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Button URL *",
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      SizedBox(height: 8),

                      TextFormField(
                        controller: buttonUrlCtrl,
                        validator: (v) =>
                        v!.trim().isEmpty ? "Required" : null,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // ------------------ UPDATE BUTTON ------------------
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.hinduBase,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: _updateDaan,
                    child: Text("Update",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
