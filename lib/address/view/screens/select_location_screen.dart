// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../controller/select_location_controller.dart';
// import '../../models/get_address_model.dart';
// import '../widgets/location_search_bottom_sheet.dart';
// import 'add_address_detail.dart';
//
// class SelectLocationScreen extends StatefulWidget {
//   final AddressData? addressData;
//   final String? type;
//   const SelectLocationScreen({super.key, this.addressData, this.type});
//
//   @override
//   State<SelectLocationScreen> createState() => _SelectLocationScreenState();
// }
//
// class _SelectLocationScreenState extends State<SelectLocationScreen> {
//   final controller = Get.find<SelectLocationController>();
//   final PlacesApiService _placesService = PlacesApiService();
//   final TextEditingController _searchController = TextEditingController();
//   Timer? _debounceTimer;
//
//   final _suggestions = <LocationSuggestion>[].obs;
//   final _isLoading = false.obs;
//
//   @override
//   void initState() {
//     super.initState();
//     _currentLocation();
//     _searchController.addListener(_onSearchChanged);
//   }
//
//   _currentLocation() async {
//     await controller.initCurrentLocation();
//     if (controller.mapController != null) {
//       await controller.mapController!.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//             target: controller.currentLatLng.value,
//             zoom: 17,
//           ),
//         ),
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     _debounceTimer?.cancel();
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   void _onSearchChanged() {
//     final query = _searchController.text.trim();
//     if (query.isEmpty) {
//       _suggestions.clear();
//       return;
//     }
//     _debounceTimer?.cancel();
//     _debounceTimer = Timer(const Duration(milliseconds: 400), () {
//       _fetchSuggestions(query);
//     });
//   }
//
//   Future<void> _fetchSuggestions(String query) async {
//     if (query.isEmpty) return;
//     _isLoading.value = true;
//     try {
//       final results = await _placesService.getAutocompleteSuggestions(
//         input: query,
//         latitude: controller.currentLatLng.value.latitude,
//         longitude: controller.currentLatLng.value.longitude,
//         radius: 50000,
//         components: 'country:in',
//       );
//       _suggestions.assignAll(results);
//     } catch (e) {
//       _suggestions.clear();
//     } finally {
//       _isLoading.value = false;
//     }
//   }
//
//   void _openSearchBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) => LocationSearchBottomSheet(placesService: _placesService),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBarWidget(title: "Select Your Location"),
//       body: Stack(
//         children: [
//           // 🗺️ Google Map
//           Obx(() => GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: controller.currentLatLng.value,
//               zoom: 17,
//             ),
//             onMapCreated: controller.onMapCreated,
//             myLocationEnabled: true,
//             myLocationButtonEnabled: false,
//             onCameraMove: controller.onCameraMove,
//             onCameraIdle: controller.onCameraIdle,
//
//             // 🔵 Added 80m light blue radius circle
//             circles: controller.circleList.map((circleData) {
//               return Circle(
//                 circleId: CircleId(circleData['id'].toString()),
//                 center: circleData['center'] as LatLng,
//                 radius: circleData['radius'] as double,
//                 fillColor: Colors.lightBlueAccent.withOpacity(0.2),
//                 strokeColor: Colors.lightBlueAccent.withOpacity(0.6),
//                 strokeWidth: 2,
//               );
//             }).toSet(),
//           )),
//
//           // 🔍 Search Bar (grey border, black text)
//           Positioned(
//             top: 12,
//             left: 12,
//             right: 12,
//             child: InkWell(
//               onTap: _openSearchBottomSheet,
//               child: Container(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withAlpha(200),
//                   border: Border.all(color: Colors.grey.shade300, width: 1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.search, color: Colors.black54),
//                     const SizedBox(width: 10),
//                     Text(
//                       "Search for location",
//                       style: GoogleFonts.roboto(
//                         color: Colors.black87,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           // 📍 Pin marker (custom image + bottom circle)
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 41.8, left: 0.5),
//               child: Stack(
//                 alignment: Alignment.topCenter,
//                 children: [
//                   Image.asset(
//                     AllImages.pin,
//                     width: 70,
//                     height: 70,
//                   ),
//                   Positioned(
//                     bottom: 6,
//                     child: Container(
//                       width: 16,
//                       height: 16,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           width: 2,
//                           color: Colors.black87,
//                         ),
//                         color: Colors.transparent,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           // 📍 Current Location Button
//           Positioned(
//             bottom: 240,
//             right: 8,
//             child: IconButton(
//               onPressed: _currentLocation,
//               icon: Container(
//                 padding: const EdgeInsets.all(6),
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: LinearGradient(
//                     colors: [Color(0xFF74ABE2), Color(0xFF5563DE)],
//                   ),
//                 ),
//                 child:
//                 const Icon(Icons.my_location, color: Colors.white, size: 22),
//               ),
//             ),
//           ),
//
//           // 🏠 Bottom Address Container
//           Obx(() => Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius:
//                 BorderRadius.vertical(top: Radius.circular(18)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 20,
//                     offset: Offset(0, -5),
//                   ),
//                 ],
//               ),
//               child: SafeArea(
//                 top: false,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 18, vertical: 15),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         controller.locationTitle.value,
//                         style: GoogleFonts.roboto(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         controller.locationAddress.value,
//                         style: GoogleFonts.roboto(
//                           fontSize: 14,
//                           color: Colors.grey[700],
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 20),
//
//                       // ✅ Confirm button (grey border, black text)
//                       InkWell(
//                         onTap: () async {
//                           final details = await controller
//                               .getAddressParts(
//                               controller.currentLatLng.value);
//                           Get.to(
//                                 () => AddAddressDetailsScreen(
//                               selectedLatLng:
//                               controller.currentLatLng.value,
//                               selectedAddress:
//                               controller.locationAddress.value,
//                               selectedTitle:
//                               controller.locationTitle.value,
//                               addressData: widget.addressData,
//                               pageType: widget.type ?? "",
//                               country: details['country'] ?? '',
//                               state: details['state'] ?? '',
//                               city: details['city'] ?? '',
//                               zipCode: details['postal_code'] ?? '',
//                             ),
//                             transition: Transition.rightToLeft,
//                           );
//                         },
//                         child: Container(
//                           width: double.infinity,
//                           alignment: Alignment.center,
//                           padding:
//                           const EdgeInsets.symmetric(vertical: 14),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                                 color: Colors.grey.shade400, width: 1),
//                             borderRadius: BorderRadius.circular(12),
//                             color: Colors.grey.shade100,
//                           ),
//                           child: Text(
//                             'Confirm Location',
//                             style: GoogleFonts.roboto(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 14),
//                       Obx(() => Center(
//                         child: Text(
//                           controller.locationDistance.value,
//                           style: GoogleFonts.roboto(
//                             fontSize: 13,
//                             color: Colors.pink[600],
//                           ),
//                         ),
//                       )),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           )),
//         ],
//       ),
//     );
//   }
// }
//
// class TrianglePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..shader = const LinearGradient(
//         colors: [Color(0xFFFD6E6A), Color(0xFFFFB88C)],
//       ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
//       ..style = PaintingStyle.fill;
//
//     final path = Path()
//       ..moveTo(size.width / 2, size.height)
//       ..lineTo(0, 0)
//       ..lineTo(size.width, 0)
//       ..close();
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
