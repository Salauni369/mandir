// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:zamboree/utils/api_manager/animation_snackbar.dart';
// import '../../location/models/location_suggestion.dart';
// import '../../location/services/places_api_service.dart';
//
// class SelectLocationController extends GetxController {
//   // 🔹 Observables
//   Rx<LatLng> currentLatLng = const LatLng(0.0, 0.0).obs;
//   RxString locationTitle = 'Loading..'.obs;
//   RxString locationAddress = 'Loading..'.obs;
//   RxString locationDistance = ''.obs;
//   RxDouble distanceFromUser = 0.0.obs;
//
//   // 🔹 Initialize
//   @override
//   void onInit() {
//     super.onInit();
//     initCurrentLocation();
//   }
//
//   RxList<Map<String, dynamic>> searchResults = <Map<String, dynamic>>[].obs;
//   RxBool isSearching = false.obs;
//   TextEditingController searchController = TextEditingController();
//
//   final PlacesApiService _placesService = PlacesApiService();
//   GoogleMapController? mapController;
//
//   // 🔹 Map callbacks
//   void onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   // 🔵 Dynamic circle list
//   RxList<Map<String, dynamic>> circleList = <Map<String, dynamic>>[
//     {
//       'id': 'selected_area',
//       'center': const LatLng(0.0, 0.0),
//       'radius': 80.0,
//     }
//   ].obs;
//
//
//   void onCameraMove(CameraPosition position) {
//     currentLatLng.value = position.target;
//
//     // 🔵 Update circle center dynamically
//     if (circleList.isNotEmpty) {
//       circleList[0]['center'] = position.target;
//     }
//   }
//
//
//   Future<void> onCameraIdle() async {
//     await _updateAddressFromLatLng(currentLatLng.value);
//     await updateDistanceFromUser();
//   }
//
//   Future<void> animateToLocation(LatLng target) async {
//     if (mapController == null) return;
//     await mapController!.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(target: target, zoom: 16),
//       ),
//     );
//   }
//
//   // 🔹 Distance calculation
//   Future<void> updateDistanceFromUser() async {
//     try {
//       final userPosition = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//
//       final distanceInMeters = Geolocator.distanceBetween(
//         userPosition.latitude,
//         userPosition.longitude,
//         currentLatLng.value.latitude,
//         currentLatLng.value.longitude,
//       );
//
//       distanceFromUser.value = distanceInMeters;
//
//       locationDistance.value = distanceInMeters >= 1000
//           ? 'Pin is ${(distanceInMeters / 1000).toStringAsFixed(1)} km from your current location'
//           : 'Pin is ${distanceInMeters.toStringAsFixed(0)} m from your current location';
//     } catch (e) {
//       customPrint('❌ Failed to calculate distance: $e');
//       distanceFromUser.value = 0;
//       locationDistance.value = '';
//     }
//   }
//
//   // 🔹 Auto-detect current location
//   Future<void> initCurrentLocation() async {
//     try {
//       if (!await Geolocator.isLocationServiceEnabled()) {
//         customPrint('⚠️ Enable location services in settings');
//         return;
//       }
//
//       var permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           customPrint('Location permission denied');
//           return;
//         }
//       }
//       if (permission == LocationPermission.deniedForever) {
//         customPrint('Enable location permission in app settings');
//         return;
//       }
//
//       final position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//
//       final newLatLng = LatLng(position.latitude, position.longitude);
//       currentLatLng.value = newLatLng;
//       await animateToLocation(newLatLng);
//       await _updateAddressFromLatLng(newLatLng);
//       await updateDistanceFromUser();
//     } catch (e) {
//       customPrint('❌ Failed to detect current location: $e');
//     }
//   }
//
//   // 🔹 Search Handling
//   Future<void> openSearchBottomSheet(BuildContext context) async {
//     searchController.clear();
//     searchResults.clear();
//     isSearching.value = false;
//
//     await Get.bottomSheet(
//       Container(
//         padding: const EdgeInsets.all(16),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: searchController,
//               decoration: InputDecoration(
//                 hintText: "Search location...",
//                 suffixIcon: Obx(() => isSearching.value
//                     ? const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     height: 20,
//                     width: 20,
//                     child: CircularProgressIndicator(strokeWidth: 2),
//                   ),
//                 )
//                     : IconButton(
//                   icon: const Icon(Icons.search),
//                   onPressed: () async {
//                     await searchPlaces(searchController.text);
//                   },
//                 )),
//               ),
//               onSubmitted: (value) async => await searchPlaces(value),
//             ),
//             const SizedBox(height: 12),
//             Obx(() => Expanded(
//               child: ListView.builder(
//                 itemCount: searchResults.length,
//                 itemBuilder: (context, index) {
//                   final result = searchResults[index];
//                   return ListTile(
//                     leading: const Icon(Icons.location_on_outlined),
//                     title: Text(result['name']?.toString() ?? ''),
//                     subtitle: Text(result['address']?.toString() ?? ''),
//                     onTap: () {
//                       _onSearchResultTap(result);
//                       Get.back();
//                     },
//                   );
//                 },
//               ),
//             )),
//           ],
//         ),
//       ),
//       isScrollControlled: true,
//     );
//   }
//
//   Future<void> searchPlaces(String query) async {
//     if (query.isEmpty) return;
//     isSearching.value = true;
//     try {
//       final results = await _placesService.getAutocompleteSuggestions(
//         input: query,
//         latitude: currentLatLng.value.latitude,
//         longitude: currentLatLng.value.longitude,
//         radius: 50000,
//         components: 'country:in',
//       );
//
//       searchResults.assignAll(results.map((LocationSuggestion place) {
//         return {
//           "name": place.mainText,
//           "address": place.secondaryText,
//           "placeId": place.placeId,
//         };
//       }).toList());
//     } catch (e) {
//       customPrint('❌ Search error: $e');
//     } finally {
//       isSearching.value = false;
//     }
//   }
//
//   void _onSearchResultTap(Map<String, dynamic> result) async {
//     try {
//       final placeId = result['placeId']?.toString();
//       if (placeId == null) return;
//
//       final details = await _placesService.getPlaceDetails(placeId: placeId);
//
//       final lat = details.latitude;
//       final lng = details.longitude;
//       final target = LatLng(lat, lng);
//
//       currentLatLng.value = target;
//       await animateToLocation(target);
//
//       // Clean & format title/address properly
//       final formatted = formatTitleAndAddress(
//         details.name,
//         details.formattedAddress,
//       );
//       locationTitle.value = formatted['title']!;
//       locationAddress.value = formatted['address']!;
//
//       await updateDistanceFromUser();
//     } catch (e) {
//       customPrint('❌ Failed to select search result: $e');
//     }
//   }
//
//   // 🔹 Reverse geocoding helper
//   Future<void> _updateAddressFromLatLng(LatLng latLng) async {
//     try {
//       final places = await _placesService.reverseGeocode(
//         latitude: latLng.latitude,
//         longitude: latLng.longitude,
//       );
//
//       if (places.isNotEmpty) {
//         final place = places.first;
//         final formatted = formatTitleAndAddress(
//           place.name,
//           place.formattedAddress,
//         );
//         locationTitle.value = formatted['title']!;
//         locationAddress.value = formatted['address']!;
//       } else {
//         locationTitle.value = 'Unknown location';
//         locationAddress.value = "Couldn't fetch address";
//       }
//     } catch (e) {
//       customPrint('❌ Failed to update address: $e');
//     }
//   }
//
//   // 🔹 Helper to format title & address nicely
//   Map<String, String> formatTitleAndAddress(String? name, String fullAddress) {
//     // Split and trim
//     List<String> parts = fullAddress.split(',').map((e) => e.trim()).toList();
//
//     String title = '';
//     String address = '';
//
//     // 🔹 Regex for Plus Code or numeric/house prefix (handles "80/17", "22A", etc.)
//     final plusCodeRegex = RegExp(r'^[A-Z0-9+]{6,}$');
//     final houseNumberRegex = RegExp(r'^[0-9]+[A-Za-z0-9\/\-]*$'); // extended
//
//     // 🔹 Remove starting Plus Code or house number
//     if (parts.isNotEmpty &&
//         (plusCodeRegex.hasMatch(parts.first) || houseNumberRegex.hasMatch(parts.first))) {
//       parts.removeAt(0);
//     }
//
//     // 🔹 Remove trailing "India"
//     if (parts.isNotEmpty && parts.last.toLowerCase().contains('india')) {
//       parts.removeLast();
//     }
//
//     // 🔹 CASE 1: If name exists
//     if (name != null && name.trim().isNotEmpty) {
//       title = name.trim();
//       address = parts.join(', ').trim();
//     }
//     // 🔹 CASE 2: Fallback
//     else {
//       title = parts.isNotEmpty ? parts.first : '';
//       address = parts.length > 1 ? parts.skip(1).join(', ').trim() : '';
//     }
//
//     // 🔹 Final cleanup (remove double commas/spaces)
//     address = address.replaceAll(RegExp(r'\s+,', multiLine: true), ',');
//     address = address.replaceAll(RegExp(r',\s*,+'), ',').trim();
//
//     return {
//       'title': title,
//       'address': address,
//     };
//   }
//
//   // 🔹 Get detailed location components
//   Future<Map<String, String>> getAddressParts(LatLng latLng) async {
//     try {
//       final places = await _placesService.reverseGeocode(
//         latitude: latLng.latitude,
//         longitude: latLng.longitude,
//       );
//
//       if (places.isEmpty) return {};
//
//       final place = places.first;
//       final fullAddress = place.formattedAddress ?? '';
//       print("🗺️ Full Address: $fullAddress");
//
//       // Split and clean parts
//       List<String> parts = fullAddress.split(',').map((e) => e.trim()).toList();
//
//       // 🔹 Remove Plus Code if present at start
//       if (parts.isNotEmpty && RegExp(r'^[A-Z0-9+]{6,}$').hasMatch(parts.first)) {
//         parts.removeAt(0);
//       }
//
//       // 🔹 Remove trailing "India"
//       if (parts.isNotEmpty && parts.last.toLowerCase().contains('india')) {
//         parts.removeLast();
//       }
//
//       // 🔹 Identify part with postal code (e.g., "Uttar Pradesh 226028")
//       String postalCode = '';
//       int postalIndex = -1;
//       for (int i = parts.length - 1; i >= 0; i--) {
//         final match = RegExp(r'\b\d{6}\b').firstMatch(parts[i]);
//         if (match != null) {
//           postalCode = match.group(0)!;
//           postalIndex = i;
//           break;
//         }
//       }
//
//       // 🔹 Extract state (same part as postal or nearby)
//       String state = '';
//       if (postalIndex != -1) {
//         state = parts[postalIndex].replaceAll(RegExp(r'\d{6}'), '').trim();
//         // Sometimes state and postal are separate parts
//         if (state.isEmpty && postalIndex > 0) {
//           state = parts[postalIndex - 1];
//         }
//       }
//
//       // 🔹 Extract city (the part just before the state)
//       String city = '';
//       if (state.isNotEmpty) {
//         final stateIndex = parts.indexOf(state);
//         if (stateIndex > 0) {
//           city = parts[stateIndex - 1];
//         }
//       }
//
//       // 🔹 Fallback: if city still empty, take last 2nd part before state
//       if (city.isEmpty && postalIndex > 1) {
//         city = parts[postalIndex - 1];
//       }
//
//       // 🔹 Default country
//       String country = 'India';
//
//       print("✅ Parsed city: $city | state: $state | postal: $postalCode");
//
//       return {
//         'city': city,
//         'state': state,
//         'country': country,
//         'postal_code': postalCode,
//       };
//     } catch (e) {
//       customPrint('❌ Failed to parse address: $e');
//       return {};
//     }
//   }
//
// }
