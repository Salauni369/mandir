import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'api_header.dart';
import 'apiconstants.dart';

// ✅ Keep your existing function
Future<String> forceConvertToJpg(String originalPath) async {
  final file = File(originalPath);
  final bytes = await file.readAsBytes();

  final decoded = img.decodeImage(bytes);
  if (decoded == null) {
    throw Exception("Image decode failed");
  }

  final dir = await getTemporaryDirectory();
  final newPath =
      "${dir.path}/upload_${DateTime.now().millisecondsSinceEpoch}.jpg";

  final jpgFile = File(newPath)
    ..writeAsBytesSync(img.encodeJpg(decoded, quality: 85));

  return jpgFile.path;
}

class ImageConverter {
  ImageConverter._();

  // ✅ Keep your existing function (for donation section)
  static String optimizeCloudinaryUrl(String url) {
    if (!url.contains("/upload/")) return url;

    return url.replaceFirst("/upload/", "/upload/f_png/");
  }

  // // 🔥 NEW: Upload image to Cloudinary and return URL
  // static Future<String> uploadToCloudinary(String imagePath) async {
  //   try {
  //     print("📤 Starting Cloudinary upload: $imagePath");
  //
  //     // Convert to JPG first
  //     final jpgPath = await forceConvertToJpg(imagePath);
  //     final file = File(jpgPath);
  //
  //     // Your Cloudinary credentials
  //     const cloudName = "YOUR_CLOUD_NAME"; // ⚠️ Replace with your cloud name
  //     const uploadPreset = "YOUR_UPLOAD_PRESET"; // ⚠️ Replace with your preset
  //
  //     final uri = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");
  //
  //     final request = http.MultipartRequest('POST', uri)
  //       ..fields['upload_preset'] = uploadPreset
  //       ..files.add(await http.MultipartFile.fromPath('file', file.path));
  //
  //     print("🌐 Uploading to Cloudinary...");
  //     final response = await request.send();
  //     final responseBody = await response.stream.bytesToString();
  //
  //     print("⬅️ Cloudinary Response: ${response.statusCode}");
  //     print("⬅️ Response Body: $responseBody");
  //
  //     if (response.statusCode != 200) {
  //       throw Exception("Upload failed: $responseBody");
  //     }
  //
  //     final json = jsonDecode(responseBody);
  //     final url = json['secure_url'] as String;
  //
  //     print("✅ Upload successful: $url");
  //
  //     // Clean up temp file
  //     try {
  //       await file.delete();
  //     } catch (e) {
  //       print("⚠️ Failed to delete temp file: $e");
  //     }
  //
  //     return url;
  //   } catch (e) {
  //     print("❌ Cloudinary upload error: $e");
  //     rethrow;
  //   }
  // }

  //class ImageConverter {
  //ImageConverter._();

  // =========================
  // UPLOAD IMAGE → BACKEND → CLOUDINARY
  // =========================
  static Future<String> uploadToCloudinary(String filePath) async {
    final uri = Uri.parse(ApiConstants.buffer);

    print("📤 Starting image upload: $filePath");
    print("🌐 Upload URL: $uri");

    final request = http.MultipartRequest("POST", uri);

    request.headers.addAll(ApiHeaders.headers());

    request.files.add(
      await http.MultipartFile.fromPath(
        "file",
        filePath,
        contentType: http.MediaType("image", "jpeg"),
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print("⬅️ STATUS: ${response.statusCode}");
    print("⬅️ BODY: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Image upload failed");
    }

    final decoded = jsonDecode(response.body);

    final url = decoded["data"]?["url"];

    if (url == null || !url.contains("res.cloudinary.com")) {
      throw Exception("Invalid Cloudinary URL");
    }

    print("✅ Uploaded Cloudinary URL: $url");
    return url;
  }
}
