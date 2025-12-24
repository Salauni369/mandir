// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../models/get_address_model.dart';
// import '../repository/get_address_repo.dart';
//
// class GetAddressController extends GetxController {
//   final GetAddressRepository _repo = GetAddressRepository();
//
//   /// 🔹 Observables
//   var getAddressDataModel = <AddressData>[].obs;
//   var errorMessage = "".obs;
//   var isLoading = false.obs;
//
//   /// 🔹 Current Location
//   LatLng newLatLng = const LatLng(0.0, 0.0);
//   var selectedAddress = Rx<AddressData?>(null);
//
//   void selectAddress(AddressData address) {
//     selectedAddress.value = address;
//     update();
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     getAddressListApi();
//   }
//
//   String capitalize(String? text) {
//     if (text == null || text.isEmpty) return "";
//     return text[0].toUpperCase() + text.substring(1).toLowerCase();
//   }
//
//   /// 🔹 Fetch Address List and Sort by Distance
//   Future<void> getAddressListApi() async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = "";
//
//       final response = await _repo.fetchAddressRepo();
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final dataList = response.data ?? [];
//
//         // Calculate distance for each address
//         for (final address in dataList) {
//           if (address.latitude != null && address.longitude != null) {
//             final lat = double.tryParse(address.latitude!) ?? 0.0;
//             final lng = double.tryParse(address.longitude!) ?? 0.0;
//
//             final distanceInMeters = Geolocator.distanceBetween(
//               newLatLng.latitude,
//               newLatLng.longitude,
//               lat,
//               lng,
//             );
//
//             // Convert to km
//             address.distanceInKm = distanceInMeters / 1000;
//           } else {
//             // If no coordinates, set distance to infinity
//             address.distanceInKm = double.infinity;
//           }
//         }
//
//         // Sort by nearest distance first
//         dataList.sort((a, b) => (a.distanceInKm ?? double.infinity)
//             .compareTo(b.distanceInKm ?? double.infinity));
//
//         // Update observable list
//         getAddressDataModel.assignAll(dataList);
//         getAddressDataModel.refresh();
//
//
//         if (dataList.isNotEmpty && selectedAddress.value == null) {
//           selectedAddress.value = dataList.first;
//         }
//
//         update();
//
//         // Set message if available
//         if (response.message != null && response.message!.isNotEmpty) {
//           errorMessage.value = response.message!;
//         }
//       } else {
//         // If API fails
//         getAddressDataModel.clear();
//         errorMessage.value = "No address found";
//       }
//     } catch (e, s) {
//       // Catch any exception
//       errorMessage.value = "Failed to load addresses: $e";
//       getAddressDataModel.clear();
//       print("getAddressListApi Error: $e\n$s");
//     } finally {
//       // Always stop loader
//       isLoading.value = false;
//     }
//   }
//
//   /// 🔹 Detect and store current location
//   Future<void> initCurrentLocation() async {
//     try {
//       final isEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!isEnabled) {
//         // AnimationSnackBar.openTopSnackBar(
//         //   message: "⚠️ Please enable location services",
//         //   type: SnackBarType.warning,
//         // );
//         return;
//       }
//
//       var permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           print("Location permission denied");
//           return;
//         }
//       }
//
//       if (permission == LocationPermission.deniedForever) {
//         print(
//             "Location permission permanently denied.\nEnable it in settings.");
//         return;
//       }
//
//       final position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//
//       newLatLng = LatLng(position.latitude, position.longitude);
//     } catch (e) {
//       print('❌ Failed to detect location: $e');
//     }
//   }
//
//   String getDistance(double? distanceInMeters) {
//     if (distanceInMeters == null || distanceInMeters.isInfinite) {
//       return "N/A";
//     }
//
//     // If distance is less than 700 meters → show in meters
//     if (distanceInMeters < 700) {
//       return "${distanceInMeters.toStringAsFixed(0)} m";
//     } else {
//       // Otherwise show in kilometers
//       double distanceInKm = distanceInMeters / 1000;
//       return "${distanceInKm.toStringAsFixed(1)} km";
//     }
//   }
// }
