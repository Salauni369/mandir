// // //
// // // import 'dart:convert';
// // // import 'dart:io';
// // // import 'package:http/http.dart' as http;
// // // import 'package:http_parser/http_parser.dart';
// // // import '../models/donation_model.dart';
// // // import '../utils/api_header.dart';
// // // import '../utils/apiconstants.dart';
// // //
// // // class DaanService {
// // //
// // //   static Future<List<DaanModel>> getAll() async {
// // //     final uri = Uri.parse(ApiConstants.getdonation);
// // //     final response = await http.get(uri, headers: ApiHeaders.headers());
// // //
// // //     print("GET URL: $uri");
// // //     print("STATUS: ${response.statusCode}");
// // //     print("RAW RESPONSE => ${response.body}");
// // //
// // //     if (response.statusCode != 200) {
// // //       throw Exception("Failed to fetch donations");
// // //     }
// // //
// // //     final decoded = jsonDecode(response.body);
// // //     final List list = decoded["data"]["donations"] ?? [];
// // //
// // //     print("TOTAL DONATIONS => ${list.length}");
// // //
// // //     return list.map((e) => DaanModel.fromJson(e)).toList();
// // //   }
// // //   static Future<DaanModel> add(DaanModel daan) async {
// // //     try {
// // //       final uri = Uri.parse(ApiConstants.postdonation);
// // //
// // //       // Check if image is URL or local file
// // //       if (daan.image.startsWith('http')) {
// // //         // USE JSON BODY (URL)
// // //         return await _addWithJson(uri, daan);
// // //       } else {
// // //         // USE MULTIPART (FILE UPLOAD)
// // //         return await _addWithMultipart(uri, daan);
// // //       }
// // //     } catch (e) {
// // //       print("❌ ADD ERROR: $e");
// // //       rethrow;
// // //     }
// // //   }
// // //
// // //   static Future<DaanModel> addWithJson({required String uri, dynamic bodyReq}) async {
// // //     final body = jsonEncode(bodyReq);
// // //
// // //     print("🚀 ADD URL (JSON): $uri");
// // //     print("📤 BODY: $body");
// // //
// // //     final response = await http.post(
// // //       Uri.parse(uri),
// // //       headers: ApiHeaders.headers(),
// // //       body: body,
// // //     ).timeout(const Duration(seconds: 30));
// // //
// // //     print("📥 STATUS: ${response.statusCode}");
// // //     print("📥 RESPONSE: ${response.body}");
// // //
// // //     if (response.statusCode != 200 && response.statusCode != 201) {
// // //       final decoded = jsonDecode(response.body);
// // //       throw Exception(decoded["message"] ?? "Failed to add donation");
// // //     }
// // //
// // //     final decoded = jsonDecode(response.body);
// // //     return DaanModel.fromJson(decoded["data"]["donation"]);
// // //   }
// // //
// // //
// // //   static Future<DaanModel> _addWithJson(Uri uri, DaanModel daan) async {
// // //     final body = jsonEncode({
// // //       "donation_title": daan.donation_title,
// // //       "button_label": daan.buttonText,
// // //       "button_url": daan.buttonLink,
// // //       "mobile_image": daan.image, // URL
// // //     });
// // //
// // //     print("🚀 ADD URL (JSON): $uri");
// // //     print("📤 BODY: $body");
// // //
// // //     final response = await http.post(
// // //       uri,
// // //       headers: ApiHeaders.headers(),
// // //       body: body,
// // //     ).timeout(const Duration(seconds: 30));
// // //
// // //     print("📥 STATUS: ${response.statusCode}");
// // //     print("📥 RESPONSE: ${response.body}");
// // //
// // //     if (response.statusCode != 200 && response.statusCode != 201) {
// // //       final decoded = jsonDecode(response.body);
// // //       throw Exception(decoded["message"] ?? "Failed to add donation");
// // //     }
// // //
// // //     final decoded = jsonDecode(response.body);
// // //     return DaanModel.fromJson(decoded["data"]["donation"]);
// // //   }
// // //
// // //   static Future<DaanModel> _addWithMultipart(Uri uri, DaanModel daan) async {
// // //     final request = http.MultipartRequest("POST", uri);
// // //
// // //     final authHeader = ApiHeaders.headers()['Authorization'];
// // //     if (authHeader == null || authHeader.isEmpty) {
// // //       throw Exception("Authorization token missing");
// // //     }
// // //     request.headers['Authorization'] = authHeader;
// // //     request.fields.addAll({
// // //       'donation_title': daan.donation_title.trim(),
// // //       'button_label': daan.buttonText.trim(),
// // //       'button_url': daan.buttonLink.trim(),
// // //       'mobile_image': "",
// // //     });
// // //
// // //     print("🚀 ADD DONATION (MULTIPART)");
// // //     print("➡️ URL      : ${request.url}");
// // //     print("➡️ HEADERS  : ${request.headers}");
// // //     print("➡️ FIELDS   : ${request.fields}");
// // //     print("➡️ FILES    : ${request.files.map((f) => f.field).toList()}");
// // //     final streamedResponse = await request.send();
// // //     final response = await http.Response.fromStream(streamedResponse);
// // //
// // //     print("⬅️ STATUS   : ${response.statusCode}");
// // //     print("⬅️ RESPONSE : ${response.body}");
// // //
// // //     if (response.statusCode != 200 && response.statusCode != 201) {
// // //       final decoded = jsonDecode(response.body);
// // //       throw Exception(decoded["message"] ?? "Failed to add donation");
// // //     }
// // //
// // //     final decoded = jsonDecode(response.body);
// // //     return DaanModel.fromJson(decoded["data"]["donation"]);
// // //   }
// // //
// // //   static Future<DaanModel> update(DaanModel daan) async {
// // //     try {
// // //       if (daan.id.isEmpty) throw Exception("ID required");
// // //
// // //       final uri = Uri.parse("${ApiConstants.postdonation}/${daan.id}");
// // //
// // //       if (daan.image.startsWith('http')) {
// // //         return await _updateWithJson(uri, daan);
// // //       } else {
// // //         return await _updateWithMultipart(uri, daan);
// // //       }
// // //     } catch (e) {
// // //       print("❌ UPDATE ERROR: $e");
// // //       rethrow;
// // //     }
// // //   }
// // //
// // //   static Future<DaanModel> _updateWithJson(Uri uri, DaanModel daan) async {
// // //     final body = jsonEncode({
// // //       "donation_title": daan.donation_title,
// // //       "button_label": daan.buttonText,
// // //       "button_url": daan.buttonLink,
// // //       "mobile_image": daan.image,
// // //     });
// // //
// // //     print("🔄 UPDATE URL (JSON): $uri");
// // //     print("📤 BODY: $body");
// // //
// // //     final response = await http.put(
// // //       uri,
// // //       headers: ApiHeaders.headers(),
// // //       body: body,
// // //     ).timeout(const Duration(seconds: 30));
// // //
// // //     print("📥 STATUS: ${response.statusCode}");
// // //     print("📥 RESPONSE: ${response.body}");
// // //
// // //     if (response.statusCode != 200) {
// // //       final decoded = jsonDecode(response.body);
// // //       throw Exception(decoded["message"] ?? "Failed to update");
// // //     }
// // //
// // //     final decoded = jsonDecode(response.body);
// // //     return DaanModel.fromJson(decoded["data"]["donation"] ?? decoded["data"]);
// // //   }
// // //
// // //   static Future<DaanModel> _updateWithMultipart(Uri uri, DaanModel daan) async {
// // //     var request = http.MultipartRequest("PUT", uri);
// // //
// // //     final token = ApiHeaders.headers()['Authorization'];
// // //     if (token != null) {
// // //       request.headers['Authorization'] = token;
// // //     }
// // //
// // //     request.fields['donation_title'] = daan.donation_title;
// // //     request.fields['button_label'] = daan.buttonText;
// // //     request.fields['button_url'] = daan.buttonLink;
// // //
// // //     final file = File(daan.image);
// // //     if (await file.exists()) {
// // //       request.files.add(
// // //         await http.MultipartFile.fromPath(
// // //           'mobile_image',
// // //           daan.image,
// // //           contentType: MediaType('image', 'jpeg'),
// // //         ),
// // //       );
// // //     }
// // //
// // //     print("🔄 UPDATE URL (MULTIPART): $uri");
// // //     print("📤 FIELDS: ${request.fields}");
// // //     print("📤 FILES: ${request.files.length} file(s)");
// // //
// // //     final streamedResponse = await request.send().timeout(const Duration(seconds: 30));
// // //     final response = await http.Response.fromStream(streamedResponse);
// // //
// // //     print("📥 STATUS: ${response.statusCode}");
// // //     print("📥 RESPONSE: ${response.body}");
// // //
// // //     if (response.statusCode != 200) {
// // //       final decoded = jsonDecode(response.body);
// // //       throw Exception(decoded["message"] ?? "Failed to update");
// // //     }
// // //
// // //     final decoded = jsonDecode(response.body);
// // //     return DaanModel.fromJson(decoded["data"]["donation"] ?? decoded["data"]);
// // //   }
// // //
// // //   static Future<bool> delete(String id) async {
// // //     try {
// // //       final uri = Uri.parse("${ApiConstants.postdonation}/$id");
// // //       final response = await http.delete(uri, headers: ApiHeaders.headers());
// // //       return response.statusCode == 200;
// // //     } catch (e) {
// // //       print("DELETE ERROR: $e");
// // //       return false;
// // //     }
// // //   }
// // // }
// //
// //
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// //
// // import '../models/donation_model.dart';
// // import '../utils/api_header.dart';
// // import '../utils/apiconstants.dart';
// //
// // class DaanService {
// //
// //   // =========================
// //   // GET ALL DONATIONS
// //   // =========================
// //   static Future<List<DaanModel>> getAll() async {
// //     final uri = Uri.parse(ApiConstants.getdonation);
// //
// //     final response = await http.get(
// //       uri,
// //       headers: ApiHeaders.headers(),
// //     );
// //
// //     print("GET URL: $uri");
// //     print("STATUS : ${response.statusCode}");
// //     print("BODY   : ${response.body}");
// //
// //     if (response.statusCode != 200) {
// //       throw Exception("Failed to fetch donations");
// //     }
// //
// //     final decoded = jsonDecode(response.body);
// //     final List list = decoded["data"]["donations"] ?? [];
// //
// //     return list.map((e) => DaanModel.fromJson(e)).toList();
// //   }
// //
// //   // =========================
// //   // ADD DONATION (JSON ONLY)
// //   // =========================
// //   static Future<DaanModel> add(DaanModel daan) async {
// //     final uri = Uri.parse(ApiConstants.postdonation);
// //
// //     final body = jsonEncode({
// //       "donation_title": daan.donation_title,
// //       "button_label": daan.buttonText,
// //       "button_url": daan.buttonLink,
// //       "mobile_image": daan.image, // ✅ IMAGE URL ONLY
// //     });
// //
// //     print("🚀 ADD DONATION");
// //     print("➡️ URL  : $uri");
// //     print("➡️ BODY : $body");
// //
// //     final response = await http.post(
// //       uri,
// //       headers: ApiHeaders.headers(),
// //       body: body,
// //     ).timeout(const Duration(seconds: 30));
// //
// //     print("⬅️ STATUS  : ${response.statusCode}");
// //     print("⬅️ RESPONSE: ${response.body}");
// //
// //     if (response.statusCode != 200 && response.statusCode != 201) {
// //       final decoded = jsonDecode(response.body);
// //       throw Exception(decoded["message"] ?? "Failed to add donation");
// //     }
// //
// //     final decoded = jsonDecode(response.body);
// //     return DaanModel.fromJson(decoded["data"]["donation"]);
// //   }
// //
// //   // =========================
// //   // UPDATE DONATION (JSON)
// //   // =========================
// //   static Future<DaanModel> update(DaanModel daan) async {
// //     if (daan.id.isEmpty) {
// //       throw Exception("Donation ID required");
// //     }
// //
// //     final uri = Uri.parse("${ApiConstants.postdonation}/${daan.id}");
// //
// //     final body = jsonEncode({
// //       "donation_title": daan.donation_title,
// //       "button_label": daan.buttonText,
// //       "button_url": daan.buttonLink,
// //       "mobile_image": daan.image, // ✅ IMAGE URL
// //     });
// //
// //     print("🔄 UPDATE DONATION");
// //     print("➡️ URL  : $uri");
// //     print("➡️ BODY : $body");
// //
// //     final response = await http.put(
// //       uri,
// //       headers: ApiHeaders.headers(),
// //       body: body,
// //     ).timeout(const Duration(seconds: 30));
// //
// //     print("⬅️ STATUS  : ${response.statusCode}");
// //     print("⬅️ RESPONSE: ${response.body}");
// //
// //     if (response.statusCode != 200) {
// //       final decoded = jsonDecode(response.body);
// //       throw Exception(decoded["message"] ?? "Failed to update donation");
// //     }
// //
// //     final decoded = jsonDecode(response.body);
// //     return DaanModel.fromJson(decoded["data"]["donation"] ?? decoded["data"]);
// //   }
// //
// //   // =========================
// //   // DELETE DONATION
// //   // =========================
// //   static Future<bool> delete(String id) async {
// //     final uri = Uri.parse("${ApiConstants.postdonation}/$id");
// //
// //     try {
// //       final response = await http.delete(
// //         uri,
// //         headers: ApiHeaders.headers(),
// //       );
// //
// //       print("🗑 DELETE DONATION");
// //       print("➡️ URL   : $uri");
// //       print("⬅️ STATUS: ${response.statusCode}");
// //
// //       return response.statusCode == 200;
// //     } catch (e) {
// //       print("❌ DELETE ERROR: $e");
// //       return false;
// //     }
// //   }
// // }
//
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../models/donation_model.dart';
// import '../utils/api_header.dart';
// import '../utils/apiconstants.dart';
//
// class DaanService {
//   // =========================
//   // GET ALL DONATIONS
//   // =========================
//   static Future<List<DaanModel>> getAll() async {
//     final uri = Uri.parse(ApiConstants.getdonation);
//
//     try {
//       final response = await http.get(
//         uri,
//         headers: ApiHeaders.headers(),
//       ).timeout(const Duration(seconds: 30));
//
//       print("📥 GET ALL DONATIONS");
//       print("➡️ URL    : $uri");
//       print("⬅️ STATUS : ${response.statusCode}");
//       print("⬅️ BODY   : ${response.body}");
//
//       if (response.statusCode != 200) {
//         final decoded = jsonDecode(response.body);
//         throw Exception(decoded["message"] ?? "Failed to fetch donations");
//       }
//
//       final decoded = jsonDecode(response.body);
//       final List list = decoded["data"]["donations"] ?? [];
//
//       return list.map((e) => DaanModel.fromJson(e)).toList();
//     } catch (e) {
//       print("❌ GET ERROR: $e");
//       rethrow;
//     }
//   }
//
//   // =========================
//   // ADD DONATION (JSON ONLY)
//   // =========================
//   static Future<DaanModel> add(DaanModel daan) async {
//     final uri = Uri.parse(ApiConstants.postdonation);
//
//     final body = jsonEncode({
//       "donation_title": daan.donation_title,
//       "button_label": daan.buttonText,
//       "button_url": daan.buttonLink,
//       "mobile_image": daan.image, // ✅ IMAGE URL ONLY
//     });
//
//     print("🚀 ADD DONATION");
//     print("➡️ URL  : $uri");
//     print("➡️ BODY : $body");
//
//     try {
//       final response = await http.post(
//         uri,
//         headers: ApiHeaders.headers(),
//         body: body,
//       ).timeout(const Duration(seconds: 30));
//
//       print("⬅️ STATUS  : ${response.statusCode}");
//       print("⬅️ RESPONSE: ${response.body}");
//
//       if (response.statusCode != 200 && response.statusCode != 201) {
//         final decoded = jsonDecode(response.body);
//         throw Exception(decoded["message"] ?? "Failed to add donation");
//       }
//
//       final decoded = jsonDecode(response.body);
//
//       // ✅ Handle different response structures
//       final donationData = decoded["data"]["donation"] ?? decoded["data"];
//
//       return DaanModel.fromJson(donationData);
//     } catch (e) {
//       print("❌ ADD ERROR: $e");
//       rethrow;
//     }
//   }
//
//   // =========================
//   // UPDATE DONATION (JSON)
//   // =========================
//   static Future<DaanModel> update(DaanModel daan) async {
//     if (daan.id.isEmpty) {
//       throw Exception("Donation ID is required for update");
//     }
//
//     final uri = Uri.parse("${ApiConstants.postdonation}/${daan.id}");
//
//     final body = jsonEncode({
//       "donation_title": daan.donation_title,
//       "button_label": daan.buttonText,
//       "button_url": daan.buttonLink,
//       "mobile_image": daan.image, // ✅ IMAGE URL
//     });
//
//     print("🔄 UPDATE DONATION");
//     print("➡️ URL  : $uri");
//     print("➡️ BODY : $body");
//
//     try {
//       final response = await http.put(
//         uri,
//         headers: ApiHeaders.headers(),
//         body: body,
//       ).timeout(const Duration(seconds: 30));
//
//       print("⬅️ STATUS  : ${response.statusCode}");
//       print("⬅️ RESPONSE: ${response.body}");
//
//       if (response.statusCode != 200) {
//         final decoded = jsonDecode(response.body);
//         throw Exception(decoded["message"] ?? "Failed to update donation");
//       }
//
//       final decoded = jsonDecode(response.body);
//       final donationData = decoded["data"]["donation"] ?? decoded["data"];
//
//       return DaanModel.fromJson(donationData);
//     } catch (e) {
//       print("❌ UPDATE ERROR: $e");
//       rethrow;
//     }
//   }
//
//   // =========================
//   // DELETE DONATION
//   // =========================
//   static Future<bool> delete(String id) async {
//     if (id.isEmpty) {
//       throw Exception("Donation ID is required for delete");
//     }
//
//     final uri = Uri.parse("${ApiConstants.postdonation}/$id");
//
//     print("🗑 DELETE DONATION");
//     print("➡️ URL: $uri");
//
//     try {
//       final response = await http.delete(
//         uri,
//         headers: ApiHeaders.headers(),
//       ).timeout(const Duration(seconds: 30));
//
//       print("⬅️ STATUS: ${response.statusCode}");
//       print("⬅️ RESPONSE: ${response.body}");
//
//       if (response.statusCode == 200 || response.statusCode == 204) {
//         return true;
//       }
//
//       final decoded = jsonDecode(response.body);
//       throw Exception(decoded["message"] ?? "Failed to delete donation");
//     } catch (e) {
//       print("❌ DELETE ERROR: $e");
//       rethrow;
//     }
//   }
// }

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
      "donation_title": daan.donation_title,
      "button_label": daan.buttonText,
      "button_url": daan.buttonLink,
      "mobile_image": daan.image, // ✅ IMAGE URL ONLY
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
      "donation_title": daan.donation_title,
      "button_label": daan.buttonText,
      "button_url": daan.buttonLink,
      "mobile_image": daan.image, // ✅ IMAGE URL
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