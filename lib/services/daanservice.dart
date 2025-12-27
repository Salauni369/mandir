

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/donation_model.dart';
import '../utils/api_header.dart';
import '../utils/apiconstants.dart';

class DaanService {
  // =========================
  // GET ALL DONATIONS
  // =========================
  static Future<List<DaanModel>> getAll() async {
    final uri = Uri.parse(ApiConstants.getdonation);

    try {
      print("📥 GET ALL DONATIONS");
      print("➡️ URL: $uri");

      final response = await http.get(
        uri,
        headers: ApiHeaders.headers(),
      ).timeout(const Duration(seconds: 30));

      print("⬅️ STATUS: ${response.statusCode}");
      print("⬅️ BODY: ${response.body}");

      if (response.statusCode != 200) {
        final decoded = jsonDecode(response.body);
        throw Exception(decoded["message"] ?? "Failed to fetch donations");
      }

      final decoded = jsonDecode(response.body);
      final List list = decoded["data"]["donations"] ?? [];

      print("✅ Found ${list.length} donations");
      return list.map((e) => DaanModel.fromJson(e)).toList();
    } catch (e) {
      print("❌ GET ERROR: $e");
      rethrow;
    }
  }

  // =========================
  // ADD DONATION (JSON ONLY)
  // =========================
  static Future<DaanModel> add(DaanModel daan) async {
    final uri = Uri.parse(ApiConstants.postdonation);

    final body = jsonEncode({
      "description": daan.description,
      "button_text": daan.button_text,
      "button_link": daan.button_link,
      "image": daan.image, // ✅ IMAGE URL ONLY
    });

    try {
      print("🚀 ADD DONATION");
      print("➡️ URL: $uri");
      print("➡️ BODY: $body");

      final response = await http.post(
        uri,
        headers: ApiHeaders.headers(),
        body: body,
      ).timeout(const Duration(seconds: 30));

      print("⬅️ STATUS: ${response.statusCode}");
      print("⬅️ RESPONSE: ${response.body}");

      if (response.statusCode != 200 && response.statusCode != 201) {
        final decoded = jsonDecode(response.body);
        throw Exception(decoded["message"] ?? "Failed to add donation");
      }

      final decoded = jsonDecode(response.body);

      // ✅ Handle different response structures
      final donationData = decoded["data"]["donation"] ?? decoded["data"];

      print("✅ Donation added successfully");
      return DaanModel.fromJson(donationData);
    } catch (e) {
      print("❌ ADD ERROR: $e");
      rethrow;
    }
  }

  // =========================
  // UPDATE DONATION (JSON)
  // =========================
  static Future<DaanModel> update(DaanModel daan) async {
    if (daan.id.isEmpty) {
      throw Exception("Donation ID is required for update");
    }

    final uri = Uri.parse("${ApiConstants.postdonation}/${daan.id}");

    final body = jsonEncode({
      "description": daan.description,
      "button_text": daan.button_text,
      "button_link": daan.button_link,
      "image": daan.image, // ✅ IMAGE URL
    });

    try {
      print("🔄 UPDATE DONATION");
      print("➡️ URL: $uri");
      print("➡️ BODY: $body");

      final response = await http.put(
        uri,
        headers: ApiHeaders.headers(),
        body: body,
      ).timeout(const Duration(seconds: 30));

      print("⬅️ STATUS: ${response.statusCode}");
      print("⬅️ RESPONSE: ${response.body}");

      if (response.statusCode != 200) {
        final decoded = jsonDecode(response.body);
        throw Exception(decoded["message"] ?? "Failed to update donation");
      }

      final decoded = jsonDecode(response.body);
      final donationData = decoded["data"]["donation"] ?? decoded["data"];

      print("✅ Donation updated successfully");
      return DaanModel.fromJson(donationData);
    } catch (e) {
      print("❌ UPDATE ERROR: $e");
      rethrow;
    }
  }

  // =========================
  // DELETE DONATION
  // =========================
  static Future<bool> delete(String id) async {
    if (id.isEmpty) {
      throw Exception("Donation ID is required for delete");
    }

    final uri = Uri.parse("${ApiConstants.postdonation}/$id");

    try {
      print("🗑 DELETE DONATION");
      print("➡️ URL: $uri");

      final response = await http.delete(
        uri,
        headers: ApiHeaders.headers(),
      ).timeout(const Duration(seconds: 30));

      print("⬅️ STATUS: ${response.statusCode}");
      print("⬅️ RESPONSE: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 204) {
        print("✅ Donation deleted successfully");
        return true;
      }

      final decoded = jsonDecode(response.body);
      throw Exception(decoded["message"] ?? "Failed to delete donation");
    } catch (e) {
      print("❌ DELETE ERROR: $e");
      rethrow;
    }
  }
}