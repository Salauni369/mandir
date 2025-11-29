// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ApiService {
//   static const baseUrl = "https://your-domain.com/";
//
//   static Future<Map<String, dynamic>> postApi(String endpoint, Map data) async {
//     final url = Uri.parse(baseUrl + endpoint);
//
//     final response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(data),
//     );
//
//     return {
//       "status": response.statusCode,
//       "body": jsonDecode(response.body),
//     };
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "https://api.gamsgroup.in/spiritual/auth";

  Future<Map<String, dynamic>> sendOtp(String phone) async {
    final response = await http.post(
      Uri.parse("https://api.gamsgroup.in/spiritual/auth/send-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone": phone}),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    final response = await http.post(
      Uri.parse("https://api.gamsgroup.in/spiritual/auth/verify-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone": phone, "otp": otp}),
    );

    return jsonDecode(response.body);
  }
}
