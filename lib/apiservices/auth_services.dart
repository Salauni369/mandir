// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// //
// // class AuthService {
// //   final String baseUrl = "https://api.gamsgroup.in/spiritual/auth";
// //
// //   Future<Map<String, dynamic>> sendOtp(String phone) async {
// //     final response = await http.post(
// //       Uri.parse("$baseUrl/send-otp"),
// //       headers: {"Content-Type": "application/json"},
// //       body: jsonEncode({"phone": phone}),
// //     );
// //
// //     return jsonDecode(response.body);
// //   }
// //
// //   Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
// //     final response = await http.post(
// //       Uri.parse("$baseUrl/verify-otp"),
// //       headers: {"Content-Type": "application/json"},
// //       body: jsonEncode({"phone": phone, "otp": otp}),
// //     );
// //
// //     return jsonDecode(response.body);
// //   }
// // }
//
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class AuthService {
//   final String baseUrl = "https://api.gamsgroup.in/spiritual/auth";
//
//   // SEND OTP
//   Future<Map<String, dynamic>> sendOtp(String phone) async {
//     final url = Uri.parse("$baseUrl/send-otp");
//
//     final res = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({"phone": phone}),
//     );
//
//     return jsonDecode(res.body);
//   }
//
//   // VERIFY OTP
//   Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
//     final url = Uri.parse("$baseUrl/verify-otp");
//
//     final res = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "phone": phone,
//         "otp": otp,
//       }),
//     );
//
//     return jsonDecode(res.body);
//   }
// }



import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _box = GetStorage();
  final String baseUrl = "https://api.gamsgroup.in/spiritual";

  // ==================================================
  //                   HEADERS
  // ==================================================
  Map<String, String> _headers() {
    final token = _box.read("access_token");
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  // ==================================================
  //        UNIVERSAL API REQUEST HANDLER
  // ==================================================
  Future<Map<String, dynamic>> _handleRequest(
      Future<http.Response> future) async {
    try {
      final res = await future;

      if (res.statusCode == 0) {
        throw "Network error! Check your internet connection.";
      }

      final body = res.body.isNotEmpty ? jsonDecode(res.body) : {};

      switch (res.statusCode) {
        case 200:
        case 201:
          return body;

        case 400:
          throw body["message"] ?? "Bad Request (400).";

        case 401:
          _box.remove("access_token");
          throw "Session expired. Login again.";

        case 403:
          throw "Access forbidden (403).";

        case 404:
          throw "Not found (404).";

        case 500:
          throw "Internal Server Error (500). Try again later.";

        default:
          throw "Unexpected Error: ${res.statusCode}";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // ==================================================
  //                   AUTH APIs
  // ==================================================

  Future<Map<String, dynamic>> sendOtp(String phone) async {
    final url = Uri.parse("$baseUrl/auth/send-otp");
    return _handleRequest(http.post(
      url,
      headers: _headers(),
      body: jsonEncode({"phone": phone}),
    ));
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    final url = Uri.parse("$baseUrl/auth/verify-otp");
    return _handleRequest(http.post(
      url,
      headers: _headers(),
      body: jsonEncode({"phone": phone, "otp": otp}),
    ));
  }

  // ==================================================
  //                 HOME DATA API
  // ==================================================
  Future<Map<String, dynamic>> fetchHomeData() async {
    final url = Uri.parse("$baseUrl/");
    return _handleRequest(http.get(url, headers: _headers()));
  }
}
