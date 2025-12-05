//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
// import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
//
// import '../../controllers/manage_controller.dart';
// import '../../controllers/location_controller.dart';
//
// class LocationTab extends StatelessWidget {
//   LocationTab({super.key});
//
//   final LocationController locCtrl = Get.put(LocationController());
//
//   @override
//   Widget build(BuildContext context) {
//     final ManageController controller = Get.find();
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: [
//           // SEARCH BAR
//           GestureDetector(
//             onTap: () async {
//               Prediction? p = await PlacesAutocomplete.show(
//                 context: context,
//                 apiKey: "YOUR_API_KEY",
//                 mode: Mode.overlay,
//                 language: "en",
//                 hint: "Search location...",
//               );
//
//               if (p != null) {
//                 final detail =
//                 await locCtrl.places.getDetailsByPlaceId(p.placeId!);
//                 final loc = detail.result.geometry!.location;
//
//                 locCtrl.moveTo(
//                   LatLng(loc.lat, loc.lng),
//                 );
//               }
//             },
//             child: Container(
//               height: 45,
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(6),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(.08),
//                     blurRadius: 6,
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: const [
//                   Icon(Icons.search, size: 20, color: Colors.grey),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Text(
//                       "Search location...",
//                       style: TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 20),
//
//           // GOOGLE MAP + PIN
//           SizedBox(
//             height: 200,
//             child: Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(2),
//                   child: Obx(() => GoogleMap(
//                     initialCameraPosition: CameraPosition(
//                       target: locCtrl.selectedLatLng.value,
//                       zoom: 13,
//                     ),
//                     onMapCreated: locCtrl.setMapController,
//                     myLocationEnabled: true,
//                     myLocationButtonEnabled: false,
//                     zoomControlsEnabled: false,
//                   )),
//                 ),
//
//                 // CENTER PIN (Zomato Style)
//                 const Center(
//                   child: Icon(
//                     Icons.location_on,
//                     size: 38,
//                     color: Colors.red,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 20),
//
//           // CURRENT LOCATION BUTTON
//           ElevatedButton.icon(
//             onPressed: () => locCtrl.getCurrentLocation(),
//             icon: const Icon(Icons.my_location),
//             label: const Text("Use Current Location"),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black,
//               foregroundColor: Colors.white,
//               minimumSize: const Size(double.infinity, 50),
//             ),
//           ),
//
//           const SizedBox(height: 20),
//
//           // FIELDS (YOUR SAME DESIGN)
//           _field("Address *", controller.location.value.address),
//           const SizedBox(height: 16),
//           _field("Area *", controller.location.value.area),
//           const SizedBox(height: 16),
//           _field("Pincode *", controller.location.value.pincode),
//           const SizedBox(height: 16),
//           _field("City *", controller.location.value.city),
//           const SizedBox(height: 50),
//         ],
//       ),
//     );
//   }
//
//   Widget _field(String label, String hint) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           style: const TextStyle(fontSize: 12),
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
//             filled: true,
//             fillColor: const Color(0xFFF4F4F4),
//             contentPadding:
//             const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(2),
//               borderSide: BorderSide.none,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
