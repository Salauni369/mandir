// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
//
// import '../models/dashboard_model.dart';
//
//
// class TempleHomeController extends GetxController {
//   final loading = false.obs;
//   final homeData = Rxn<TempleHomeModel>();
//   final box = GetStorage();
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchHomeData();
//   }
//
//   Future<void> fetchHomeData() async {
//     loading.value = true;
//
//     try {
//       final token = box.read("access_token");
//
//       if (token == null) {
//         Get.snackbar("Error", "Token missing. Login again.");
//         return;
//       }
//
//       final url = Uri.parse("https://api.gamsgroup.in/spiritual/");
//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final body = jsonDecode(response.body);
//         final model = TempleHomeModel.fromJson(body);
//         homeData.value = model;
//       } else {
//         Get.snackbar("Error", "Server Error: ${response.statusCode}");
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       loading.value = false;
//     }
//   }
// }

//
// import 'package:get/get.dart';
// import '../apiservices/auth_services.dart';
// import '../models/dashboard_model.dart';
//
//
// class TempleHomeController extends GetxController {
//   final loading = false.obs;
//   final homeData = Rxn<TempleHomeModel>();
//
//   final ApiService api = ApiService();
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchHomeData();
//   }
//
//   Future<void> fetchHomeData() async {
//     loading.value = true;
//
//     try {
//       final data = await api.fetchHomeData();
//       homeData.value = TempleHomeModel.fromJson(data);
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       loading.value = false;
//     }
//   }
// }




import 'package:get/get.dart';
import '../apiservices/api_services.dart';
import '../models/dashboard_model.dart';
import '../services/dashboard_services.dart';

class TempleHomeController extends GetxController {
  final loading = false.obs;
  final homeData = Rxn<TempleHomeModel>();
  final ApiService api = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    loading.value = true;
    try {
      final data = await api.fetchHomeData();
      homeData.value = TempleHomeModel.fromJson(data);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loading.value = false;
    }
  }
}

