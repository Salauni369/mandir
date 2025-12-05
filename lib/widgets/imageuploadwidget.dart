// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ImageUploadWidget extends StatelessWidget {
//   final String? initialImage;
//   final String title;
//   final Function(String path) onPicked;
//
//   ImageUploadWidget({
//     required this.title,
//     this.initialImage,
//     required this.onPicked,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: TextStyle(fontWeight: FontWeight.w700)),
//         SizedBox(height: 8),
//
//         GestureDetector(
//           onTap: () async {
//             final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//             if (picked != null) {
//               onPicked(picked.path);
//             }
//           },
//           child: Container(
//             height: 140,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: initialImage == null
//                 ? Center(child: Text("Upload Image"))
//                 : initialImage!.startsWith("http")
//                 ? Image.network(initialImage!, fit: BoxFit.cover)
//                 : Image.file(File(initialImage!), fit: BoxFit.cover),
//           ),
//         ),
//       ],
//     );
//   }
// }


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ImageUploadWidget extends StatelessWidget {
//   final String? initialImage;
//   final String title;
//   final Function(String path) onPicked;
//
//   ImageUploadWidget({
//     required this.title,
//     this.initialImage,
//     required this.onPicked,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Title
//         Text(title, style: TextStyle(fontWeight: FontWeight.w700)),
//         SizedBox(height: 4),
//
//         // 🔥 Supported formats text just under title
//         Text(
//           "Supported formats: JPG, PNG",
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         SizedBox(height: 8),
//
//         // Image upload box
//         GestureDetector(
//           onTap: () async {
//             final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//             if (picked != null) {
//               onPicked(picked.path);
//             }
//           },
//           child: Container(
//             height: 140,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: initialImage == null
//                 ? Center(child: Text("Upload Image"))
//                 : initialImage!.startsWith("http")
//                 ? Image.network(initialImage!, fit: BoxFit.cover)
//                 : Image.file(File(initialImage!), fit: BoxFit.cover),
//           ),
//         ),
//       ],
//     );
//   }
// }

// lib/widgets/imageuploadwidget.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadWidget extends StatelessWidget {
  final String? initialImage;
 // final String title;
  final Function(String path) onPicked;
  final bool showInfo;

  const ImageUploadWidget({
    super.key,
   // required this.title,
    this.initialImage,
    required this.onPicked,
    this.showInfo = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Title: "Web Image" / "Mobile Image"
        // Text(
        //  // title,
        //   style: const TextStyle(
        //     fontSize: 14,
        //     fontWeight: FontWeight.w600,
        //     color: Colors.black87,
        //   ),
        // ),

        const SizedBox(height: 10),

        /// ROW = IMAGE + (FILENAME + CHANGE BUTTON)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE (80x80)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: initialImage == null
                  ? Container(
                width: 80,
                height: 80,
                color: Colors.grey.shade300,
                child: const Icon(Icons.image, size: 32),
              )
                  : initialImage!.startsWith("http")
                  ? Image.network(
                initialImage!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              )
                  : Image.file(
                File(initialImage!),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 14),

            /// FILENAME + CHANGE LINK
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// FILE NAME (same as figma)
                  Text(
                    initialImage != null
                        ? initialImage!.split("/").last
                        : "No file selected",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// CHANGE LINK (blue)
                  InkWell(
                    onTap: () async {
                      final picked = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );
                      if (picked != null) onPicked(picked.path);
                    },
                    child: Text(
                      "Change ",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF1E88E5), // perfect figma blue
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}


