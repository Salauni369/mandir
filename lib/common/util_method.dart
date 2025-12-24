// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:zamboree_devotion/common/token_storage.dart';
//
// class UtilMethod {
//   static const String _url = "https://api.gamsgroup.in/spiritual/buffer";
//
//   static Future<String> uploadImageAndGetUrl(String imagePath) async {
//     final uri = Uri.parse(_url);
//     final request = http.MultipartRequest('POST', uri);
//
//     final token = TokenStorage.accessToken;
//     request.headers['Authorization'] = 'Bearer $token';
//
//     final file = await http.MultipartFile.fromPath(
//       'image',
//       imagePath,
//       contentType: http.MediaType('image', 'png'),
//     );
//
//     request.files.add(file);
//
//     print("🚀 IMAGE UPLOAD START");
//     print("➡️ URL      : $uri");
//     print("➡️ HEADERS  : ${request.headers}");
//     print("➡️ FILE    : field=${file.field}, path=$imagePath");
//     print("➡️ FILE SIZE: ${await File(imagePath).length()} bytes");
//     print("➡️ MIME     : image/png");
//
//     final response = await request.send();
//     final responseBody = await response.stream.bytesToString();
//
//     print("⬅️ STATUS  : ${response.statusCode}");
//     print("⬅️ RESPONSE: $responseBody");
//
//     // 🔥 FIX IS HERE
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final decoded = jsonDecode(responseBody);
//       final imageUrl = decoded['data']?['url']?.toString() ?? "";
//
//       if (imageUrl.isEmpty) {
//         throw "❌ Image URL not found in response";
//       }
//
//       print("✅ IMAGE URL: $imageUrl");
//       return imageUrl;
//     } else {
//       throw "❌ Image upload failed: ${response.statusCode} $responseBody";
//     }
//   }
//
//
// }

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../utils/api_header.dart';
import '../utils/apiconstants.dart';

class UtilMethod {
  // =========================
  // UPLOAD IMAGE AND GET URL
  // =========================
  static Future<String> uploadImageAndGetUrl(String imagePath) async {
    final uri = Uri.parse(ApiConstants.buffer); // Your upload endpoint

    try {
      print("🚀 IMAGE UPLOAD START");
      print("➡️ URL: $uri");
      print("➡️ FILE PATH: $imagePath");

      // Create multipart request
      var request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers.addAll(ApiHeaders.headers());

      // Get file
      final file = File(imagePath);

      if (!await file.exists()) {
        throw Exception("File does not exist at path: $imagePath");
      }

      // Get file size
      final fileSize = await file.length();
      print("➡️ FILE SIZE: $fileSize bytes");

      // Check file size (2MB = 2097152 bytes)
      if (fileSize > 2097152) {
        throw Exception("File size exceeds 2MB limit");
      }

      // Determine mime type
      String mimeType = 'image/png';
      if (imagePath.toLowerCase().endsWith('.jpg') ||
          imagePath.toLowerCase().endsWith('.jpeg')) {
        mimeType = 'image/jpeg';
      } else if (imagePath.toLowerCase().endsWith('.gif')) {
        mimeType = 'image/gif';
      }

      print("➡️ MIME TYPE: $mimeType");

      // Add file to request
      final multipartFile = await http.MultipartFile.fromPath(
        'image', // Field name (check your API documentation)
        imagePath,
        contentType: MediaType.parse(mimeType),
      );

      request.files.add(multipartFile);

      // Send request
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 60),
      );

      // Get response
      final response = await http.Response.fromStream(streamedResponse);

      print("⬅️ STATUS: ${response.statusCode}");
      print("⬅️ RESPONSE: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body);

        // ✅ Extract URL from response
        // Adjust this based on your API response structure
        final imageUrl = decoded["data"]["url"] ?? decoded["url"];

        if (imageUrl == null || imageUrl.isEmpty) {
          throw Exception("Image URL not found in response");
        }

        print("✅ IMAGE URL: $imageUrl");
        return imageUrl;
      } else {
        final decoded = jsonDecode(response.body);
        throw Exception(decoded["message"] ?? "Image upload failed");
      }
    } catch (e) {
      print("❌ IMAGE UPLOAD ERROR: $e");
      rethrow;
    }
  }

  // =========================
  // VALIDATE IMAGE FILE
  // =========================
  static Future<bool> validateImageFile(String path) async {
    try {
      final file = File(path);

      if (!await file.exists()) {
        return false;
      }

      final fileSize = await file.length();

      // Check size (2MB limit)
      if (fileSize > 2097152) {
        return false;
      }

      // Check extension
      final validExtensions = ['.jpg', '.jpeg', '.png', '.gif'];
      final hasValidExtension = validExtensions.any(
            (ext) => path.toLowerCase().endsWith(ext),
      );

      return hasValidExtension;
    } catch (e) {
      print("❌ Validation error: $e");
      return false;
    }
  }

  // =========================
  // GET IMAGE SIZE IN MB
  // =========================
  static Future<double> getImageSizeInMB(String path) async {
    try {
      final file = File(path);
      if (!await file.exists()) {
        return 0;
      }
      final bytes = await file.length();
      return bytes / (1024 * 1024); // Convert to MB
    } catch (e) {
      print("❌ Error getting file size: $e");
      return 0;
    }
  }
}
