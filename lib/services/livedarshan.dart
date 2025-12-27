// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import '../utils/api_header.dart';
// import '../utils/apiconstants.dart';
//
// class DarshanService {
//   static Future<Map<String, dynamic>> createDarshanMultipart({
//     required String title,
//     required String embeddedLink,
//     required String imagePath,
//     required String status,
//   }) async {
//     final uri = Uri.parse(ApiConstants.liveDarshan);
//     final request = http.MultipartRequest("POST", uri);
//     request.headers.addAll(ApiHeaders.headers());
//     request.fields["title"] = title;
//     request.fields["embeddedLink"] = embeddedLink;
//
//     request.fields["status"] = status;
//     request.files.add(
//       await http.MultipartFile.fromPath(
//         "mobile_image",
//         imagePath,
//         contentType: MediaType('image', 'jpeg'),
//       ),
//     );
//
//     try {
//       print("🚀 Sending multipart request...");
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);
//
//       print("Status Code: ${response.statusCode}");
//       print("Response Body: ${response.body}");
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return jsonDecode(response.body);
//       } else {
//         return jsonDecode(response.body);
//       }
//     } catch (e) {
//       print("❌ Exception during upload: $e");
//       return {
//         "success": false,
//         "message": "Network error: $e",
//       };
//
//
//     }
//
//   }
//
// }

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../utils/api_header.dart';
import '../utils/apiconstants.dart';

class DarshanService {

  // =========================
  // CREATE LIVE DARSHAN
  // =========================
  static Future<Map<String, dynamic>> createDarshanMultipart({
    required String title,
    required String embeddedLink,
    required String imagePath, // LOCAL FILE PATH
    required String status,
  }) async {
    final uri = Uri.parse(ApiConstants.liveDarshan);
    final request = http.MultipartRequest("POST", uri);

    request.headers.addAll(ApiHeaders.headers());

    request.fields["title"] = title;
    request.fields["embeddedLink"] = embeddedLink;
    request.fields["status"] = status;

    request.files.add(
      await http.MultipartFile.fromPath(
        "mobile_image",
        imagePath,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    try {
      print("🚀 CREATE DARSHAN REQUEST");
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      return jsonDecode(response.body);
    } catch (e) {
      print("❌ CREATE ERROR: $e");
      return {
        "success": false,
        "message": "Network error: $e",
      };
    }
  }

  // // =========================
  // // UPDATE LIVE DARSHAN
  // // =========================
  // static Future<Map<String, dynamic>> updateDarshanMultipart({
  //   required String id,
  //   required String title,
  //   required String embeddedLink,
  //   required String imagePath, // LOCAL FILE PATH ONLY
  //   required String status,
  //
  //   String ? imagePath,
  //   String ? imageUrl
  // }) async {
  //   final uri = Uri.parse("${ApiConstants.liveDarshan}/$id");
  //   final request = http.MultipartRequest("PUT", uri);
  //
  //   request.headers.addAll(ApiHeaders.headers());
  //
  //   request.fields["_id"] = id;
  //   request.fields["title"] = title;
  //   request.fields["embeddedLink"] = embeddedLink;
  //
  //   request.fields["status"] = status;
  //
  //   request.files.add(
  //     await http.MultipartFile.fromPath(
  //       "mobile_image",
  //       imagePath,
  //       contentType: MediaType('image', 'jpeg'),
  //     ),
  //   );
  //
  //   try {
  //     print("🚀 UPDATE DARSHAN REQUEST");
  //     final streamedResponse = await request.send();
  //     final response = await http.Response.fromStream(streamedResponse);
  //
  //     print("STATUS: ${response.statusCode}");
  //     print("BODY: ${response.body}");
  //
  //     return jsonDecode(response.body);
  //   } catch (e) {
  //     print("❌ UPDATE ERROR: $e");
  //     return {
  //       "success": false,
  //       "message": "Network error: $e",
  //     };
  //   }
  // }

  static Future<Map<String, dynamic>> updateDarshanMultipart({
    required String id,
    required String title,
    required String embeddedLink,
    required String status,

    String? imagePath, // LOCAL FILE (optional)
    String? imageUrl,  // CLOUDINARY URL (optional)
  }) async {
    final uri = Uri.parse("${ApiConstants.liveDarshan}/$id");
    final request = http.MultipartRequest("POST", uri);

    request.headers.addAll(ApiHeaders.headers());

    request.fields["_id"] = id;
    request.fields["title"] = title;
    request.fields["embeddedLink"] = embeddedLink;
    request.fields["status"] = status;

    // ---- IMAGE HANDLING ----
    if (imagePath != null && imagePath.isNotEmpty) {
      // Case 1: User picked new image
      request.files.add(
        await http.MultipartFile.fromPath(
          "mobile_image",
          imagePath,
        ),
      );
      print("📤 IMAGE FILE SENT");
    } else if (imageUrl != null && imageUrl.isNotEmpty) {
      // Case 2: Image unchanged
      request.fields["mobile_image"] = imageUrl;
      print("📤 IMAGE URL SENT");
    } else {
      throw Exception("Image is required");
    }

    try {
      print("🚀 UPDATE DARSHAN REQUEST");
      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      return jsonDecode(response.body);
    } catch (e) {
      print("❌ UPDATE ERROR: $e");
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }

}
