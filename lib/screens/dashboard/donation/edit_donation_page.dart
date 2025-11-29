import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/edit_donation.dart';
import 'confirm_donation_page.dart';


class EditDaanPage extends StatelessWidget {
  EditDaanPage({super.key});
  final c = Get.put(EditDaanController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final result = await showDialog(context: context, builder: (_) => const ConfirmLeaveDialog());
        return result ?? false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFFF7722),
          title: const Text("Edit Daan", style: TextStyle(color: Colors.white)),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                Get.defaultDialog(
                  title: "Delete Daan?",
                  middleText: "This action cannot be undone.",
                  textConfirm: "Delete",
                  confirmTextColor: Colors.white,
                  buttonColor: Colors.red,
                  onConfirm: () {
                    c.deleteDaan();
                    Get.back();
                  },
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Obx(() => _imageBox(c)),
              const SizedBox(height: 24),
              _field("Daan Description *", c.descCtrl, maxLines: 4),
              const SizedBox(height: 16),
              _field("Button Label *", c.buttonLabelCtrl),
              const SizedBox(height: 16),
              _field("Button URL *", c.urlCtrl),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF7722), shape: const StadiumBorder()),
                  onPressed: c.updateDaan,
                  child: const Text("Update", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageBox(EditDaanController c) => GestureDetector(
    onTap: () => c.pickImage(), // same pickImage function from add controller (you can reuse)
    child: Container(
      height: 200,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(c.imagePath.value, fit: BoxFit.cover, width: double.infinity),
      ),
    ),
  );

  Widget _field(String label, TextEditingController ctrl, {int maxLines = 1}) => TextField(
    controller: ctrl,
    maxLines: maxLines,
    decoration: InputDecoration(labelText: label, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
  );
}