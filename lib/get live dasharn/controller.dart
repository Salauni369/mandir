import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/live_darshan_model.dart';
import '../utils/api_header.dart';
import 'model.dart';

class LiveDarshanController extends GetxController {
  final isLoading = true.obs;
  final liveDarshans = <DarshanModel>[].obs;

  final String url =
      "https://dev-api.gamsgroup.in/spiritual/live-darshan";

  @override
  void onInit() {
    super.onInit();
    fetchLiveDarshans();
  }

  Future<void> fetchLiveDarshans() async {
    try {
      isLoading(true);
      log("Fetching live darshans (no service)");

      final response = await http.get(
        Uri.parse(url),
        headers: ApiHeaders.headers(),
      );

      if (response.statusCode != 200) {
        throw "API failed with ${response.statusCode}";
      }

      final json = jsonDecode(response.body);
      final List list = json['data']['liveDarshan'] ?? [];

      liveDarshans.assignAll(
        list.map((e) => DarshanModel.fromJson(e)).toList(),
      );

      log("Fetched ${liveDarshans.length} live darshans");
    } catch (e) {
      log("Live darshan error: $e");
    } finally {
      isLoading(false);
    }
  }
}
