

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/donation_model.dart';
import '../utils/api_header.dart';
import '../utils/apiconstants.dart';

class DaanService {

  /* =========================
     GET DONATIONS
     ========================= */
  static Future<List<DaanModel>> getAll() async {
    final uri = Uri.parse(ApiConstants.donation);

    final response = await http.get(
      uri,
      headers: ApiHeaders.headers(),
    );

    print("GET URL: $uri");
    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch donations");
    }

    final decoded = jsonDecode(response.body);

    final List list =
        decoded["data"]?["user"]?["temple"]?["donation"] ?? [];

    return list.map((e) => DaanModel.fromJson(e)).toList();
  }

  /* =========================
     ADD DONATION
     ========================= */
  static Future<DaanModel> add(DaanModel daan) async {
    final uri =
    Uri.parse("${ApiConstants.donation}/donation");

    final response = await http.post(
      uri,
      headers: ApiHeaders.headers(),
      body: jsonEncode(daan.toJson()),
    );

    print("POST URL: $uri");
    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw Exception("Failed to add donation");
    }

    final decoded = jsonDecode(response.body);
    return DaanModel.fromJson(decoded["data"]);
  }

  /* =========================
     UPDATE DONATION
     ========================= */
  static Future<DaanModel> update(DaanModel daan) async {
    if (daan.id.isEmpty) {
      throw Exception("Donation ID required");
    }

    final uri = Uri.parse(
        "${ApiConstants.donation}/donation/${daan.id}");

    final response = await http.put(
      uri,
      headers: ApiHeaders.headers(),
      body: jsonEncode(daan.toJson()),
    );

    print("PUT URL: $uri");
    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Failed to update donation");
    }

    final decoded = jsonDecode(response.body);
    return DaanModel.fromJson(decoded["data"]);
  }

  /* =========================
     DELETE DONATION
     ========================= */
  static Future<bool> delete(String donationId) async {
    final uri = Uri.parse(
        "${ApiConstants.donation}/donation/$donationId");

    final response = await http.delete(
      uri,
      headers: ApiHeaders.headers(),
    );

    print("DELETE URL: $uri");
    print("STATUS: ${response.statusCode}");

    return response.statusCode == 200;
  }
}


