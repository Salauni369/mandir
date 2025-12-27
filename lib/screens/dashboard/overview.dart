import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_cotroller.dart';
import '../../controllers/manage_controller.dart';
import '../../utils/imageconverter.dart';

class OverviewTab extends StatefulWidget {
  const OverviewTab({super.key});

  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  late final ManageController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ManageController>();

    final homeCtrl = Get.find<TempleHomeController>();
    if (homeCtrl.homeData.value != null) {
      controller.fillFromApi(homeCtrl.homeData.value!);
    }
  }

  void _addNewSection() {
    controller.additionalSections.add(AdditionalSection());
  }

  void _removeSection(int index) {
    if (controller.additionalSections.length > 1) {
      controller.additionalSections.removeAt(index);
    } else {
      Get.snackbar("Info", "At least one section is required");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Obx(() {
                    return Container(
                      height: 220,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          // image: controller.mainImage.value.isEmpty
                          //     ? const AssetImage("assets/images/temp.png")
                          //     : controller.mainImage.value.startsWith("http")
                          //     ? NetworkImage(controller.mainImage.value)
                          //     : FileImage(File(controller.mainImage.value))
                          // as ImageProvider,

                          image: controller.mainImage.value.isEmpty
                              ? const AssetImage("assets/images/temp.png")
                              : controller.mainImage.value.startsWith("http")
                              ? NetworkImage(
                            ImageConverter.optimizeCloudinaryUrl(
                              controller.mainImage.value,
                            ),
                          )
                              : FileImage(File(controller.mainImage.value))
                          as ImageProvider,

                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => controller.pickMainImage(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text("Name *",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            TextField(
              controller: controller.nameCtrl,
              style: const TextStyle(fontSize: 12, color: Colors.black),
              decoration: _inputDecoration("ISKCON Temple Vrindavan"),
            ),

            const SizedBox(height: 20),

            const Text("About us *",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            TextField(
              controller: controller.aboutCtrl,
              maxLines: 6,
              style: const TextStyle(fontSize: 12, color: Colors.black),
              decoration: _inputDecoration("Write about your temple..."),
            ),

            const SizedBox(height: 20),

            const Text("Contact Number *",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            TextField(
              controller: controller.contactCtrl,
              enabled: false,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
              decoration: _inputDecoration("+91 9853228287",
                  fill: Colors.grey.shade100),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Additional Sections",
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: _addNewSection,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.add,
                        color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// 🔥 IMPORTANT FIX — OBSERVE CONTROLLER LIST
            Obx(() => Column(
              children: List.generate(
                controller.additionalSections.length,
                    (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildAdditionalSection(
                    index: index,
                    section: controller.additionalSections[index],
                    onRemove: () => _removeSection(index),
                  ),
                ),
              ),
            )),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalSection({
    required int index,
    required AdditionalSection section,
    required VoidCallback onRemove,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Section ${index + 1}",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600)),
              if (controller.additionalSections.length > 1)
                GestureDetector(
                  onTap: onRemove,
                  child: Icon(Icons.delete_outline,
                      color: Colors.red.shade400, size: 20),
                ),
            ],
          ),
          const SizedBox(height: 12),
          const Text("Title *",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: section.titleCtrl,
            style:  TextStyle(
              fontSize: 12,
            ),
            decoration: _inputDecoration("Enter section title"),
          ),
          const SizedBox(height: 12),
          const Text("Content *",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: section.contentCtrl,
            style:  TextStyle(
              fontSize: 12,
            ),
            maxLines: 6,
            decoration: _inputDecoration("Enter section content"),
          ),
        ],
      ),
    );
  }
}

/// ---------------- HELPER ----------------
InputDecoration _inputDecoration(String hint,
    {Color fill = Colors.white}) {
  return InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: fill,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Colors.grey.shade600, width: 1.2),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
}

/// ---------------- SECTION MODEL ----------------
class AdditionalSection {
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController contentCtrl = TextEditingController();

  void dispose() {
    titleCtrl.dispose();
    contentCtrl.dispose();
  }
}
