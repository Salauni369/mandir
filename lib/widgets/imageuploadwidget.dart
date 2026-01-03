
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageUploadWidget extends StatelessWidget {
  final String? initialImage;
  final Function(String path) onPicked;
  final Widget? initialImageWidget;
  final bool showInfo;

  const ImageUploadWidget({
    super.key,
    this.initialImage,
    required this.onPicked,
    this.initialImageWidget,
    this.showInfo = true,
  });

  Future<String?> _pickAndCrop(BuildContext context) async {
    final picker = ImagePicker();

    // 1️⃣ Pick image
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return null;

    // 2️⃣ Crop image
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: picked.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(),
          ],
        ),
        WebUiSettings(context: context),
      ],
    );

    if (croppedFile == null) return null;
    return croppedFile.path;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT: IMAGE PREVIEW
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: initialImage == null
                  ? Container(
                width: 108,
                height: 108,
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

            // RIGHT SIDE INFO + CHANGE BUTTON
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

                  InkWell(
                    onTap: () async {
                      final path = await _pickAndCrop(context);
                      if (path != null) onPicked(path);
                    },
                    child: const Text(
                      "Change",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF1E88E5),
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

/// CUSTOM ASPECT RATIO 2x3
class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3); // 2x3

  @override
  String get name => '2x3 (custom)';
}
