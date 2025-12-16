// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ApiHelper {
//   static Map<String, dynamic> handleResponse(http.Response res) {
//     print(" Status Code: ${res.statusCode}");
//     print(" Response Body: ${res.body}");
//
//     switch (res.statusCode) {
//       case 200:
//         return {
//           "success": true,
//           "message": "Request successful",
//           "data": jsonDecode(res.body)
//         };
//
//       case 201:
//         return {
//           "success": true,
//           "message": "Resource created successfully",
//           "data": jsonDecode(res.body)
//         };
//
//       case 400:
//         return {
//           "success": false,
//           "message": "Bad Request: Invalid input",
//           "error": res.body
//         };
//
//       case 401:
//         return {
//           "success": false,
//           "message": "Unauthorized: Please login again",
//           "error": res.body
//         };
//
//
//
//       case 404:
//         return {
//           "success": false,
//           "message": "Not Found: Endpoint or resource missing",
//           "error": res.body
//         };
//
//       case 500:
//         return {
//           "success": false,
//           "message": "Server Error: Something went wrong",
//           "error": res.body
//         };
//
//       default:
//         return {
//           "success": false,
//           "message": "Unexpected Error: ${res.statusCode}",
//           "error": res.body
//         };
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Map<String, dynamic> handleResponse(http.Response res) {
    try {
      final body = jsonDecode(res.body);

      return {
        "success": body["success"] ?? false,
        "statusCode": body["statusCode"] ?? res.statusCode,
        "message": body["message"] ?? "No message",
        "data": body["data"],
      };
    } catch (e) {
      return {
        "success": false,
        "statusCode": res.statusCode,
        "message": "Invalid server response",
        "data": null,
      };
    }
  }
}
