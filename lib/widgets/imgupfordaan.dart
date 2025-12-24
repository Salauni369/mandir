// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ImageUploadWidget extends StatefulWidget {
//   final String? imagePath;
//   final String placeholderText;
//   final Function(String path) onPicked;
//
//   const ImageUploadWidget({
//     super.key,
//     required this.imagePath,
//     required this.placeholderText,
//     required this.onPicked,
//   });
//
//   @override
//   State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
// }
//
// class _ImageUploadWidgetState extends State<ImageUploadWidget> {
//   bool uploading = false;
//
//   Future<void> pickImage() async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//
//     if (picked != null) {
//       setState(() => uploading = true);
//
//       await Future.delayed(const Duration(milliseconds: 700)); // fake loading
//
//       setState(() => uploading = false);
//
//       widget.onPicked(picked.path);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final hasImage = widget.imagePath != null && widget.imagePath!.isNotEmpty;
//
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // ---------------- IMAGE ----------------
//         ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: hasImage
//               ? Image(
//             image: widget.imagePath!.startsWith("http")
//                 ? NetworkImage(widget.imagePath!)
//                 : FileImage(File(widget.imagePath!)) as ImageProvider,
//             width: 110,
//             height: 110,
//             fit: BoxFit.cover,
//           )
//               : Container(
//             width: 110,
//             height: 110,
//             color: Colors.grey.shade300,
//             child: const Icon(Icons.image, size: 40, color: Colors.white),
//           ),
//         ),
//
//         const SizedBox(width: 14),
//
//         // ---------------- TEXT AREA ----------------
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // FILE NAME
//               Text(
//                 widget.placeholderText,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
//               ),
//
//               const SizedBox(height: 6),
//
//               // CHANGE IMAGE BUTTON
//               GestureDetector(
//                 onTap: pickImage,
//                 child: Text(
//                   uploading ? "Uploading..." : "Change Image",
//                   style: TextStyle(
//                     color: uploading ? Colors.grey : Colors.blue,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 6),
//
//               // PROGRESS INDICATOR
//               if (uploading)
//                 const SizedBox(
//                   height: 18,
//                   width: 18,
//                   child: CircularProgressIndicator(strokeWidth: 2),
//                 ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }


import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadWidget extends StatelessWidget {
  final String? imagePath; // Can be URL or local path
  final String placeholderText;
  final Function(String?) onPicked;

  const ImageUploadWidget({
    Key? key,
    required this.imagePath,
    required this.placeholderText,
    required this.onPicked,
  }) : super(key: key);

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        // Return local path - parent will handle upload
        onPicked(image.path);
      }
    } catch (e) {
      print("❌ Image picker error: $e");
    }
  }

  bool _isNetworkImage(String? path) {
    if (path == null) return false;
    return path.startsWith('http://') || path.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: DottedBorder(
        color: const Color(0xFFFF7722),
        strokeWidth: 2,
        dashPattern: const [6, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        child: Container(
          width: double.infinity,
          height: 220,
          padding: imagePath == null ? const EdgeInsets.all(24) : EdgeInsets.zero,
          child: imagePath == null
              ? _buildPlaceholder()
              : _buildImagePreview(),
        ),
      ),
    );
  }

  // ✅ Placeholder when no image
  Widget _buildPlaceholder() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.cloud_upload,
          size: 50,
          color: Color(0xFFFF7722),
        ),
        SizedBox(height: 12),
        Text(
          "Upload Image",
          style: TextStyle(
            color: Color(0xFFFF7722),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Please upload JPG / PNG under 2MB",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // ✅ Image preview (Network or Local)
  Widget _buildImagePreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          // Image display
          _isNetworkImage(imagePath)
              ? Image.network(
            imagePath!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 40),
                    SizedBox(height: 8),
                    Text(
                      "Failed to load image",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              );
            },
          )
              : Image.file(
            File(imagePath!),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 40),
                    SizedBox(height: 8),
                    Text(
                      "Failed to load image",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              );
            },
          ),

          // ✅ Edit overlay button
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit, color: Colors.white, size: 16),
                  SizedBox(width: 6),
                  Text(
                    "Change",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
