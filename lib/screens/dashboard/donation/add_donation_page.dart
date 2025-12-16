import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/donation_controllers.dart';
import '../../../models/donation_model.dart';
import '../../../widgets/app_colors.dart';
import '../../../widgets/confordaan.dart' show showConfirmDiscard;
import '../../../widgets/imgupfordaan.dart';
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

  String? imagePath;

  bool get _hasInput =>
      titleCtrl.text.trim().isNotEmpty ||
          buttonLabelCtrl.text.trim().isNotEmpty ||
          buttonUrlCtrl.text.trim().isNotEmpty ||
          imagePath != null;

  Future<bool> _onWillPop() async {
    if (!_hasInput) return true;
    final confirm = await showConfirmDiscard(
      title: 'Leave This Page?',
      content: "You've entered some information. If you go back, it will be lost.",
    );
    return confirm ?? false;
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

        // ------------------- BOTTOM CREATE BUTTON -------------------
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(height: 0.2, color: Colors.grey),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.hinduBase,
                    padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (imagePath == null) {
                        Get.snackbar("Error", "Please upload an image",
                            snackPosition: SnackPosition.BOTTOM);
                        return;
                      }

                      final newDaan = DaanModel(
                        id: '',
                        image: imagePath!,
                        description: titleCtrl.text.trim(),
                        buttonText: buttonLabelCtrl.text.trim(),
                        buttonLink: buttonUrlCtrl.text.trim(),
                       // createdAt: DateTime.now(),
                      );


                      await controller.addDonation(newDaan);

                      await showSuccessDialog(
                        title: "Daan Added Successfully",
                        subtitle: "Your daan entry is ready.",
                      );

                      Get.back();
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

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ---------- Upload Image ----------
                const Text("Upload Image",
                    style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),

                const Text(
                  "Supported formats: JPG, PNG, GIF · Max size: 2 MB · 1 file only",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 12),

                ImageUploadWidget(
                  imagePath: imagePath,
                  placeholderText: "Upload Image",
                  onPicked: (p) => setState(() => imagePath = p),
                ),

                const SizedBox(height: 24),

                // ---------- Title ----------
                const Text("Daan Title *",
                    style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),

                TextFormField(
                  controller: titleCtrl,
                  maxLines: 4,
                  style: const TextStyle(fontSize: 12),
                  validator: (v) => v!.trim().isEmpty ? "Required" : null,
                  decoration: daanFieldDecoration("Write title..."),
                ),

                const SizedBox(height: 24),

                // ---------- Button Label ----------
                const Text("Button Label *",
                    style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),

                TextFormField(
                  controller: buttonLabelCtrl,
                  style: const TextStyle(fontSize: 12),
                  validator: (v) => v!.trim().isEmpty ? "Required" : null,
                  decoration: daanFieldDecoration("Donate Now"),
                ),

                const SizedBox(height: 24),

                // ---------- Button URL ----------
                const Text("Button URL *",
                    style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),

                TextFormField(
                  controller: buttonUrlCtrl,
                  style: const TextStyle(fontSize: 12),
                  validator: (v) => v!.trim().isEmpty ? "Required" : null,
                  decoration: daanFieldDecoration("Where button redirects..."),
                ),

                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
