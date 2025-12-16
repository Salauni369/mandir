
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _box = GetStorage();
  final String baseUrl = "https://api.gamsgroup.in/spiritual";

  Map<String, String> _headers() {
    final token = _box.read("access_token");
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  Future<Map<String, dynamic>> fetchHomeData() async {
    final res = await http.get(Uri.parse("$baseUrl/"), headers: _headers());
    return _handleResponse(res);
  }

  Future<Map<String, dynamic>> addDarshan(Map<String, dynamic> data) async {
    final res = await http.post(
      Uri.parse("$baseUrl/live"),
      headers: _headers(),
      body: jsonEncode(data),
    );

    return _handleResponse(res);
  }

  Map<String, dynamic> _handleResponse(http.Response res) {
    if (res.statusCode == 200 || res.statusCode == 201) {
      return jsonDecode(res.body);
    } else if (res.statusCode == 401) {
      _box.remove("access_token");
      throw "Session expired";
    }
    throw "Error: ${res.statusCode}";
  }
}
