// import 'dart:convert';
//
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// class New extends GetxController{
//   Future<void>Login()async{
//     var headers = {
//       'Content-Type': 'application/json'
//     };
//     var request = http.Request('POST', Uri.parse('https://api.gamsgroup.in/spiritual/auth/send-otp'));
//     request.body = json.encode({
//       "phone": "9639850141"
//     });
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//
//
//   }
// }