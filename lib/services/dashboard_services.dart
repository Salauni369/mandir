

import 'dart:convert';

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

  static Future<Map<String, dynamic>> updateOverview(
      Map<String, dynamic> body) async {

    final res = await http.put(
      Uri.parse(ApiConstants.updateOverview),
      headers: ApiHeaders.headers(),
      body: jsonEncode(body),
    );

    return ApiHelper.handleResponse(res);
  }

}



