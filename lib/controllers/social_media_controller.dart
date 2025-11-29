import 'package:get/get.dart';

class SocialItem {
  String platform;
  String prefix;
  String username;

  SocialItem(this.platform, this.prefix, this.username);
}

class SocialMediaController extends GetxController {
  var items = <SocialItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    items.assignAll([
      SocialItem("Youtube", "youtube.com/", "@ISKCONVrindavan"),
      SocialItem("Facebook", "facebook.com/", "iskconvrindavan"),
      SocialItem("Instagram", "instagram.com/", "iskcon_vrindavana"),
      SocialItem("LinkedIn", "linkedin.com/in/", "N/A"),
    ]);
  }

  /// 👇 renamed this so no conflict
  void updateUsername(int index, String newUsername) {
    items[index].username = newUsername;
    items.refresh(); // forces UI update
  }
}
