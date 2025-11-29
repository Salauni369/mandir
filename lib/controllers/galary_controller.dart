import 'package:get/get.dart';
class GalleryController extends GetxController {
  var images = <String>[].obs;
  @override void onInit(){ super.onInit(); images.assignAll(List.filled(8,"assets/images/temp.png")); }
  void deleteImage(int i){ images.removeAt(i); }
  void addImage(String path){ images.add(path); }
}
