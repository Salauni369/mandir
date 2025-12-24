// import 'dart:convert';
// import 'dart:io';
//
// import 'package:http/http.dart' as http;
//
// import '../utils/api_header.dart';
// import '../utils/apiconstants.dart';
// import 'package:path/path.dart' as p;
//
//
// class TempleService {
//   /// Update temple overview with direct multipart image upload (no Cloudinary)
//   static Future<Map<String, dynamic>> updateTempleOverview({
//     required String name,
//     required String about,
//     required String contactNumber,
//     required String? mainImagePath,
//     required Map<String, dynamic> timings,
//     required Map<String, String> socialLinks,
//     required List<String> galleryImages,
//     required List<Map<String, String>> additionalInfo,
//   }) async {
//     try {
//       final uri = Uri.parse("https://api.gamsgroup.in/spiritual/temple/overview");
//
//       final request = http.MultipartRequest('PUT', uri);
//
//       //                                                                                 Headers (token)
//       request.headers.addAll(ApiHeaders.headers());
//
//       // Fields
//       request.fields['name'] = name.trim();
//       request.fields['about'] = about.trim();
//       request.fields['contact_number'] = contactNumber.trim();
//
//       //                                                                                      Timings as JSON string
//       request.fields['timings'] = jsonEncode(timings);
//
//       // Social links
//       if (socialLinks.isNotEmpty) {
//         request.fields['social_links'] = jsonEncode(socialLinks);
//       }
//
//       // Gallery images
//       if (galleryImages.isNotEmpty) {
//         request.fields['gallery_images'] = jsonEncode(galleryImages);
//       }
//
//       // Additional info
//       if (additionalInfo.isNotEmpty) {
//         request.fields['additional_info'] = jsonEncode(additionalInfo);
//       }
//
//       // 🔥 New image upload (if picked)
//       if (mainImagePath != null &&
//           mainImagePath.isNotEmpty &&
//           mainImagePath.startsWith("/")) {
//         final file = File(mainImagePath);
//         if (await file.exists()) {
//           request.files.add(
//             await http.MultipartFile.fromPath(
//               'main_image', // ← Backend mein ye field name hona chahiye (confirm kar lena)
//               mainImagePath,
//               filename: p.basename(mainImagePath),
//             ),
//           );
//           print("Image attached: $mainImagePath");
//         }
//       }
//
//       print("Sending multipart request to backend...");
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);
//
//       final jsonResponse = jsonDecode(response.body);
//
//       print("Status: ${response.statusCode}");
//       print("Response: $jsonResponse");
//
//       if (response.statusCode == 200) {
//         return jsonResponse;
//       } else {
//         throw jsonResponse["message"] ?? "Update failed";
//       }
//     } catch (e) {
//       print("TempleService Error: $e");
//       rethrow;
//     }
//   }
// }