import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../controllers/galary_controller.dart';

class GalleryTab extends StatelessWidget {
  const GalleryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GalleryController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ---------------- HEADER INFO BOX ----------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1E9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Upload Images\nSupported formats: JPG, PNG, Max size 2MB",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),

          const SizedBox(height: 14),

          // ---------------- UPLOAD BUTTON ----------------
          GestureDetector(
            onTap: controller.pickAndAddImage,
            child: DottedBorder(
              color: const Color(0xFFFF7722),
              strokeWidth: 2,
              dashPattern: const [6, 4],
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                child: const Column(
                  children: [
                    Icon(Icons.cloud_upload, size: 50, color: Color(0xFFFF7722)),
                    SizedBox(height: 12),
                    Text("Upload Image",
                        style: TextStyle(
                            color: Color(0xFFFF7722),
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    Text("Please upload JPG / PNG under 2MB",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ---------------- SAVED IMAGES HEADER + DELETE BUTTON ----------------
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Saved Images",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),

                // Delete Selected Button
                if (controller.selectedImages.isNotEmpty)
                  GestureDetector(
                    onTap: controller.deleteSelected,
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Delete (${controller.selectedImages.length})",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            );
          }),

          const SizedBox(height: 12),

          // ---------------- IMAGES GRID ----------------
          Obx(() {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: controller.images.length,
              itemBuilder: (ctx, i) {
                final isSelected = controller.selectedImages.contains(i);

                return GestureDetector(
                  onTap: () => controller.selectImage(i),
                  onLongPress: () => controller.selectImage(i),

                  child: Stack(
                    children: [
                      // IMAGE
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(controller.images[i]),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),

                      // SELECTION OVERLAY
                      if (isSelected)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black26,
                            border: Border.all(
                                color: Colors.orange, width: 2),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          }),

          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
