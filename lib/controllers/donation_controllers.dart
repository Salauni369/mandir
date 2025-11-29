// controllers/daan_controller.dart
import 'package:get/get.dart';
import '../models/donation_model.dart';
import '../screens/dashboard/donation/succes_donation_page.dart';

class DaanController extends GetxController {
  var daanList = <DaanModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchDaanList();
    super.onInit();
  }

  void fetchDaanList() async {
    isLoading(true);
    await Future.delayed(const Duration(seconds: 1)); // Simulate API
    daanList.assignAll(_dummyData());
    isLoading(false);
  }

  void addDaan(DaanModel daan) {
    daan.id = DateTime.now().millisecondsSinceEpoch.toString();
    daanList.add(daan);
    Get.back(); // close add page
    Get.to(() => DaanSuccessPage(isEdit: false));
  }

  void updateDaan(DaanModel updatedDaan) {
    final index = daanList.indexWhere((e) => e.id == updatedDaan.id);
    if (index != -1) daanList[index] = updatedDaan;
    Get.back();
    Get.to(() => DaanSuccessPage(isEdit: true));
  }

  void deleteDaan(String id) {
    daanList.removeWhere((e) => e.id == id);
  }

  List<DaanModel> _dummyData() => [
    DaanModel(
      id: "1",
      imageUrl: "https://res.cloudinary.com/doubxarxb/image/upload/v1763541356/Other/cow_daan.jpg",
      title: "Help ISKCON's Govardhan Eco Village in caring for cows",
      description: "Your donation will help feed and care for cows.",
      buttonLabel: "Donate Now",
      redirectUrl: "https://iskcon.org/donate",
    ),
  ];
}