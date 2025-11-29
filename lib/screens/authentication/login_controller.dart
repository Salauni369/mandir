import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../apiservices/api_services.dart';
import '../../myRoutes/mypagesname.dart';

class AuthController extends GetxController {
  final AuthService _api = AuthService();
  final box = GetStorage();

  var loading = false.obs;
  var otpSent = false.obs;

  Future<void> sendOtp(String phone) async {
    loading.value = true;

    final res = await _api.sendOtp(phone);
    loading.value = false;

    if (res["success"] == true) {
      otpSent.value = true;
      Get.snackbar("Success", "OTP Sent Successfully");
    } else {
      Get.snackbar("Error", res["message"] ?? "Something went wrong");
    }
  }

  Future<void> verifyOtp(String phone, String otp) async {
    loading.value = true;

    final res = await _api.verifyOtp(phone, otp);
    print("okkk $res");
    loading.value = false;

    if (res["success"] == true) {
      final data = res["data"];

      box.write("access_token", data["access_token"]);
      box.write("refresh_token", data["refresh_token"]);
      box.write("expiresIn", data["expiresIn"]);



      Get.snackbar("Success", "Login Successful");
      Get.offAllNamed(MyPagesName.dashboard);
    } else {
      Get.snackbar("Error", res["message"] ?? "Invalid OTP");
    }
  }
}
