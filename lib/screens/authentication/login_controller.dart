import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zamboree_devotion/widgets/custom_bottom_nav.dart';

import '../../apiservices/auth_services.dart';


class AuthController extends GetxController {
  final AuthService _service = AuthService();
  final _storage = GetStorage();
  final accessToken = "access_token";
  final refreshToken = "refresh_token";
  final religion = "religion";
  var loading = false.obs;
  var resendSeconds = 0.obs;

  Timer? _timer;

  // ---------------------------------------------------------
  // SEND OTP
  // ---------------------------------------------------------
  // Future<void> sendOtp(String phone) async {
  //   try {
  //     loading(true);
  //
  //     final res = await _service.sendOtp(phone);
  //
  //     if (res["success"] == true) {
  //       Get.snackbar("OTP Sent", "Please check your phone");
  //
  //       startResendTimer();
  //     } else {
  //       Get.snackbar("Error", res["message"] ?? "Failed to send OTP");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString());
  //   } finally {
  //     loading(false);
  //   }
  // }

  Future<void> sendOtp(String phone) async {
    try {
      loading(true);
      final res = await _service.sendOtp(phone);

      if (res["success"] == true) {
        Get.snackbar("OTP Sent", "Please check your phone");
        // ← TIMER START MAT KARO YAHAN
      } else {
        Get.snackbar("Error", res["message"] ?? "Failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loading(false);
    }
  }

  // ---------------------------------------------------------
  // VERIFY OTP
  // ---------------------------------------------------------
  Future<void> verifyOtp(String phone, String otp) async {
    try {
      loading(true);

      final res = await _service.verifyOtp(phone, otp);

      if (res["success"] == true) {
        print("data ===>> $res");

        final token = res["token"].toString();
        if (token != null && token.isNotEmpty) {
          _storage.write("access_token", res["data"]["access_token"]);
          _storage.write("refresh_token", res["data"]["refresh_token"]);
          _storage.write("religion", res["data"]["religion"]);


        }
        print("STORED TOKEN => ${GetStorage().read('access_token')}");

        Get.snackbar("Success", "Logged in successfully");

        Get.offAll(()=> MyHomePage());
      } else {
        Get.snackbar("Error", res["message"] ?? "Wrong OTP");
      }
    } catch (e) {
      print("desgmkh  $e");
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    } finally {
      loading(false);
    }
  }

  // Future<void> verifyOtp(String phone, String otp) async {
  //   try {
  //     loading(true);
  //
  //     final res = await _service.verifyOtp(phone, otp);
  //     print("VERIFY OTP RESPONSE => $res");
  //
  //     if (res["success"] == true) {
  //       final accessTokenValue = res["data"]["access_token"];
  //       final refreshTokenValue = res["data"]["refresh_token"];
  //       final religionValue = res["data"]["religion"];
  //
  //       if (accessTokenValue != null &&
  //           accessTokenValue.toString().isNotEmpty) {
  //
  //         _storage.write(accessToken, accessTokenValue);
  //         _storage.write(refreshToken, refreshTokenValue);
  //         _storage.write(religion, religionValue);
  //       }
  //
  //       print("STORED TOKEN => ${_storage.read(accessToken)}");
  //
  //       Get.snackbar("Success", "Logged in successfully");
  //       Get.offAll(() => MyHomePage());
  //     } else {
  //       Get.snackbar("Error", res["message"] ?? "Wrong OTP");
  //     }
  //   } catch (e) {
  //     print("VERIFY OTP ERROR => $e");
  //     Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
  //   } finally {
  //     loading(false);
  //   }
  // }


  // ---------------------------------------------------------
  // RESEND OTP TIMER LOGIC
  // ---------------------------------------------------------
  void startResendTimer() {
    resendSeconds.value = 30; // 30 seconds block

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (resendSeconds.value == 0) {
        t.cancel();
      } else {
        resendSeconds.value--;
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

