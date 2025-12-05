// import 'dart:ui';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import '../../apiservices/api_services.dart';
// import '../../myRoutes/mypagesname.dart';
//
// class AuthController extends GetxController {
//   final AuthService _api = AuthService();
//   final box = GetStorage();
//
//   var loading = false.obs;
//   var otpSent = false.obs;
//
//   // 🔥 SEND OTP
//   Future<void> sendOtp(String phone) async {
//     loading.value = true;
//
//     final res = await _api.sendOtp(phone);
//     loading.value = false;
//
//     print("SEND OTP RESPONSE: $res");
//
//     if (res["success"] == true) {
//       otpSent.value = true;
//
//       Get.snackbar(
//         "Success",
//         "OTP Sent Successfully",
//         backgroundColor: const Color(0xFF4ADE80),
//         colorText: const Color(0xFFF0FFF3),
//       );
//     } else {
//       Get.snackbar(
//         "Error",
//         res["message"] ?? "Something went wrong",
//         backgroundColor: const Color(0xFFE84545),
//         colorText: const Color(0xFFFFFFFF),
//       );
//     }
//   }
//
//   // 🔥 VERIFY OTP
//   Future<void> verifyOtp(String phone, String otp) async {
//     loading.value = true;
//
//     final res = await _api.verifyOtp(phone, otp);
//     loading.value = false;
//
//     print("VERIFY OTP RESPONSE: $res");
//
//     if (res["success"] == true) {
//       final data = res["data"];
//
//       // Save tokens
//       box.write("access_token", data["access_token"]);
//       box.write("refresh_token", data["refresh_token"]);
//       box.write("expiresIn", data["expiresIn"]);
//
//       Get.snackbar(
//         "Success",
//         "Login Successful",
//         backgroundColor: const Color(0xFFFF8E48),
//         colorText: const Color(0xFFF0FFF3),
//       );
//
//       // Move to Dashboard
//       Get.offAllNamed(MyPagesName.dashboard);
//     } else {
//       Get.snackbar(
//         "Error",
//         res["message"] ?? "Invalid OTP",
//         backgroundColor: const Color(0xFFE84545),
//         colorText: const Color(0xFFFFFFFF),
//       );
//
//     }
//   }
// }
import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/widgets/custom_bottom_nav.dart';
import '../../apiservices/api_services.dart';
import '../../myRoutes/mypagesname.dart';

class AuthController extends GetxController {
  final AuthService _api = AuthService();
  final box = GetStorage();
  final String baseUrl = "https://api.gamsgroup.in/spiritual/auth";

  var loading = false.obs;
  var otpSent = false.obs;

  // 🔥 Resend Timer
  var resendSeconds = 0.obs;

  void startResendTimer() {
    resendSeconds.value = 30;

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      resendSeconds.value--;

      return resendSeconds.value > 0;
    });
  }
  Future<Map<String, dynamic>> sendOtp(String phone) async {
    loading.value = true;

    try {
      final url = Uri.parse("$baseUrl/send-otp");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone}),
      );

      if (response.statusCode == 200) {
        loading.value = false;

        return jsonDecode(response.body);

      } else {
        return {
          "success": false,
          "message": "Server error: ${response.statusCode}",
        };
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
  // 🔥 SEND OTP


  // 🔥 VERIFY OTP
  Future<void> verifyOtp(String phone, String otp) async {
    loading.value = true;

    final res = await _api.verifyOtp(phone, otp);
    loading.value = false;

    print("VERIFY OTP RESPONSE: $res");

    if (res["success"] == true) {
      final data = res["data"];

      // Save tokens safely
      box.write("access_token", data["access_token"]);
      box.write("refresh_token", data["refresh_token"]);
      box.write("expiresIn", data["expiresIn"]);

      Get.snackbar(
        "Success",
        "Login Successful",
        backgroundColor: const Color(0xFFFF8E48),
        colorText: const Color(0xFFF0FFF3),
      );

      Get.offAll(()=> MyHomePage());
      // Get.offAllNamed(MyPagesName.dashboard);
    } else {
      Get.snackbar(
        "Error",
        res["message"] ?? "Invalid OTP",
        backgroundColor: const Color(0xFFE84545),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }
}
// wow
