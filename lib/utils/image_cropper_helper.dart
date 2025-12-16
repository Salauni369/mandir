import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageCropperHelper {
  static Future<CroppedFile?> pickAndCropImage( XFile? picked) async {


    if (picked == null) return null;

    final cropped = await ImageCropper().cropImage(
      sourcePath: picked.path,
      compressQuality: 80,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Crop Image",
          toolbarColor: const Color(0xFF1E88E5),
          statusBarColor: const Color(0xFF1E88E5),
          backgroundColor: Colors.black,
          activeControlsWidgetColor: Colors.blue,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: "Crop Image",
        ),
      ],
    );

    return cropped;
  }
}
