import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image/image.dart' as img;

import '../../controllers/manage_controller.dart';
import '../../utils/imageconverter.dart';
import 'galaryviewer.dart';

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
          // 🔥 HEADER INFO BOX
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1E9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Upload Images\nSupported formats: JPG, PNG, Max size 2MB\nLong press on image to select for deletion",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),

          const SizedBox(height: 14),

          // 🔥 UPLOAD BUTTON
          GestureDetector(
            onTap: controller.pickMultipleImages,
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
                      "Upload Images",
                      style: TextStyle(
                        color: Color(0xFFFF7722),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Select multiple images (JPG / PNG under 2MB each)",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // 🔥 SAVED IMAGES HEADER WITH DELETE BUTTON
          Obx(() {
            final isSelecting = controller.isSelectionMode.value;
            final selectedCount = controller.selectedImages.length;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // LEFT SIDE
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Saved Images",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isSelecting
                          ? "$selectedCount selected"
                          : "${controller.galleryImages.length} images",
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelecting ? Colors.deepOrange : Colors.grey.shade600,
                        fontWeight: isSelecting ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),

                // RIGHT SIDE - ACTION BUTTONS
                if (isSelecting)
                  Row(
                    children: [
                      // CANCEL BUTTON
                      TextButton.icon(
                        onPressed: controller.cancelSelection,
                        icon: const Icon(Icons.close, size: 18),
                        label: const Text("Cancel"),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey.shade700,
                        ),
                      ),

                      const SizedBox(width: 8),

                      // 🔥 DELETE ICON WITH BADGE
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: selectedCount > 0
                                  ? Colors.red.shade600
                                  : Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: selectedCount > 0
                                  ? () => _showDeleteDialog(context, controller)
                                  : null,
                              icon: const Icon(
                                Icons.delete_outline,
                                size: 22,
                                color: Colors.white,
                              ),
                              tooltip: "Delete selected",
                            ),
                          ),
                          if (selectedCount > 0)
                            Positioned(
                              right: -2,
                              top: -2,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade700,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 20,
                                  minHeight: 20,
                                ),
                                child: Text(
                                  '$selectedCount',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
              ],
            );
          }),

          const SizedBox(height: 12),

          // 🔥 IMAGES GRID WITH PROPER SELECTION
          Obx(() {
            print("Gallery images count =>>> ${controller.galleryImages.length}");

            if (controller.galleryImages.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    "No images yet.\nTap 'Upload Images' to add.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.galleryImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              itemBuilder: (context, index) {
                final imagePath = controller.galleryImages[index];

                if (imagePath.isEmpty) {
                  return _brokenImage();
                }

                final isNetwork = imagePath.startsWith('http');
                final displayPath = isNetwork
                    ? ImageConverter.optimizeCloudinaryUrl(imagePath)
                    : imagePath;

                final isSelected = controller.selectedImages.contains(index);
                final isSelectionMode = controller.isSelectionMode.value;

                return GestureDetector(
                  // 🔥 TAP - View or Select
                  onTap: () {
                    if (isSelectionMode) {
                      controller.toggleImageSelection(index);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GalleryViewerPage(
                            images: controller.galleryImages,
                            initialIndex: index,
                          ),
                        ),
                      );
                    }
                  },

                  // 🔥 LONG PRESS - Start Selection
                  onLongPress: () {
                    if (!isSelectionMode) {
                      controller.startSelection(index);

                      // Haptic feedback
                      // HapticFeedback.mediumImpact(); // Uncomment agar haptic chahiye
                    }
                  },

                  child: Stack(
                    children: [
                      // 🔥 IMAGE WITH BORDER
                      Container(
                        decoration: BoxDecoration(
                          border: isSelected
                              ? Border.all(
                            color: Colors.deepOrange,
                            width: 4,
                          )
                              : null,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(isSelected ? 8 : 12),
                          child: isNetwork
                              ? CachedNetworkImage(
                            imageUrl: displayPath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: (_, __) => Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                            errorWidget: (_, __, ___) => _brokenImage(),
                          )
                              : _safeLocalImage(displayPath),
                        ),
                      ),

                      // 🔥 DARK OVERLAY (WHEN IN SELECTION MODE)
                      if (isSelectionMode && !isSelected)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                      // 🔥 SELECTED OVERLAY (ORANGE TINT)
                      if (isSelected)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),

                      // 🔥 CHECKMARK CIRCLE (TOP RIGHT)
                      if (isSelectionMode)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.deepOrange
                                  : Colors.white.withOpacity(0.8),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.deepOrange
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: isSelected
                                ? const Icon(
                              Icons.check,
                              size: 18,
                              color: Colors.white,
                            )
                                : null,
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          }),

          const SizedBox(height: 20),

          // 🔥 SAVE GALLERY BUTTON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: Obx(() => ElevatedButton(
                onPressed: controller.isSaving.value
                    ? null
                    : controller.saveGallery,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: controller.isSaving.value
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Uploading...",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
                    : const Text(
                  "Save Gallery",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
            ),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }

  // 🔥 DELETE CONFIRMATION DIALOG
  void _showDeleteDialog(BuildContext context, ManageController controller) {
    final count = controller.selectedImages.length;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: const [
            Icon(Icons.delete_forever, color: Colors.red, size: 28),
            SizedBox(width: 8),
            Text("Delete Images?", style: TextStyle(fontSize: 18)),
          ],
        ),
        content: Text(
          "$count image${count > 1 ? 's' : ''} will be removed from the gallery.\nYou'll need to save changes to confirm.",
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deleteSelectedImages();
              Navigator.pop(ctx);

              Get.snackbar(
                "Deleted",
                "$count image${count > 1 ? 's' : ''} removed. Don't forget to save changes!",
                backgroundColor: Colors.orange.shade600,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 2),
                icon: const Icon(Icons.info_outline, color: Colors.white),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // 🔥 SAFE LOCAL IMAGE
  Widget _safeLocalImage(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      return _brokenImage();
    }

    try {
      final bytes = file.readAsBytesSync();
      final decoded = img.decodeImage(bytes);

      if (decoded == null) {
        return _brokenImage();
      }

      return Image.memory(
        Uint8List.fromList(img.encodeJpg(decoded, quality: 90)),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => _brokenImage(),
      );
    } catch (e) {
      print("Failed to decode local gallery image: $e");
      return _brokenImage();
    }
  }

  Widget _brokenImage() {
    return Container(
      color: Colors.grey.shade200,
      child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
    );
  }
}