import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GalleryController extends GetxController {
  var images = <String>[].obs;

  // Multi selection indexes
  var selectedImages = <int>[].obs;

  // Pick and Add Image
  Future<void> pickAndAddImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      images.add(picked.path);
    }
  }

  // Toggle selection
  void selectImage(int index) {
    if (selectedImages.contains(index)) {
      selectedImages.remove(index);
    } else {
      selectedImages.add(index);
    }
  }

  // Delete multiple selected images
  void deleteSelected() {
    if (selectedImages.isEmpty) return;

    // Sort reverse so index shifting doesn't break
    selectedImages.sort((a, b) => b.compareTo(a));

    for (int index in selectedImages) {
      images.removeAt(index);
    }

    selectedImages.clear();
  }

  // Clear selection manually if needed
  void clearSelection() {
    selectedImages.clear();
  }
}
