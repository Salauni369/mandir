// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../models/live_darshan_model.dart';
// import '../utils/api_header.dart';
// import '../utils/apiconstants.dart';
//
// class DarshanService {
//
//   // =========================
//   // GET ALL DARSHANS
//   // =========================
//   static Future<List<DarshanModel>> getAll() async {
//     final uri = Uri.parse(ApiConstants.liveDarshan);
//
//     final response = await http.get(
//       uri,
//       headers: ApiHeaders.headers(),
//     );
//
//     if (response.statusCode != 200) {
//       final decoded = jsonDecode(response.body);
//       throw Exception(decoded["message"] ?? "Failed to fetch darshans");
//     }
//
//     final decoded = jsonDecode(response.body);
//     final List list = decoded["data"]["darshans"] ?? [];
//
//     return list.map((e) => DarshanModel.fromJson(e)).toList();
//   }
//
//   // =========================
//   // ADD DARSHAN (URL ONLY)
//   // =========================
//   static Future<DarshanModel> add(DarshanModel darshan) async {
//     final uri = Uri.parse(ApiConstants.liveDarshan);
//
//     final body = jsonEncode(darshan.toJson());
//
//     final response = await http.post(
//       uri,
//       headers: ApiHeaders.headers(),
//       body: body,
//     );
//
//     if (response.statusCode != 200 && response.statusCode != 201) {
//       final decoded = jsonDecode(response.body);
//       throw Exception(decoded["message"] ?? "Failed to add darshan");
//     }
//
//     final decoded = jsonDecode(response.body);
//     return DarshanModel.fromJson(
//       decoded["data"]["darshan"] ?? decoded["data"],
//     );
//   }
//
//   // =========================
//   // UPDATE DARSHAN (URL ONLY)
//   // =========================
//   static Future<DarshanModel> update(String id, DarshanModel darshan) async {
//     final uri = Uri.parse("${ApiConstants.liveDarshan}/$id");
//
//     final body = jsonEncode(darshan.toJson());
//
//     final response = await http.put(
//       uri,
//       headers: ApiHeaders.headers(),
//       body: body,
//     );
//
//     if (response.statusCode != 200) {
//       final decoded = jsonDecode(response.body);
//       throw Exception(decoded["message"] ?? "Failed to update darshan");
//     }
//
//     final decoded = jsonDecode(response.body);
//     return DarshanModel.fromJson(
//       decoded["data"]["darshan"] ?? decoded["data"],
//     );
//   }
//
//   // =========================
//   // DELETE DARSHAN
//   // =========================
//   static Future<bool> delete(String id) async {
//     final uri = Uri.parse("${ApiConstants.liveDarshan}/$id");
//
//     final response = await http.delete(
//       uri,
//       headers: ApiHeaders.headers(),
//     );
//
//     return response.statusCode == 200 || response.statusCode == 204;
//   }
// }


import 'dart:convert';
import 'dart:developer'; // 👈 for logging
import 'package:http/http.dart' as http;

import '../models/live_darshan_model.dart';
import '../utils/api_header.dart';
import '../utils/apiconstants.dart';

class DarshanService {

  // =========================
  // GET ALL DARSHANS
  // =========================
  static Future<List<DarshanModel>> getAll() async {
    final uri = Uri.parse(ApiConstants.liveDarshan);
    log("Fetching all darshans from $uri");

    final response = await http.get(
      uri,
      headers: ApiHeaders.headers(),
    );

    log("Response status (getAll): ${response.statusCode}");

    if (response.statusCode != 200) {
      final decoded = jsonDecode(response.body);
      log("Error fetching darshans: ${decoded["message"]}");
      throw Exception(decoded["message"] ?? "Failed to fetch darshans");
    }

    final decoded = jsonDecode(response.body);
    final List list = decoded["data"]["darshans"] ?? [];

    log("Fetched ${list.length} darshans successfully");
    return list.map((e) => DarshanModel.fromJson(e)).toList();
  }

  // =========================
  // ADD DARSHAN (URL ONLY)
  // =========================
  static Future<DarshanModel> add(DarshanModel darshan) async {
    final uri = Uri.parse(ApiConstants.liveDarshan);
    log("Adding new darshan: ${darshan.toJson()}");

    final body = jsonEncode(darshan.toJson());

    final response = await http.post(
      uri,
      headers: ApiHeaders.headers(),
      body: body,
    );

    log("Response status (add): ${response.statusCode}");

    if (response.statusCode != 200 && response.statusCode != 201) {
      final decoded = jsonDecode(response.body);
      log("Error adding darshan: ${decoded["message"]}");
      throw Exception(decoded["message"] ?? "Failed to add darshan");
    }

    final decoded = jsonDecode(response.body);
    log("Darshan added successfully");
    return DarshanModel.fromJson(
      decoded["data"]["darshan"] ?? decoded["data"],
    );
  }

  // =========================
  // UPDATE DARSHAN (URL ONLY)
  // =========================
  static Future<DarshanModel> update(String id, DarshanModel darshan) async {
    final uri = Uri.parse("${ApiConstants.liveDarshan}/$id");
    log("Updating darshan with id=$id, data=${darshan.toJson()}");

    final body = jsonEncode(darshan.toJson());

    final response = await http.put(
      uri,
      headers: ApiHeaders.headers(),
      body: body,
    );

    log("Response status (update): ${response.statusCode}");

    if (response.statusCode != 200) {
      final decoded = jsonDecode(response.body);
      log("Error updating darshan: ${decoded["message"]}");
      throw Exception(decoded["message"] ?? "Failed to update darshan");
    }

    final decoded = jsonDecode(response.body);
    log("Darshan updated successfully for id=$id");
    return DarshanModel.fromJson(
      decoded["data"]["darshan"] ?? decoded["data"],
    );
  }

  // =========================
  // DELETE DARSHAN
  // =========================
  static Future<bool> delete(String id) async {
    final uri = Uri.parse("${ApiConstants.liveDarshan}/$id");
    log("Deleting darshan with id=$id");

    final response = await http.delete(
      uri,
      headers: ApiHeaders.headers(),
    );

    log("Response status (delete): ${response.statusCode}");
    final success = response.statusCode == 200 || response.statusCode == 204;
    log(success ? "Darshan deleted successfully" : "Failed to delete darshan");
    return success;
  }
}