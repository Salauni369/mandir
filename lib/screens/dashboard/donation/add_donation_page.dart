import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import '../../../controllers/add_donation.dart';
import 'confirm_donation_page.dart';

class AddDaanPage extends StatelessWidget {
  final MotionTabBarController controller;
   AddDaanPage({super.key, required this.controller});
  final c = Get.put(AddDaanController());


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (c.hasChanges()) {
          final result = await showDialog(context: context, builder: (_) => const ConfirmLeaveDialog());
          return result ?? false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: const Color(0xFFFF7722), title: const Text("Add Daan", style: TextStyle(color: Colors.white)), foregroundColor: Colors.white),
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
              SizedBox(width: double.infinity, height: 56, child: ElevatedButton(onPressed: c.saveDaan, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF7722), shape: const StadiumBorder()), child: const Text("Save", style: TextStyle(fontSize: 18, color: Colors.white)))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageBox(AddDaanController c) => GestureDetector(
    onTap: c.pickImage,
    child: Container(
      height: 200,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
      child: c.imagePath.value.isEmpty
          ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.cloud_upload, size: 50, color: Colors.grey), Text("Upload Image"), Text("JPG, PNG, GIF • Max size: 2 MB", style: TextStyle(fontSize: 12))]))
          : ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(c.imagePath.value, fit: BoxFit.cover, width: double.infinity)),
    ),
  );

  Widget _field(String label, TextEditingController ctrl, {int maxLines = 1}) => TextField(controller: ctrl, maxLines: maxLines, decoration: InputDecoration(labelText: label, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))));
}