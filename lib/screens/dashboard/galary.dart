import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../controllers/manage_controller.dart';
import '../../utils/imageconverter.dart';

class GalleryTab extends StatelessWidget {
  const GalleryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ManageController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER INFO BOX
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

          // UPLOAD BUTTON
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
                    Text(
                      "Upload Image",
                      style: TextStyle(
                        color: Color(0xFFFF7722),
                        fontWeight: FontWeight.w500,
                      ),
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

          // SAVED IMAGES HEADER
          Text(
            "Saved Images",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 12),

          // IMAGES GRID
          Obx(() {
            print("imges data  =>>> ${controller.galleryImages.length}");
            if (controller.galleryImages.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    "No images yet.\nTap 'Upload Image' to add.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: controller.galleryImages.length,
              itemBuilder: (ctx, i) {
                final imagePath = controller.galleryImages[i];
                final isNetwork = imagePath.startsWith('http');

                final optimizedUrl = isNetwork
                    ? ImageConverter.optimizeCloudinaryUrl(imagePath)
                    : imagePath;

                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: isNetwork
                      ? CachedNetworkImage(
                    imageUrl: optimizedUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.broken_image),
                    ),
                  )
                      : Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.error, color: Colors.red),
                    ),
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
