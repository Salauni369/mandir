// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
// import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
//
// import '../../controllers/location_controller.dart';
// import '../../controllers/manage_controller.dart';
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
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // ---------------- FULL SCREEN MAP ----------------
//             Column(
//               children: [
//                 const SizedBox(height: 70), // Space for search bar
//                 Expanded(
//                   child: Obx(() => GoogleMap(
//                     initialCameraPosition: CameraPosition(
//                       target: locCtrl.selectedLatLng.value,
//                       zoom: 14,
//                     ),
//                     onMapCreated: locCtrl.setMapController,
//                     myLocationEnabled: true,
//                     myLocationButtonEnabled: false,
//                     zoomControlsEnabled: false,
//                   )),
//                 ),
//               ],
//             ),
//
//             // ---------------- CENTER PIN ICON ----------------
//             const Center(
//               child: Icon(Icons.location_on, size: 45, color: Colors.red),
//             ),
//
//             // ---------------- SEARCH BAR (TOP) ----------------
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: _buildSearchBar(context),
//             ),
//
//             // ---------------- USE CURRENT LOCATION BUTTON (ON MAP) ----------------
//             Positioned(
//               bottom: 280,
//               left: 50,
//               right: 50,
//               child: ElevatedButton.icon(
//                 onPressed: () => locCtrl.getCurrentLocation(),
//                 icon: const Icon(Icons.my_location, size: 18),
//                 label: const Text(
//                   "Use Current Location",
//                   style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   backgroundColor: Colors.black87,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   elevation: 4,
//                 ),
//               ),
//             ),
//
//             // ---------------- BOTTOM CARD WITH LOCATION INFO ----------------
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(24),
//                     topRight: Radius.circular(24),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 20,
//                       offset: const Offset(0, -4),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(24),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Drag Handle
//                       Center(
//                         child: Container(
//                           width: 40,
//                           height: 4,
//                           margin: const EdgeInsets.only(bottom: 20),
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade300,
//                             borderRadius: BorderRadius.circular(2),
//                           ),
//                         ),
//                       ),
//
//                       // Location Details Header
//                       const Text(
//                         "Selected Location",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF2D3436),
//                         ),
//                       ),
//
//                       const SizedBox(height: 16),
//
//                       // Current Location Display
//                       Obx(() {
//                         final location = controller.location.value;
//                         return Container(
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade50,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: Colors.grey.shade300),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(Icons.location_on, color: Colors.red.shade400, size: 24),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       location.address.isNotEmpty
//                                           ? location.address
//                                           : "Address not set",
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                         color: Color(0xFF2D3436),
//                                       ),
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       location.city.isNotEmpty && location.state.isNotEmpty
//                                           ? "${location.city}, ${location.state}"
//                                           : "City, State",
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey.shade600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }),
//
//                       const SizedBox(height: 20),
//
//                       // Confirm Button
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // Save location and go back
//                             Get.snackbar(
//                               "Success",
//                               "Location confirmed!",
//                               backgroundColor: Colors.green,
//                               colorText: Colors.white,
//                               snackPosition: SnackPosition.BOTTOM,
//                             );
//                             // You can add your save logic here
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.grey,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             elevation: 2,
//                           ),
//                           child: const Text(
//                             "Confirm Location",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSearchBar(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         Prediction? p = await PlacesAutocomplete.show(
//           context: context,
//           apiKey: "YOUR_API_KEY",
//           mode: Mode.overlay,
//           language: "en",
//           hint: "Search location...",
//         );
//
//         if (p != null) {
//           final detail = await locCtrl.places.getDetailsByPlaceId(p.placeId!);
//           final loc = detail.result.geometry!.location;
//
//           locCtrl.moveTo(LatLng(loc.lat, loc.lng));
//         }
//       },
//       child: Container(
//         height: 50,
//         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.1),
//               blurRadius: 10,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: const Row(
//           children: [
//             Icon(Icons.search, size: 22, color: Colors.grey),
//             SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 "Search location...",
//                 style: TextStyle(fontSize: 14, color: Colors.grey),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';

import '../../controllers/location_controller.dart';
import '../../controllers/manage_controller.dart';

class LocationTab extends StatelessWidget {
  LocationTab({super.key});

  final LocationController locCtrl = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    final ManageController controller = Get.find();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            // ---------------- FULL SCREEN MAP ----------------
            Column(
              children: [
                const SizedBox(height: 70),
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(28.6139, 77.2090),
                      zoom: 14,
                    ),
                    onMapCreated: locCtrl.setMapController,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    onCameraMove: locCtrl.updateFromCamera,
                  ),
                ),
              ],
            ),

            // ---------------- CENTER PIN ICON ----------------
            const Center(
              child: Icon(Icons.location_on, size: 45, color: Colors.red),
            ),

            // ---------------- SEARCH BAR ----------------
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildSearchBar(context),
            ),

            // ---------------- CURRENT LOCATION BUTTON ----------------
            Positioned(
              bottom: 280,
              left: 50,
              right: 50,
              child: ElevatedButton.icon(
                onPressed: () => locCtrl.getCurrentLocation(),
                icon: const Icon(Icons.my_location, size: 18),
                label: const Text(
                  "Use Current Location",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  backgroundColor: Colors.black87,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                ),
              ),
            ),

            // ---------------- BOTTOM CARD ----------------
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),

                      const Text(
                        "Selected Location",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3436),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Obx(() {
                        final location = controller.location.value;
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.red.shade400, size: 24),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      location.address.isNotEmpty
                                          ? location.address
                                          : "Address not set",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      location.city.isNotEmpty && location.state.isNotEmpty
                                          ? "${location.city}, ${location.state}"
                                          : "City, State",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.snackbar(
                              "Success",
                              "Location confirmed!",
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("Confirm Location"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Prediction? p = await PlacesAutocomplete.show(
          context: context,
          apiKey: "YOUR_API_KEY",
          mode: Mode.overlay,
          language: "en",
          hint: "Search location...",
        );

        if (p != null) {
          final detail = await locCtrl.places.getDetailsByPlaceId(p.placeId!);
          final loc = detail.result.geometry!.location;
          locCtrl.moveTo(LatLng(loc.lat, loc.lng));
        }
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Row(
          children: [
            Icon(Icons.search, size: 22, color: Colors.grey),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                "Search location...",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
