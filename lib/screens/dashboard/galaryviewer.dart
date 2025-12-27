// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:image/image.dart' as img; // for safe local decode
//
// import '../../utils/imageconverter.dart';
// import '../../widgets/app_colors.dart'; // <-- Tera ImageConverter import
//
// class GalleryViewerPage extends StatefulWidget {
//   final List<String> images;
//   final int initialIndex;
//
//   const GalleryViewerPage({
//     super.key,
//     required this.images,
//     required this.initialIndex,
//   });
//
//   @override
//   State<GalleryViewerPage> createState() => _GalleryViewerPageState();
// }
//
// class _GalleryViewerPageState extends State<GalleryViewerPage> {
//   late PageController _pageController;
//   late int currentIndex;
//
//   @override
//   void initState() {
//     super.initState();
//     currentIndex = widget.initialIndex;
//     _pageController = PageController(initialPage: currentIndex);
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: AppColors.hinduBase,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: Text(
//           "${currentIndex + 1} / ${widget.images.length}",
//           style: const TextStyle(color: Colors.white),
//         ),
//       ),
//       body: PageView.builder(
//         controller: _pageController,
//         itemCount: widget.images.length,
//         onPageChanged: (index) {
//           setState(() => currentIndex = index);
//         },
//         itemBuilder: (context, index) {
//           final imagePath = widget.images[index];
//           final isNetwork = imagePath.startsWith('http');
//
//           Widget imageWidget;
//
//           if (isNetwork) {
//             // 🔥 Tere ImageConverter ka use – Cloudinary URL optimize
//             final optimizedUrl = ImageConverter.optimizeCloudinaryUrl(imagePath);
//             imageWidget = CachedNetworkImage(
//               imageUrl: optimizedUrl,
//               fit: BoxFit.contain,
//               placeholder: (context, url) => const Center(
//                 child: CircularProgressIndicator(color: Colors.white),
//               ),
//               errorWidget: (context, url, error) => const Icon(
//                 Icons.broken_image,
//                 color: Colors.white,
//                 size: 80,
//               ),
//             );
//           } else {
//             // Local image – safe decode with package:image
//             imageWidget = _safeLocalImage(imagePath);
//           }
//
//           return InteractiveViewer(
//             panEnabled: true,
//             boundaryMargin: const EdgeInsets.all(20),
//             minScale: 0.5,
//             maxScale: 4,
//             child: Center(child: imageWidget),
//           );
//         },
//       ),
//     );
//   }
//
//   // 🔥 Safe local image – koi bhi format (AVIF, WEBP, HEIC) handle karega
//   Widget _safeLocalImage(String path) {
//     final file = File(path);
//     if (!file.existsSync()) {
//       return const Icon(Icons.broken_image, color: Colors.white, size: 80);
//     }
//
//     try {
//       final bytes = file.readAsBytesSync();
//       final decoded = img.decodeImage(bytes);
//       if (decoded == null) {
//         return const Icon(Icons.broken_image, color: Colors.white, size: 80);
//       }
//
//       return Image.memory(
//         Uint8List.fromList(img.encodeJpg(decoded, quality: 95)),
//         fit: BoxFit.contain,
//       );
//     } catch (e) {
//       print("Failed to decode local image in viewer: $e");
//       return const Icon(Icons.broken_image, color: Colors.white, size: 80);
//     }
//   }
// }

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image/image.dart' as img;

import '../../controllers/manage_controller.dart';
import '../../utils/imageconverter.dart';
import '../../widgets/app_colors.dart';

class GalleryViewerPage extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const GalleryViewerPage({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<GalleryViewerPage> createState() => _GalleryViewerPageState();
}

class _GalleryViewerPageState extends State<GalleryViewerPage> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ManageController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.hinduBase,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "${currentIndex + 1} / ${widget.images.length}",
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          // 🔥 DELETE BUTTON IN APPBAR
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white),
            onPressed: () {
              _showDeleteDialog(context, controller, currentIndex);
            },
            tooltip: "Delete this image",
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        onPageChanged: (index) {
          setState(() => currentIndex = index);
        },
        itemBuilder: (context, index) {
          final imagePath = widget.images[index];
          final isNetwork = imagePath.startsWith('http');

          Widget imageWidget;

          if (isNetwork) {
            final optimizedUrl = ImageConverter.optimizeCloudinaryUrl(
              imagePath,
            );
            imageWidget = CachedNetworkImage(
              imageUrl: optimizedUrl,
              fit: BoxFit.contain,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.broken_image, color: Colors.white, size: 80),
            );
          } else {
            imageWidget = _safeLocalImage(imagePath);
          }

          return InteractiveViewer(
            panEnabled: true,
            boundaryMargin: const EdgeInsets.all(20),
            minScale: 0.5,
            maxScale: 4,
            child: Center(child: imageWidget),
          );
        },
      ),
    );
  }

  // 🔥 DELETE DIALOG (SINGLE IMAGE FROM VIEWER)
  void _showDeleteDialog(
    BuildContext context,
    ManageController controller,
    int index,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: const [
            Icon(Icons.delete_forever, color: Colors.red, size: 28),
            SizedBox(width: 8),
            Text("Delete Image?", style: TextStyle(fontSize: 18)),
          ],
        ),
        content: const Text(
          "This image will be removed from the gallery.\nYou'll need to save changes to confirm.",
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              controller.removeImage(index);
              Navigator.pop(ctx);

              // 🔥 Close viewer if this was the last image
              if (controller.galleryImages.isEmpty) {
                Navigator.pop(context);
              } else {
                // 🔥 Adjust page if we deleted the last image
                if (index >= controller.galleryImages.length &&
                    _pageController.hasClients) {
                  _pageController.jumpToPage(
                    controller.galleryImages.length - 1,
                  );
                }
              }

              Get.snackbar(
                "Deleted",
                "Image removed. Don't forget to save changes!",
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
      return const Icon(Icons.broken_image, color: Colors.white, size: 80);
    }

    try {
      final bytes = file.readAsBytesSync();
      final decoded = img.decodeImage(bytes);
      if (decoded == null) {
        return const Icon(Icons.broken_image, color: Colors.white, size: 80);
      }

      return Image.memory(
        Uint8List.fromList(img.encodeJpg(decoded, quality: 95)),
        fit: BoxFit.contain,
      );
    } catch (e) {
      print("Failed to decode local image in viewer: $e");
      return const Icon(Icons.broken_image, color: Colors.white, size: 80);
    }
  }
}
