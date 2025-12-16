// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:get_storage/get_storage.dart';
//
// class ApiService {
//   final String baseUrl = "https://api.gamsgroup.in";
//
//   /// Fetches temple details. Requires token saved under "access_token".
//   Future<Map<String, dynamic>> fetchHomeData() async {
//     final box = GetStorage();
//     final token = box.read("access_token") ?? "";
//
//     final url = Uri.parse('$baseUrl/spiritual/');
//
//     final res = await http.get(url, headers: {
//       "Authorization": "Bearer $token",
//       "Content-Type": "application/json",
//     });
//
//     if (res.statusCode == 200) {
//       return jsonDecode(res.body) as Map<String, dynamic>;
//     } else {
//       throw Exception("Home API failed: ${res.statusCode} ${res.body}");
//     }
//   }
// }

import 'package:http/http.dart' as http;
import '../utils/apiconstants.dart';
import '../utils/api_header.dart';
import '../utils/apihelper.dart';

class DashboardService {
  static Future<Map<String, dynamic>> fetchDashboard() async {
    final res = await http.get(
      Uri.parse(ApiConstants.dashboard),
      headers: ApiHeaders.headers(),
    );
    return ApiHelper.handleResponse(res);
  }
}
