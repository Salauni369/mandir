

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> uploadImageAndGetUrl(String imagePath, String token) async {
  final request = http.MultipartRequest(
    'POST',
    Uri.parse('https://api.gamsgroup.in/spiritual/buffer'),
  );

  // 🔴 IMPORTANT: multipart me Content-Type mat daal
  request.headers['Authorization'] = 'Bearer $token';

  request.files.add(
    await http.MultipartFile.fromPath(
      'image',
      imagePath,
    ),
  );

  final response = await request.send();
  final responseBody = await response.stream.bytesToString();

  if (response.statusCode == 200) {
    final decoded = jsonDecode(responseBody);

    // 👇 assume backend ye format de raha hai
    // { success: true, data: { url: "https://..." } }
    final imageUrl = decoded['data']?['url'];

    if (imageUrl == null || imageUrl.toString().isEmpty) {
      throw "Image URL not found in response";
    }

    return imageUrl.toString();
  } else {
    throw "Image upload failed: ${response.statusCode} $responseBody";
  }
}
