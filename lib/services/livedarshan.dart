import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../utils/api_header.dart';
import '../utils/apiconstants.dart';

class DarshanService {
  static Future<Map<String, dynamic>> createDarshanMultipart({
    required String title,
    required String embeddedLink,
    required String imagePath,
    required String status,
  }) async {
    final uri = Uri.parse(ApiConstants.liveDarshan);

    final request = http.MultipartRequest("POST", uri);

    // Headers (token etc. jo ApiHeaders mein hai)
    request.headers.addAll(ApiHeaders.headers());

    // Text fields
    request.fields["title"] = title;
    request.fields["embeddedLink"] = embeddedLink;
    request.fields["status"] = status;

    // 🔥 YE PART CHANGE KIYA – contentType add kiya
    request.files.add(
      await http.MultipartFile.fromPath(
        "mobile_image",                  // backend mein exactly ye hi field name hona chahiye
        imagePath,
        contentType: MediaType('image', 'jpeg'),  // YE LINE SE ERROR KHATAM!
      ),
    );

    try {
      print("🚀 Sending multipart request...");
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        // Error case mein bhi body return kar do taaki UI mein dikha sake
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("❌ Exception during upload: $e");
      return {
        "success": false,
        "message": "Network error: $e",
      };
    }
  }
}