
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://api.gamsgroup.in";

  Future<Map<String, dynamic>> getHomeData() async {
    final url = Uri.parse('$baseUrl/spiritual/home');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load home data: ${res.statusCode}');
    }
  }
}
