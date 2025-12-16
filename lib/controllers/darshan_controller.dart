


import 'package:get/get.dart';
import '../models/live_darshan_model.dart';
import '../services/livedarshan.dart';
import 'dashboard_cotroller.dart';

class DarshanController extends GetxController {
  // UI expects these
  final isLoading = false.obs;

  final liveDarshans = <DarshanModel>[].obs;
  final pastDarshans = <DarshanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
   // fetchDarshans();
  }

  // -----------------------------
  // FETCH DARSHANS (FROM DASHBOARD)
  // -----------------------------
  // Future<void> fetchDarshans() async {
  //   try {
  //     isLoading(true);
  //
  //     final home = Get.find<TempleHomeController>().homeData.value;
  //     if (home == null) return;
  //
  //     final all = home.liveDarshan;
  //
  //     liveDarshans.value =
  //         all.where((e) => e.isLive == true).toList();
  //
  //     pastDarshans.value =
  //         all.where((e) => e.isLive == false).toList();
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  Future<void> fetchDarshans() async {
    print("🔥 fetchDarshans CALLED");

    try {
      isLoading(true);

      final home = Get.find<TempleHomeController>().homeData.value;

      if (home == null) {
        print("❌ homeData is NULL");
        return;
      }

      print("✅ homeData FOUND");
      print("👉 total liveDarshan from API = ${home.liveDarshan.length}");

      for (var d in home.liveDarshan) {
        print(
            "ID=${d.id} | title=${d.title} | isLive=${d.isLive}"
        );
      }

      liveDarshans.value =
          home.liveDarshan.where((e) => e.isLive == true).toList();

      pastDarshans.value =
          home.liveDarshan.where((e) => e.isLive == false).toList();

      print("🟢 LIVE COUNT = ${liveDarshans.length}");
      print("🔵 PAST COUNT = ${pastDarshans.length}");
    } finally {
      isLoading(false);
    }
  }


  // -----------------------------
  // ADD DARSHAN
  // -----------------------------
  // Future<bool> addDarshan({
  //   required String title,
  //   required String embeddedLink,
  //   required String mobileImage,
  // }) async {
  //   try {
  //     isLoading(true);
  //
  //     final res = await DarshanService.createDarshan({
  //       "title": title,
  //       "embeddedLink": embeddedLink,
  //       "mobile_image": mobileImage,
  //     });
  //
  //     if (res["success"] == true) {
  //       await Get.find<TempleHomeController>().fetchHomeData();
  //       await fetchDarshans();
  //       return true;
  //     }
  //     return false;
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  // Future<bool> addDarshan({
  //   required String title,
  //   required String embeddedLink,
  //   required String mobileImageUrl,
  // }) async {
  //   final res = await DarshanService.createDarshan({
  //     "title": title,
  //     "embeddedLink": embeddedLink,
  //     "mobile_image": mobileImageUrl,
  //
  //     // 🔥 FORCE ACTIVE
  //     "status": "ACTIVE",
  //   });
  //
  //   if (res["success"] == true) {
  //     await Get.find<TempleHomeController>().fetchHomeData();
  //     return true;
  //   }
  //   return false;
  // }
  Future<bool> addDarshan({
    required String title,
    required String embeddedLink,
    required String mobile_image,
  }) async {

    print("🚀 ADD DARSHAN MULTIPART START");

    final res = await DarshanService.createDarshanMultipart(
      title: title,
      embeddedLink: embeddedLink,
      imagePath: mobile_image,
      status: "ACTIVE",
    );

    print("📥 API RESPONSE => $res");

    if (res["success"] == true) {
      await Get.find<TempleHomeController>().fetchHomeData();
      return true;
    }

    return false;
  }




  // -----------------------------
  // UPDATE DARSHAN
  // -----------------------------
  // Future<bool> updateDarshan(DarshanModel darshan) async {
  //   try {
  //     isLoading(true);
  //
  //     final res = await DarshanService.updateDarshan(
  //       darshan.id,
  //       {
  //         "title": darshan.title,
  //         "embeddedLink": darshan.liveLink,
  //         "mobile_image": darshan.mobile_image,
  //         "status": darshan.isLive ? "ACTIVE" : "INACTIVE",
  //       },
  //     );
  //
  //     if (res["success"] == true) {
  //       await Get.find<TempleHomeController>().fetchHomeData();
  //       await fetchDarshans();
  //       return true;
  //     }
  //     return false;
  //   } finally {
  //     isLoading(false);
  //   }
  }


