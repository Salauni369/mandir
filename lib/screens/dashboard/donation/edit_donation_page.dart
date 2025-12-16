import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/donation_controllers.dart';
import '../../../models/donation_model.dart';
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

  String? imagePath;

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(text: widget.daan.description);
    buttonLabelCtrl = TextEditingController(text: widget.daan.buttonText);
    buttonUrlCtrl = TextEditingController(text: widget.daan.buttonLink);
    imagePath = widget.daan.image;
  }

  Future<void> _updateDaan() async {
    if (!formKey.currentState!.validate()) return;

    final updated = widget.daan.copyWith(
      description: titleCtrl.text.trim(),
      buttonText: buttonLabelCtrl.text.trim(),
      buttonLink: buttonUrlCtrl.text.trim(),
      image: imagePath,
    );

    await controller.updateDonation(updated);

    await showSuccessDialog(
      title: "Daan Updated Successfully",
      subtitle: "Your daan entry has been updated.",
    );

    Get.back();
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
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: AppColors.hinduBase,
        title: const Text("Edit Daan", style: TextStyle(color: Colors.white)

        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),

      // ---------------- UPDATE BUTTON + DIVIDER FIXED ----------------
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 0.1, color: Colors.grey), // thinner divider
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.hinduBase,
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8), // thinner button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: _updateDaan,
                child: const Text(
                  "Update",
                  style: TextStyle(color: Colors.white, fontSize: 16),
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
              // ------------------ UPLOAD IMAGE ------------------
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
                placeholderText: "uploaded_image_compressed.jpg",
                onPicked: (p) => setState(() => imagePath = p),
              ),

              const SizedBox(height: 24),

              // ------------------ DAAN TITLE ------------------
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

              // ------------------ BUTTON LABEL ------------------
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

              // ------------------ BUTTON URL ------------------
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
    );
  }
}
