import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../controllers/galary_controller.dart';

class GalleryTab extends StatelessWidget {
  const GalleryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final GalleryController controller = Get.find();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----- HEADER BOX -----
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1E9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Upload Images\nSupported format JPG, GIF, Max size 2MB",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),

          const SizedBox(height: 10),

          // ----- UPLOAD BOX -----
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
                    Icon(Icons.cloud_upload,
                        size: 50, color: Color(0xFFFF7722)),
                    SizedBox(height: 12),
                    Text(
                      "Upload Image",
                      style: TextStyle(
                          color: Color(0xFFFF7722),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Please upload JPG / PNG under 2MB",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ----- UPLOADING LIST -----
          Obx(
                () => Column(
              children: controller.uploadingList.map((item) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          item.file,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Name + Progress bar
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.file.path.split('/').last,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            LinearProgressIndicator(
                              value: item.progress / 100,
                              color: Colors.orange,
                              backgroundColor: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${item.progress}%",
                              style: const TextStyle(
                                  fontSize: 11, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 10),

          // ----- SAVED IMAGES TITLE -----
          const Text(
            "Saved Images",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const Text(
            "Images can be updated anytime",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 16),

          // ----- SAVED IMAGES GRID -----
          Obx(
                () => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: controller.images.length,
              itemBuilder: (ctx, i) {
                bool isSelected = controller.selectedIndex.value == i;

                return GestureDetector(
                  onLongPress: () => controller.selectImage(i),
                  onTap: () => controller.clearSelection(),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: controller.images[i].startsWith("assets")
                            ? Image.asset(
                          controller.images[i],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                            : Image.file(
                          File(controller.images[i]),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),

                      // DELETE ICON ONLY ON SELECTION
                      if (isSelected)
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => controller.deleteImage(i),
                            child: const Icon(Icons.delete,
                                color: Colors.red, size: 26),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

