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
      content: 'You\'ve entered some information. If you go back, the changes won\'t be saved.',
    );
    return confirm ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.hinduL1,
        appBar: AppBar(
          backgroundColor: AppColors.hinduBase,
          title: Text('Add Daan', style: TextStyle(color: Colors.white)),
          actions: [
            Switch(value: true, onChanged: (_) {}, activeColor: Colors.white),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // heading box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Color(0xFFFFE8D8), borderRadius: BorderRadius.circular(8)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Upload Image', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    SizedBox(height: 4),
                    Text('Supported formats: JPG, PNG, GIF · Max size: 2 MB · 1 file only', style: TextStyle(fontSize: 12, color: Colors.black54)),
                  ]),
                ),
                const SizedBox(height: 16),

                ImageUploadWidget(
                  imagePath: imagePath,
                  placeholderText: 'Upload Image',
                  onPicked: (p) => setState(() => imagePath = p),
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: titleCtrl,
                  maxLines: 4,
                  validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                  decoration: InputDecoration(labelText: 'Daan Title *', filled: true, fillColor: Colors.white, border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: buttonLabelCtrl,
                  validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                  decoration: InputDecoration(labelText: 'Button Label *', hintText: 'e.g. Donate Now', filled: true, fillColor: Colors.white, border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: buttonUrlCtrl,
                  validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                  decoration: InputDecoration(labelText: 'Button URL *', hintText: 'https://...', filled: true, fillColor: Colors.white, border: OutlineInputBorder()),
                ),
                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.hinduBase, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (imagePath == null) {
                          Get.snackbar('Error', 'Please upload an image', snackPosition: SnackPosition.BOTTOM);
                          return;
                        }
                        final newDaan = DaanModel(
                          id: '',
                          imageUrl: imagePath!,
                          title: titleCtrl.text.trim(),
                          buttonLabel: buttonLabelCtrl.text.trim(),
                          buttonUrl: buttonUrlCtrl.text.trim(),
                          createdAt: DateTime.now(),
                        );
                        await controller.addDaan(newDaan);
                        await showSuccessDialog(title: 'Daan Added Successfully', subtitle: 'Your daan entry is ready.');
                        Get.back(); // back to list
                      }
                    },
                    child: Text('Create', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
