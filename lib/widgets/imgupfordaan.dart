import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadWidget extends StatefulWidget {
  final String? imagePath;
  final String placeholderText;
  final Function(String path) onPicked;

  const ImageUploadWidget({
    super.key,
    required this.imagePath,
    required this.placeholderText,
    required this.onPicked,
  });

  @override
  State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  bool uploading = false;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() => uploading = true);

      await Future.delayed(const Duration(milliseconds: 700)); // fake loading

      setState(() => uploading = false);

      widget.onPicked(picked.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = widget.imagePath != null && widget.imagePath!.isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------------- IMAGE ----------------
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: hasImage
              ? Image(
            image: widget.imagePath!.startsWith("http")
                ? NetworkImage(widget.imagePath!)
                : FileImage(File(widget.imagePath!)) as ImageProvider,
            width: 110,
            height: 110,
            fit: BoxFit.cover,
          )
              : Container(
            width: 110,
            height: 110,
            color: Colors.grey.shade300,
            child: const Icon(Icons.image, size: 40, color: Colors.white),
          ),
        ),

        const SizedBox(width: 14),

        // ---------------- TEXT AREA ----------------
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FILE NAME
              Text(
                widget.placeholderText,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 6),

              // CHANGE IMAGE BUTTON
              GestureDetector(
                onTap: pickImage,
                child: Text(
                  uploading ? "Uploading..." : "Change Image",
                  style: TextStyle(
                    color: uploading ? Colors.grey : Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              // PROGRESS INDICATOR
              if (uploading)
                const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
        )
      ],
    );
  }
}
