//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:zamboree_devotion/utils/apihelper.dart';
//
// class AuthService {
//   final String baseUrl = "https://api.gamsgroup.in/spiritual/auth";
//
//   Future<Map<String, dynamic>> sendOtp(String phone) async {
//     final res = await http.post(
//       Uri.parse("$baseUrl/send-otp"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({"phone": phone}),
//     );
//
//     return ApiHelper.handleResponse(res);
//   }
//
//   Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
//     final res = await http.post(
//       Uri.parse("$baseUrl/verify-otp"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({"phone": phone, "otp": otp}),
//     );
//
//     return ApiHelper.handleResponse(res);
//   }
//
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/apiconstants.dart';
import '../utils/apihelper.dart';

class AuthService {
  Future<Map<String, dynamic>> sendOtp(String phone) async {
    final res = await http.post(
      Uri.parse(ApiConstants.sendOtp),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone": phone}),
    );

    return ApiHelper.handleResponse(res);
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    final res = await http.post(
      Uri.parse(ApiConstants.verifyOtp),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone": phone, "otp": otp}),
    );

    return ApiHelper.handleResponse(res);
  }
}
