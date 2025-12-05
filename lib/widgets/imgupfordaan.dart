import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadWidget extends StatelessWidget {
  final String? imagePath;
  final String placeholderText;
  final ValueChanged<String> onPicked;

  const ImageUploadWidget({
    Key? key,
    this.imagePath,
    this.placeholderText = 'Upload Image',
    required this.onPicked,
  }) : super(key: key);

  Future<void> _pickImage(BuildContext context) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) onPicked(picked.path);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickImage(context),
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white,
        ),
        child: imagePath == null
            ? Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_upload_outlined, color: Colors.grey.shade600, size: 32),
              const SizedBox(height: 8),
              Text(placeholderText, style: TextStyle(color: Colors.black54)),
            ],
          ),
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: imagePath!.startsWith('http')
              ? Image.network(imagePath!, fit: BoxFit.cover)
              : Image.file(File(imagePath!), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
