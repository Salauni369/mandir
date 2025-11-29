// import 'package:get/get.dart';
// import '../apiservices/api_services.dart';
// import 'package:flutter/material.dart';
// import '../models/register_model.dart';
// import '../services/location_service.dart';
//
// class RegisterController extends GetxController {
//   var isLoading = false.obs;
//   final ApiService _apiService = ApiService();
//
//   Future<void> register({
//     required String fullName,
//     required String email,
//     required String mobile,
//     required String password,
//     required String templeName,
//   }) async {
//     final location = LocationService.getLocation();
//
//     if (location == null || location.isEmpty) {
//       Get.snackbar("Error", "Please select temple location", backgroundColor: Colors.red);
//       return;
//     }
//
//     isLoading(true);
//
//     final user = RegisterModel(
//       fullName: fullName,
//       email: email,
//       mobile: mobile,
//       password: password,
//       templeName: templeName,
//       location: location,
//     );
//
//
//     final success = await _apiService.registerUser(user);
//     isLoading(false);
//
//     if (success) {
//       Get.offAllNamed('/home');
//       Get.snackbar("Success", "Temple Registered!", backgroundColor: Colors.green);
//     } else {
//       Get.snackbar("Failed", "Registration failed. Try again.", backgroundColor: Colors.red);
//     }
//   }
// }