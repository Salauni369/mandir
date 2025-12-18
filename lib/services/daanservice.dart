// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// //
// // import '../models/donation_model.dart';
// // import '../utils/api_header.dart';
// // import '../utils/apiconstants.dart';
// //
// // class DaanService {
// //
// //   /* =========================
// //      GET DONATIONS
// //      ========================= */
// //   static Future<List<DaanModel>> getAll() async {
// //
// //     final uri = Uri.parse(ApiConstants.getdonation);
// //     final response = await http.get(
// //       uri,
// //       headers: ApiHeaders.headers(),
// //     );
// //
// //     print("GET URL: $uri");
// //     print("STATUS: ${response.statusCode}");
// //     print("BODY: ${response.body}");
// //
// //     if (response.statusCode != 200) {
// //       throw Exception("Failed to fetch donations");
// //     }
// //
// //     final decoded = jsonDecode(response.body);
// //
// //     final List list = decoded["data"]?["user"]?["temple"]?["donation"] ?? [];
// //
// //     return list.map((e) => DaanModel.fromJson(e)).toList();
// //   }
// //
// //   /* =========================
// //      ADD DONATION
// //      ========================= */
// //   // static Future<DaanModel> add(DaanModel daan) async {
// //   //   final uri =
// //   //   Uri.parse("${ApiConstants.postdonation}");
// //   //
// //   //   final response = await http.post(
// //   //     uri,
// //   //     headers: ApiHeaders.headers(),
// //   //     body: jsonEncode(daan.toJson()),
// //   //   );
// //   //
// //   //   print("POST URL: $uri");
// //   //   print("STATUS: ${response.statusCode}");
// //   //   print("BODY: ${response.body}");
// //   //
// //   //   if (response.statusCode != 200 &&
// //   //       response.statusCode != 201) {
// //   //     throw Exception("Failed to add donation");
// //   //   }
// //   //
// //   //   final decoded = jsonDecode(response.body);
// //   //   return DaanModel.fromJson(decoded["data"]);
// //   // }
// //
// //   static Future<DaanModel> add(DaanModel daan) async {
// //     final uri = Uri.parse(ApiConstants.postdonation);
// //
// //     final response = await http.post(
// //       uri,
// //       headers: ApiHeaders.headers(),
// //       body: jsonEncode(daan.toJson()),
// //     );
// //
// //     print("POST URL: $uri");
// //     print("STATUS: ${response.statusCode}");
// //     print("BODY: ${response.body}");
// //
// //     final decoded = jsonDecode(response.body);
// //
// //     // 🔥 HARD GUARD
// //     if (response.statusCode != 200 && response.statusCode != 201) {
// //       throw Exception(decoded["message"] ?? "Add donation failed");
// //     }
// //
// //     if (decoded["data"] == null) {
// //       throw Exception("Donation not created (data null)");
// //     }
// //
// //     return DaanModel.fromJson(decoded["data"]);
// //   }
// //
// //
// //   /* =========================
// //      UPDATE DONATION
// //      ========================= */
// //   static Future<DaanModel> update(DaanModel daan) async {
// //     if (daan.id.isEmpty) {
// //       throw Exception("Donation ID required");
// //     }
// //
// //     final uri = Uri.parse(
// //         "${ApiConstants.postdonation}/${daan.id}");
// //
// //     final response = await http.put(
// //       uri,
// //       headers: ApiHeaders.headers(),
// //       body: jsonEncode(daan.toJson()),
// //     );
// //
// //     print("PUT URL: $uri");
// //     print("STATUS: ${response.statusCode}");
// //     print("BODY: ${response.body}");
// //
// //     if (response.statusCode != 200) {
// //       throw Exception("Failed to update donation");
// //     }
// //
// //     final decoded = jsonDecode(response.body);
// //     return DaanModel.fromJson(decoded["data"]);
// //   }
// //
// //   /* =========================
// //      DELETE DONATION
// //   //    ========================= */
// //   // static Future<bool> delete(String donationId) async {
// //   //   final uri = Uri.parse(
// //   //       "${ApiConstants.donation}/donation/$donationId");
// //   //
// //   //   final response = await http.delete(
// //   //     uri,
// //   //     headers: ApiHeaders.headers(),
// //   //   );
// //   //
// //   //   print("DELETE URL: $uri");
// //   //   print("STATUS: ${response.statusCode}");
// //   //
// //   //   return response.statusCode == 200;
// //   //}
// // }
// //
// //
//
//
//
// //
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// // import '../models/donation_model.dart';
// // import '../utils/api_header.dart';
// // import '../utils/apiconstants.dart';
// //
// // class DaanService {
// //   // ADD DONATION
// //   static Future<DaanModel> add(DaanModel daan) async {
// //     final uri = Uri.parse(ApiConstants.postdonation);
// //
// //     var request = http.MultipartRequest("POST", uri);
// //     request.headers.addAll(ApiHeaders.headers());
// //
// //     // Text fields
// //     request.fields['button_text'] = daan.buttonText;
// //     request.fields['button_link'] = daan.buttonLink;
// //     request.fields['description'] = daan.donation_title;
// //
// //     // Image upload if local path
// //     if (daan.image.isNotEmpty && !daan.image.startsWith("http")) {
// //       request.files.add(
// //         await http.MultipartFile.fromPath(
// //           "image",
// //           daan.image,
// //           contentType: http.MediaType('image', 'jpeg'),
// //         ),
// //       );
// //     }
// //
// //     final streamedResponse = await request.send();
// //     final response = await http.Response.fromStream(streamedResponse);
// //
// //     print("ADD DONATION STATUS: ${response.statusCode}");
// //     print("ADD DONATION BODY: ${response.body}");
// //
// //     if (response.statusCode != 200 && response.statusCode != 201) {
// //       final decoded = jsonDecode(response.body);
// //       throw Exception(decoded["message"] ?? "Failed to add donation");
// //     }
// //
// //     final decoded = jsonDecode(response.body);
// //     return DaanModel.fromJson(decoded["data"]);
// //   }
// //
// //   // UPDATE DONATION
// //   static Future<DaanModel> update(DaanModel daan) async {
// //     if (daan.id.isEmpty) throw Exception("ID required");
// //
// //     final uri = Uri.parse("${ApiConstants.postdonation}/${daan.id}");
// //
// //     var request = http.MultipartRequest("PUT", uri);
// //     request.headers.addAll(ApiHeaders.headers());
// //   //
// //   //   {
// //   //     "donation_title": "new",
// //   //   "button_label": "ygtfgftyytf",
// //   //   "button_url": "vhgfhgfh",
// //   //   "mobile_image": "https://static.vecteezy.com/system/resources/thumbnails/007/588/076/small/foodstuff-for-donation-storage-and-delivery-various-food-pasta-cooking-oil-and-canned-food-in-cardboard-box-free-photo.jpg"
// //   // }
// //
// //     request.fields['button_label'] = daan.buttonText;
// //     request.fields['button_url'] = daan.buttonLink;
// //     request.fields['donation_title'] = daan.donation_title;
// //     request.fields['mobile_image'] = daan.image;
// //
// //     // if (daan.image.isNotEmpty && !daan.image.startsWith("http")) {
// //     //   request.files.add(
// //     //     await http.MultipartFile.fromPath(
// //     //       "image",
// //     //       daan.image,
// //     //       contentType: http.MediaType('image', 'jpeg'),
// //     //     ),
// //     //   );
// //     // }
// //
// //     final streamedResponse = await request.send();
// //     final response = await http.Response.fromStream(streamedResponse);
// //
// //     print("UPDATE STATUS: ${response.statusCode}");
// //     print("UPDATE BODY: ${response.body}");
// //
// //     if (response.statusCode != 200) {
// //       throw Exception("Failed to update");
// //     }
// //
// //     final decoded = jsonDecode(response.body);
// //     return DaanModel.fromJson(decoded["data"]);
// //   }
// //
// //
// // } ye chal rha h
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
//
// import '../models/donation_model.dart';
// import '../utils/api_header.dart';
// import '../utils/apiconstants.dart';
//
// class DaanService {
//   // ADD DONATION (already perfect – no change)
//   // static Future<DaanModel> add(DaanModel daan) async {
//   //   final uri = Uri.parse(ApiConstants.postdonation);
//   //
//   //   var request = http.MultipartRequest("POST", uri);
//   //   request.headers.addAll(ApiHeaders.headers());
//   //
//   //   print("ADD URL: $uri");
//   //   print("ADD FIELDS: ${request.fields}");
//   //   print("ADD FILES: ${request.files.length} file(s)");
//   //
//   //   final streamedResponse = await request.send();
//   //   final response = await http.Response.fromStream(streamedResponse);
//   //
//   //   print("ADD STATUS: ${response.statusCode}");
//   //   print("ADD BODY: ${response.body}");
//   //
//   //   request.fields['button_text'] = daan.buttonText;
//   //   request.fields['button_link'] = daan.buttonLink;
//   //   request.fields['description'] = daan.donation_title;
//   //
//   //   if (daan.image.isNotEmpty && !daan.image.startsWith("http")) {
//   //     request.files.add(
//   //       await http.MultipartFile.fromPath(
//   //         "image",
//   //         daan.image,
//   //         contentType: MediaType('image', 'jpeg'),
//   //       ),
//   //     );
//   //   }
//   //   //
//   //   // final streamedResponse = await request.send();
//   //   // final response = await http.Response.fromStream(streamedResponse);
//   //   //
//   //   // print("ADD DONATION STATUS: ${response.statusCode}");
//   //   // print("ADD DONATION BODY: ${response.body}");
//   //
//   //   if (response.statusCode != 200 && response.statusCode != 201) {
//   //     final decoded = jsonDecode(response.body);
//   //     throw Exception(decoded["message"] ?? "Failed to add donation");
//   //   }
//   //
//   //   final decoded = jsonDecode(response.body);
//   //   return DaanModel.fromJson(decoded["data"]);
//   // }
//
//   static Future<DaanModel> add(DaanModel daan) async {
//     int retryCount = 0;
//     const maxRetries = 2;
//
//     while (retryCount < maxRetries) {
//       try {
//         final uri = Uri.parse(ApiConstants.postdonation);
//
//         var request = http.MultipartRequest("POST", uri);
//         request.headers.addAll(ApiHeaders.headers());
//
//         request.fields['button_text'] = daan.buttonText;
//         request.fields['button_link'] = daan.buttonLink;
//         request.fields['description'] = daan.donation_title;
//
//         if (daan.image.isNotEmpty && !daan.image.startsWith("http")) {
//           request.files.add(
//             await http.MultipartFile.fromPath(
//               "image",
//               daan.image,
//               contentType: MediaType('image', 'jpeg'),
//             ),
//           );
//         }
//
//         print("Attempt ${retryCount + 1}: Sending add donation request...");
//
//         final streamedResponse = await request.send().timeout(const Duration(seconds: 30));
//         final response = await http.Response.fromStream(streamedResponse);
//
//         print("ADD STATUS: ${response.statusCode}");
//         print("ADD BODY: ${response.body}");
//
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           final decoded = jsonDecode(response.body);
//           return DaanModel.fromJson(decoded["data"]);
//         } else {
//           throw Exception("Server error: ${response.statusCode}");
//         }
//       } catch (e) {
//         retryCount++;
//         print("Retry $retryCount / $maxRetries after error: $e");
//         if (retryCount >= maxRetries) {
//           rethrow; // last try fail hone pe error throw
//         }
//         await Future.delayed(Duration(seconds: 2 * retryCount)); // wait before retry
//       }
//     }
//
//     throw Exception("Failed after $maxRetries attempts");
//   }
//   // 🔥 UPDATE DONATION – FULLY FIXED
//   static Future<DaanModel> update(DaanModel daan) async {
//     if (daan.id.isEmpty) throw Exception("ID required");
//
//     final uri = Uri.parse("${ApiConstants.postdonation}/${daan.id}");
//
//     var request = http.MultipartRequest("PUT", uri);  // PUT rakh rahe hain, agar 404 aaye to PATCH try karna
//     request.headers.addAll(ApiHeaders.headers());
//
//     // 🔥 CORRECT FIELD NAMES (backend ke hisaab se)
//     request.fields['button_text'] = daan.buttonText;
//     request.fields['button_link'] = daan.buttonLink;
//     request.fields['description'] = daan.donation_title;
//
//     // 🔥 NAYI IMAGE HAI TO UPLOAD KARO
//     if (daan.image.isNotEmpty && !daan.image.startsWith("http")) {
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           "image",
//           daan.image,
//           contentType: MediaType('image', 'jpeg'),
//         ),
//       );
//     }
//
//     final streamedResponse = await request.send();
//     final response = await http.Response.fromStream(streamedResponse);
//
//     print("UPDATE URL: $uri");
//     print("UPDATE STATUS: ${response.statusCode}");
//     print("UPDATE BODY: ${response.body}");
//
//     if (response.statusCode != 200 && response.statusCode != 201) {
//       final decoded = jsonDecode(response.body);
//       throw Exception(decoded["message"] ?? "Update failed (status ${response.statusCode})");
//     }
//
//     final decoded = jsonDecode(response.body);
//     return DaanModel.fromJson(decoded["data"]);
//   }
// }



// ========================================
// FINAL FIXED SERVICE - SUPPORTS BOTH URL & FILE
// ========================================
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../models/donation_model.dart';
import '../utils/api_header.dart';
import '../utils/apiconstants.dart';

class DaanService {
  // GET ALL DONATIONS
  static Future<List<DaanModel>> getAll() async {
    final uri = Uri.parse(ApiConstants.getdonation);
    final response = await http.get(uri, headers: ApiHeaders.headers());

    print("GET URL: $uri");
    print("STATUS: ${response.statusCode}");

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch donations");
    }

    final decoded = jsonDecode(response.body);
    final List list = decoded["data"]?["user"]?["temple"]?["donation"] ?? [];

    return list.map((e) => DaanModel.fromJson(e)).toList();
  }

  // ADD DONATION - SMART: Detects if URL or File
  static Future<DaanModel> add(DaanModel daan) async {
    try {
      final uri = Uri.parse(ApiConstants.postdonation);

      // Check if image is URL or local file
      if (daan.image.startsWith('http')) {
        // USE JSON BODY (URL)
        return await _addWithJson(uri, daan);
      } else {
        // USE MULTIPART (FILE UPLOAD)
        return await _addWithMultipart(uri, daan);
      }
    } catch (e) {
      print("❌ ADD ERROR: $e");
      rethrow;
    }
  }

  // PRIVATE: Add with JSON body (for URLs)
  static Future<DaanModel> _addWithJson(Uri uri, DaanModel daan) async {
    final body = jsonEncode({
      "donation_title": daan.donation_title,
      "button_label": daan.buttonText,
      "button_url": daan.buttonLink,
      "mobile_image": daan.image, // URL
    });

    print("🚀 ADD URL (JSON): $uri");
    print("📤 BODY: $body");

    final response = await http.post(
      uri,
      headers: ApiHeaders.headers(),
      body: body,
    ).timeout(const Duration(seconds: 30));

    print("📥 STATUS: ${response.statusCode}");
    print("📥 RESPONSE: ${response.body}");

    if (response.statusCode != 200 && response.statusCode != 201) {
      final decoded = jsonDecode(response.body);
      throw Exception(decoded["message"] ?? "Failed to add donation");
    }

    final decoded = jsonDecode(response.body);
    return DaanModel.fromJson(decoded["data"]["donation"]);
  }

  // PRIVATE: Add with multipart (for file upload)
  static Future<DaanModel> _addWithMultipart(Uri uri, DaanModel daan) async {
    var request = http.MultipartRequest("POST", uri);

    // Add authorization
    final token = ApiHeaders.headers()['Authorization'];
    if (token != null) {
      request.headers['Authorization'] = token;
    }

    // Add fields
    request.fields['donation_title'] = daan.donation_title;
    request.fields['button_label'] = daan.buttonText;
    request.fields['button_url'] = daan.buttonLink;

    // Add file
    final file = File(daan.image);
    if (!await file.exists()) {
      throw Exception("Image file not found: ${daan.image}");
    }

    request.files.add(
      await http.MultipartFile.fromPath(
        'mobile_image',
        daan.image,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    print("🚀 ADD URL (MULTIPART): $uri");
    print("📤 FIELDS: ${request.fields}");
    print("📤 FILES: ${request.files.length} file(s)");

    final streamedResponse = await request.send().timeout(const Duration(seconds: 30));
    final response = await http.Response.fromStream(streamedResponse);

    print("📥 STATUS: ${response.statusCode}");
    print("📥 RESPONSE: ${response.body}");

    if (response.statusCode != 200 && response.statusCode != 201) {
      final decoded = jsonDecode(response.body);
      throw Exception(decoded["message"] ?? "Failed to add donation");
    }

    final decoded = jsonDecode(response.body);
    return DaanModel.fromJson(decoded["data"]["donation"]);
  }

  // UPDATE DONATION
  static Future<DaanModel> update(DaanModel daan) async {
    try {
      if (daan.id.isEmpty) throw Exception("ID required");

      final uri = Uri.parse("${ApiConstants.postdonation}/${daan.id}");

      // Check if new file or existing URL
      if (daan.image.startsWith('http')) {
        // USE JSON BODY
        return await _updateWithJson(uri, daan);
      } else {
        // USE MULTIPART (new file)
        return await _updateWithMultipart(uri, daan);
      }
    } catch (e) {
      print("❌ UPDATE ERROR: $e");
      rethrow;
    }
  }

  // PRIVATE: Update with JSON
  static Future<DaanModel> _updateWithJson(Uri uri, DaanModel daan) async {
    final body = jsonEncode({
      "donation_title": daan.donation_title,
      "button_label": daan.buttonText,
      "button_url": daan.buttonLink,
      "mobile_image": daan.image,
    });

    print("🔄 UPDATE URL (JSON): $uri");
    print("📤 BODY: $body");

    final response = await http.put(
      uri,
      headers: ApiHeaders.headers(),
      body: body,
    ).timeout(const Duration(seconds: 30));

    print("📥 STATUS: ${response.statusCode}");
    print("📥 RESPONSE: ${response.body}");

    if (response.statusCode != 200) {
      final decoded = jsonDecode(response.body);
      throw Exception(decoded["message"] ?? "Failed to update");
    }

    final decoded = jsonDecode(response.body);
    return DaanModel.fromJson(decoded["data"]["donation"] ?? decoded["data"]);
  }

  // PRIVATE: Update with multipart
  static Future<DaanModel> _updateWithMultipart(Uri uri, DaanModel daan) async {
    var request = http.MultipartRequest("PUT", uri);

    final token = ApiHeaders.headers()['Authorization'];
    if (token != null) {
      request.headers['Authorization'] = token;
    }

    request.fields['donation_title'] = daan.donation_title;
    request.fields['button_label'] = daan.buttonText;
    request.fields['button_url'] = daan.buttonLink;

    final file = File(daan.image);
    if (await file.exists()) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'mobile_image',
          daan.image,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    print("🔄 UPDATE URL (MULTIPART): $uri");
    print("📤 FIELDS: ${request.fields}");
    print("📤 FILES: ${request.files.length} file(s)");

    final streamedResponse = await request.send().timeout(const Duration(seconds: 30));
    final response = await http.Response.fromStream(streamedResponse);

    print("📥 STATUS: ${response.statusCode}");
    print("📥 RESPONSE: ${response.body}");

    if (response.statusCode != 200) {
      final decoded = jsonDecode(response.body);
      throw Exception(decoded["message"] ?? "Failed to update");
    }

    final decoded = jsonDecode(response.body);
    return DaanModel.fromJson(decoded["data"]["donation"] ?? decoded["data"]);
  }

  // DELETE DONATION
  static Future<bool> delete(String id) async {
    try {
      final uri = Uri.parse("${ApiConstants.postdonation}/$id");
      final response = await http.delete(uri, headers: ApiHeaders.headers());
      return response.statusCode == 200;
    } catch (e) {
      print("DELETE ERROR: $e");
      return false;
    }
  }
}
