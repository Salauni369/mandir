// import 'package:get/get.dart';
// import 'package:zamboree_devotion/controllers/add_darshan.dart' hide DarshanController;
// import 'package:zamboree_devotion/controllers/manage_controller.dart';
// import 'package:zamboree_devotion/screens/authentication/login_controller.dart';
//
// import '../controllers/darshan_controller.dart';
// import '../controllers/dashboard_cotroller.dart';
//
// class AppBinding extends Bindings{
//   void dependencies() {
//     // Get.put(RefreshTokenController(), permanent: true);
//     Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
//     Get.lazyPut<DarshanController>(() => DarshanController(), fenix: true);
//     Get.lazyPut<TempleHomeController>(() => TempleHomeController(), fenix: true);
//     Get.lazyPut<AddDarshanController>(() => AddDarshanController(), fenix: true);
//     Get.lazyPut<ManageController>(() => ManageController(), fenix: true);
//
//
// }
// }

import 'package:get/get.dart';

import '../controllers/darshan_controller.dart';
import '../controllers/dashboard_cotroller.dart';
import '../controllers/donation_controllers.dart';
import '../controllers/manage_controller.dart';
import '../screens/authentication/login_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<TempleHomeController>(() => TempleHomeController(), fenix: true);
    Get.lazyPut<DarshanController>(() => DarshanController(), fenix: true);
    Get.lazyPut<ManageController>(() => ManageController(), fenix: true);
    Get.lazyPut<DaanController>(() => DaanController(), fenix: true);
  }
}
