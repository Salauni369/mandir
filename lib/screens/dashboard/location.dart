import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';

import '../../controllers/location_controller.dart';
import '../../controllers/manage_controller.dart';


class LocationTab extends StatelessWidget {
  LocationTab({super.key});

  final LocationController locCtrl = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    final ManageController controller = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: true,   // 🔥 KEY FIX
      body: SafeArea(
        child: Column(
          children: [

            // ---------------- SEARCH BAR ABOVE MAP ----------------
            _buildSearchBar(context),

            const SizedBox(height: 10),

            // ---------------- FIXED MAP ----------------
            SizedBox(
              height: 230,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Obx(() => GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: locCtrl.selectedLatLng.value,
                        zoom: 14,
                      ),
                      onMapCreated: locCtrl.setMapController,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                    )),
                  ),

                  const Center(
                    child: Icon(Icons.location_on, size: 40, color: Colors.red),
                  ),

                  Positioned(
                    bottom: 6,
                    right: 50,
                    left: 50,
                    child: ElevatedButton.icon(
                      onPressed: () => locCtrl.getCurrentLocation(),
                      icon: const Icon(Icons.my_location, size: 18),
                      label: const Text(
                        "Use Current Location",
                        style: TextStyle(fontSize: 11),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        backgroundColor: Colors.black87,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ---------------- SCROLLABLE SECTION ----------------
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    _field("Address *", controller.location.value.address),
                    const SizedBox(height: 16),
                    _field("Area *", controller.location.value.area),
                    const SizedBox(height: 16),
                    _field("Pincode *", controller.location.value.pincode),
                    const SizedBox(height: 16),
                    _field("City *", controller.location.value.city),
                    const SizedBox(height: 16),
                    _field("State *", controller.location.value.state),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------

  // ---------------- SEARCH BAR WIDGET ----------------
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
          final detail =
          await locCtrl.places.getDetailsByPlaceId(p.placeId!);
          final loc = detail.result.geometry!.location;

          locCtrl.moveTo(
            LatLng(loc.lat, loc.lng),
          );
        }
      },
      child: Container(
        height: 45,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: const [
            Icon(Icons.search, size: 20, color: Colors.grey),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "Search location...",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- TEXT FIELD WIDGET ----------------
  Widget _field(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
            filled: true,
            fillColor: const Color(0xFFF4F4F4),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}




