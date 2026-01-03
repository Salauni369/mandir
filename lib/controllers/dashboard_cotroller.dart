import 'package:get/get.dart';
import '../models/dashboard_model.dart';
import '../services/dashboard_services.dart';
import 'darshan_controller.dart';

class TempleHomeController extends GetxController {
  var loading = false.obs;
  var homeData = Rxn<TempleHomeModel>();


  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    print("Dashboard se donation items: ${homeData.value?.donation.length ?? 0}");
    try {
      loading(true);
      final res = await DashboardService.fetchDashboard();
      print("sjhhsn ${res}");
      homeData.value = TempleHomeModel.fromJson(res["data"]);
      // darshan refresh ok
      Get.find<DarshanController>().fetchDarshans();

    } catch (e) {
      print("❌ fetchHomeData error: $e");
    } finally {
      loading(false);
    }
  }



}
