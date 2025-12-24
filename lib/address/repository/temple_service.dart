//
// import 'dart:convert';
// import 'dart:io';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:path/path.dart' as p;
//
// // 🔥 YOUR IMAGE CONVERTER
//
// import '../../utils/imageconverter.dart'; // Update path
//
// class TempleAllService {
//   static final _box = GetStorage();
//   static const String baseUrl = "https://api.gamsgroup.in/spiritual/temple";
//   static const String uploadUrl = "https://api.gamsgroup.in/spiritual/buffer";
//
//   // ============================
//   // 🔥 UPDATE TEMPLE OVERVIEW
//   // ============================
//   static Future<Map<String, dynamic>> updateTempleOverview({
//     required String templeName,
//     String? mainImagePath,
//     String? existingImageUrl,
//     required String aboutUs,
//     required List<Map<String, String>> aboutTemple,
//     required String contactNumber,
//   }) async {
//     String token = _box.read("access_token") ?? "";
//
//     if (token.isEmpty) {
//       throw Exception("No access token found. Please login again.");
//     }
//
//     print("🔐 Token: ${token.substring(0, 20)}...");
//
//     // 🔥 IMAGE DECISION LOGIC
//     String finalImageUrl;
//
//     if (mainImagePath != null && mainImagePath.startsWith('/')) {
//       print("🖼️ Uploading new main image...");
//       finalImageUrl = await _uploadImage(mainImagePath, token);
//       print("✅ New image uploaded: $finalImageUrl");
//     } else if (existingImageUrl != null &&
//         existingImageUrl.isNotEmpty &&
//         existingImageUrl.startsWith('http')) {
//       print("🖼️ Using existing image: $existingImageUrl");
//
//       // 🔥 OPTIMIZE CLOUDINARY URL IF NEEDED
//       finalImageUrl = ImageConverter.optimizeCloudinaryUrl(existingImageUrl);
//       print("🎨 Optimized URL: $finalImageUrl");
//
//     } else {
//       print("⚠️ No image available - using placeholder");
//       finalImageUrl = "https://image-url";
//     }
//
//     final body = {
//       "temple_name": templeName,
//       "main_image": finalImageUrl,
//       "about_us": aboutUs,
//       "about_temple": aboutTemple,
//       "contact_number": contactNumber,
//     };
//
//     print("📤 Sending Body: ${jsonEncode(body)}");
//
//     final response = await http.put(
//       Uri.parse("$baseUrl/overview"),
//       headers: {
//         "Content-Type": "application/json",
//         "Authorization": "Bearer $token",
//       },
//       body: jsonEncode(body),
//     );
//
//     print("📥 Response Status: ${response.statusCode}");
//     print("📥 Response Body: ${response.body}");
//
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception("Update failed: ${response.statusCode} - ${response.body}");
//     }
//   }
//
//   // ============================
//   // 🔥 UPLOAD IMAGE - WITH IMAGE CONVERTER
//   // ============================
//   static Future<String> _uploadImage(String filePath, String token) async {
//     try {
//       print("📤 Starting image upload process...");
//       print("📁 Original file: $filePath");
//
//       // 🔥 STEP 1: CONVERT TO JPG USING YOUR CONVERTER
//       print("🔄 Converting image to JPG format...");
//       final convertedPath = await forceConvertToJpg(filePath);
//       print("✅ Image converted: $convertedPath");
//
//       // Check converted file
//       final file = File(convertedPath);
//       if (!await file.exists()) {
//         throw Exception("Converted file does not exist: $convertedPath");
//       }
//
//       final fileSize = await file.length();
//       print("📊 Converted file size: $fileSize bytes");
//       print("📎 File extension: ${p.extension(convertedPath)}");
//
//       // 🔥 STEP 2: UPLOAD WITH PROPER MIME TYPE
//       print("🌐 Upload URL: $uploadUrl");
//
//       var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
//       request.headers['Authorization'] = 'Bearer $token';
//
//       // 🔥 ADD FILE WITH JPEG CONTENT TYPE
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           'image',
//           convertedPath,
//           contentType: MediaType('image', 'jpeg'), // 🔥 FORCE JPEG
//         ),
//       );
//
//       print("📤 Sending upload request...");
//
//       // Send request
//       var response = await request.send();
//       var responseBody = await response.stream.bytesToString();
//
//       print("📥 Upload Response Status: ${response.statusCode}");
//       print("📥 Upload Response Body: $responseBody");
//
//       // 🔥 STEP 3: CLEANUP TEMPORARY FILE
//       try {
//         await file.delete();
//         print("🗑️ Temporary file deleted");
//       } catch (e) {
//         print("⚠️ Could not delete temp file: $e");
//       }
//
//       // 🔥 STEP 4: PROCESS RESPONSE
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final json = jsonDecode(responseBody);
//
//         // Try multiple possible response formats
//         String? imageUrl = json['data']?['url'] ??
//             json['data']?['image'] ??
//             json['data']?['image_url'] ??
//             json['imageUrl'] ??
//             json['url'] ??
//             json['image'];
//
//         if (imageUrl != null && imageUrl.isNotEmpty) {
//           print("✅ Image uploaded successfully: $imageUrl");
//
//           // 🔥 OPTIMIZE CLOUDINARY URL IF IT'S A CLOUDINARY LINK
//           if (imageUrl.contains("/upload/")) {
//             final optimizedUrl = ImageConverter.optimizeCloudinaryUrl(imageUrl);
//             print("🎨 Optimized Cloudinary URL: $optimizedUrl");
//             return optimizedUrl;
//           }
//
//           return imageUrl;
//         } else {
//           print("⚠️ Response JSON: ${jsonEncode(json)}");
//           throw Exception("Image URL not found in response: $responseBody");
//         }
//       } else {
//         throw Exception(
//             "Image upload failed: ${response.statusCode} - $responseBody");
//       }
//     } catch (e) {
//       print("❌ Image upload error: $e");
//       rethrow;
//     }
//   }
// }


import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import '../../utils/api_header.dart';

// 🔥 IMAGE CONVERTER FUNCTIONS
Future<String> forceConvertToJpg(String originalPath) async {
  final file = File(originalPath);
  final bytes = await file.readAsBytes();

  final decoded = img.decodeImage(bytes);
  if (decoded == null) {
    throw Exception("Image decode failed");
  }

  final dir = await getTemporaryDirectory();
  final newPath = "${dir.path}/upload_${DateTime.now().millisecondsSinceEpoch}.jpg";

  final jpgFile = File(newPath)
    ..writeAsBytesSync(
      img.encodeJpg(decoded, quality: 85),
    );

  return jpgFile.path;
}

class ImageConverter {
  ImageConverter._();

  static String optimizeCloudinaryUrl(String url) {
    if (!url.contains("/upload/")) return url;
    return url.replaceFirst("/upload/", "/upload/f_png/");
  }
}

// 🔥 MAIN SERVICE CLASS
class TempleAllService {
  static final _box = GetStorage();
  static const String baseUrl = "https://api.gamsgroup.in/spiritual/temple";
  static const String uploadUrl = "https://api.gamsgroup.in/spiritual/buffer";

  // ============================
  // 🔥 1. UPDATE TEMPLE OVERVIEW
  // ============================
  static Future<Map<String, dynamic>> updateTempleOverview({
    required String templeName,
    String? mainImagePath,
    String? existingImageUrl,
    required String aboutUs,
    required List<Map<String, String>> aboutTemple,
    required String contactNumber,
  }) async {
    String token = _box.read("access_token") ?? "";

    if (token.isEmpty) {
      throw Exception("No access token found. Please login again.");
    }

    print("🔐 Token: ${token.substring(0, 20)}...");

    // IMAGE LOGIC
    String finalImageUrl;

    if (mainImagePath != null && mainImagePath.startsWith('/')) {
      print("🖼️ Uploading new main image...");
      finalImageUrl = await _uploadImage(mainImagePath, token);
      print("✅ New image uploaded: $finalImageUrl");
    } else if (existingImageUrl != null &&
        existingImageUrl.isNotEmpty &&
        existingImageUrl.startsWith('http')) {
      print("🖼️ Using existing image: $existingImageUrl");
      finalImageUrl = ImageConverter.optimizeCloudinaryUrl(existingImageUrl);
      print("🎨 Optimized URL: $finalImageUrl");
    } else {
      print("⚠️ No image available - using placeholder");
      finalImageUrl = "https://image-url";
    }

    final body = {
      "temple_name": templeName,
      "main_image": finalImageUrl,
      "about_us": aboutUs,
      "about_temple": aboutTemple,
      "contact_number": contactNumber,
    };

    print("📤 Overview Body: ${jsonEncode(body)}");

    final response = await http.put(
      Uri.parse("$baseUrl/overview"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    print("📥 Overview Response Status: ${response.statusCode}");
    print("📥 Overview Response Body: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Update failed: ${response.statusCode} - ${response.body}");
    }
  }

  // ============================
  // 🔥 2. UPDATE TEMPLE TIMING
  // ============================
  static Future<Map<String, dynamic>> updateTempleTiming({
    required List<Map<String, String>> darshan,
    required List<Map<String, String>> aarti,
  }) async {
    String token = _box.read("access_token") ?? "";

    if (token.isEmpty) {
      throw Exception("No access token found. Please login again.");
    }

    print("🔐 Token: ${token.substring(0, 20)}...");

    final body = {
      "darshan": darshan,
      "aarti": aarti,
    };

    print("📤 Timing Body: ${jsonEncode(body)}");

    final response = await http.put(
      Uri.parse("$baseUrl/timing"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    print("📥 Timing Response Status: ${response.statusCode}");
    print("📥 Timing Response Body: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          "Timing update failed: ${response.statusCode} - ${response.body}");
    }
  }

  // ============================
  // 🔥 3. UPDATE TEMPLE SOCIAL
  // ============================
  static Future<Map<String, dynamic>> updateTempleSocial({
    required String facebook,
    required String instagram,
    required String youtube,
    required String linkedin,
  }) async {
    String token = _box.read("access_token") ?? "";

    if (token.isEmpty) {
      throw Exception("No access token found. Please login again.");
    }

    print("🔐 Token: ${token.substring(0, 20)}...");

    final body = {
      "facebook": facebook,
      "instagram": instagram,
      "youtube": youtube,
      "linkedin": linkedin,
    };

    print("📤 Social Body: ${jsonEncode(body)}");

    final response = await http.put(
      Uri.parse("$baseUrl/social"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    print("📥 Social Response Status: ${response.statusCode}");
    print("📥 Social Response Body: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Social update failed: ${response.statusCode} - ${response.body}");
    }
  }

  // ============================
  // 🔥 PRIVATE: UPLOAD IMAGE
  // ============================
  static Future<String> _uploadImage(String filePath, String token) async {
    try {
      print("📤 Starting image upload process...");
      print("📁 Original file: $filePath");

      // Convert to JPG
      print("🔄 Converting image to JPG format...");
      final convertedPath = await forceConvertToJpg(filePath);
      print("✅ Image converted: $convertedPath");

      // Check file
      final file = File(convertedPath);
      if (!await file.exists()) {
        throw Exception("Converted file does not exist: $convertedPath");
      }

      final fileSize = await file.length();
      print("📊 Converted file size: $fileSize bytes");

      // Upload
      print("🌐 Upload URL: $uploadUrl");

      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
      request.headers['Authorization'] = 'Bearer $token';

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          convertedPath,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      print("📤 Sending upload request...");

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("📥 Upload Response Status: ${response.statusCode}");
      print("📥 Upload Response Body: $responseBody");

      // Cleanup
      try {
        await file.delete();
        print("🗑️ Temporary file deleted");
      } catch (e) {
        print("⚠️ Could not delete temp file: $e");
      }

      // Process response
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(responseBody);

        String? imageUrl = json['data']?['url'] ??
            json['data']?['image'] ??
            json['imageUrl'] ??
            json['url'] ??
            json['image'];

        if (imageUrl != null && imageUrl.isNotEmpty) {
          print("✅ Image uploaded successfully: $imageUrl");

          if (imageUrl.contains("/upload/")) {
            final optimizedUrl = ImageConverter.optimizeCloudinaryUrl(imageUrl);
            print("🎨 Optimized Cloudinary URL: $optimizedUrl");
            return optimizedUrl;
          }

          return imageUrl;
        } else {
          throw Exception("Image URL not found in response: $responseBody");
        }
      } else {
        throw Exception(
            "Image upload failed: ${response.statusCode} - $responseBody");
      }
    } catch (e) {
      print("❌ Image upload error: $e");
      rethrow;
    }
  }
  /// Update temple gallery images
  /// Update temple gallery images
  static Future<Map<String, dynamic>> updateTempleGallery({
    required List<String> localImagePaths,
    required List<String> existingUrls,
  }) async {
    try {
      List<String> finalUrls = List.from(existingUrls);

      String token = _box.read("access_token") ?? "";

      if (token.isEmpty) {
        throw Exception("No access token found");
      }

      for (String path in localImagePaths) {
        if (path.startsWith('/')) {
          print("Uploading gallery image: $path");

          final jpgPath = await forceConvertToJpg(path);
          print("Converted to JPG: $jpgPath");

          final uploadedUrl = await _uploadImage(jpgPath, token); // <-- YE CHANGE KIYA

          if (uploadedUrl != null && uploadedUrl.isNotEmpty) {
            final optimized = ImageConverter.optimizeCloudinaryUrl(uploadedUrl);
            finalUrls.add(optimized);
            print("Uploaded & optimized: $optimized");

            // Cleanup
            try {
              await File(jpgPath).delete();
            } catch (_) {}
          }
        } else if (path.startsWith('http')) {
          finalUrls.add(path);
        }
      }

      final body = {"gallery_images": finalUrls};

      print("Sending gallery update: $body");

      final response = await http.put(
        Uri.parse("https://api.gamsgroup.in/spiritual/temple/gallery"),
        headers: ApiHeaders.headers(),
        body: jsonEncode(body),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        throw jsonResponse["message"] ?? "Gallery update failed";
      }
    } catch (e) {
      print("Gallery Update Error: $e");
      rethrow;
    }
  }

}