//
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import '../utils/api_header.dart';
// import '../utils/apiconstants.dart';
// import '../utils/apihelper.dart';
//
// class DarshanService {
//   static Future<Map<String, dynamic>> createDarshan(
//       Map<String, dynamic> body) async {
//     final res = await http.post(
//       Uri.parse(ApiConstants.liveDarshan),
//       headers: ApiHeaders.headers(),
//       body: jsonEncode(body),
//     );
//
//     return ApiHelper.handleResponse(res);
//   }
//
//   static Future<Map<String, dynamic>> updateDarshan(
//       String id,
//       Map<String, dynamic> body,
//       ) async {
//     final res = await http.put(
//       Uri.parse("${ApiConstants.liveDarshan}/$id"),
//       headers: ApiHeaders.headers(),
//       body: jsonEncode(body),
//     );
//
//     return ApiHelper.handleResponse(res);
//   }
//
// }

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
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

    // headers (DO NOT set content-type manually)
    request.headers.addAll(ApiHeaders.headers());

    // fields
    request.fields["title"] = title;
    request.fields["embeddedLink"] = embeddedLink;
    request.fields["status"] = status;

    // file
    request.files.add(
      await http.MultipartFile.fromPath(
        "mobile_image",
        imagePath,
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return jsonDecode(response.body);
  }
}
