import 'package:get/get.dart';

import '../models/donation_model.dart';

class DaanListController extends GetxController {
  var daanList = <DaanModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchDaans();
    super.onInit();
  }

  void fetchDaans() async {
    isLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    daanList.assignAll(dummyData);
    isLoading(false);
  }

  void addDaan(DaanModel daan) {
    daan.id = DateTime.now().millisecondsSinceEpoch.toString();
    daanList.add(daan);
  }

  void updateDaan(DaanModel daan) {
    final index = daanList.indexWhere((e) => e.id == daan.id);
    if (index != -1) daanList[index] = daan;
  }

  void deleteDaan(String id) {
    daanList.removeWhere((e) => e.id == id);
  }

  final List<DaanModel> dummyData = [
    DaanModel(
      id: "1",
      imageUrl: "https://res.cloudinary.com/doubxarxb/image/upload/v1763541356/Other/cow_daan.jpg",
      title: "Help ISKCON's Govardhan Eco Village in caring for cows and other animals",
      description: "Your donation helps feed and care for cows",
      buttonLabel: "Donate Now",
      redirectUrl: "https://iskcon.org",
    ),
  ];
}