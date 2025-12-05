//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ApiService {
//   final String baseUrl = "https://api.gamsgroup.in";
//
//   Future<Map<String, dynamic>> getHomeData() async {
//     final url = Uri.parse('$baseUrl/spiritual/home');
//     final res = await http.get(url);
//
//     if (res.statusCode == 200) {
//       return jsonDecode(res.body) as Map<String, dynamic>;
//     } else {
//       throw Exception('Failed to load home data: ${res.statusCode}');
//     }
//   }
// }



// lib/apiservices/api_services.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class ApiService {
  final String baseUrl = "https://api.gamsgroup.in";

  /// Fetches temple details. Requires token saved under "access_token".
  Future<Map<String, dynamic>> fetchHomeData() async {
    final box = GetStorage();
    final token = box.read("access_token") ?? "";

    final url = Uri.parse('$baseUrl/spiritual/');

    final res = await http.get(url, headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    });

    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    } else {
      throw Exception("Home API failed: ${res.statusCode} ${res.body}");
    }
  }
}