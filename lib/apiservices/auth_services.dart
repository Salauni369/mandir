

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
