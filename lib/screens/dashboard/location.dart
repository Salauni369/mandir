import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controllers/manage_controller.dart';
import '../../address/controller/select_location_controller.dart';
import '../../address/view/widgets/location_search_bottom_sheet.dart';
import '../../location/services/places_api_service.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final manageController = Get.find<ManageController>();
  final locationController = Get.find<SelectLocationController>();
  final PlacesApiService _placesService = PlacesApiService();

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    // Check if location already saved
    if (manageController.savedLat.value == 0.0) {
      // No saved location, get current
      await locationController.initCurrentLocation();
    } else {
      // Use saved location
      final savedLatLng = LatLng(
        manageController.savedLat.value,
        manageController.savedLng.value,
      );
      locationController.currentLatLng.value = savedLatLng;

      if (locationController.mapController != null) {
        await locationController.mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: savedLatLng, zoom: 17),
          ),
        );
      }
    }
  }

  Future<void> _currentLocation() async {
    await locationController.initCurrentLocation();
    if (locationController.mapController != null) {
      await locationController.mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: locationController.currentLatLng.value,
            zoom: 17,
          ),
        ),
      );
    }
  }

  void _openSearchBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LocationSearchBottomSheet(placesService: _placesService),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 🗺️ MAP
          Obx(() => GoogleMap(
            initialCameraPosition: CameraPosition(
              target: locationController.currentLatLng.value,
              zoom: 17,
            ),
            onMapCreated: locationController.onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onCameraMove: locationController.onCameraMove,
            onCameraIdle: locationController.onCameraIdle,
            circles: locationController.circleList.map((circleData) {
              return Circle(
                circleId: CircleId(circleData['id'].toString()),
                center: circleData['center'] as LatLng,
                radius: circleData['radius'] as double,
                fillColor: Colors.lightBlueAccent.withOpacity(0.2),
                strokeColor: Colors.lightBlueAccent.withOpacity(0.6),
                strokeWidth: 2,
              );
            }).toSet(),
          )),

          // 🔍 SEARCH BAR
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: InkWell(
              onTap: _openSearchBottomSheet,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(200),
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.black54),
                    const SizedBox(width: 10),
                    Text(
                      "Search for location",
                      style: GoogleFonts.roboto(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 📍 PIN MARKER
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 41.8, left: 0.5),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  const Icon(Icons.location_on, color: Colors.blue, size: 50),
                  Positioned(
                    bottom: 6,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🎯 CURRENT LOCATION BUTTON
          Positioned(
            bottom: 240,
            right: 8,
            child: IconButton(
              onPressed: _currentLocation,
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF74ABE2), Color(0xFF5563DE)],
                  ),
                ),
                child: const Icon(Icons.my_location,
                    color: Colors.white, size: 22),
              ),
            ),
          ),

          // 📋 BOTTOM SHEET
          Obx(() => Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(18)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locationController.locationTitle.value,
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        locationController.locationAddress.value,
                        style: GoogleFonts.roboto(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 20),

                      // ✅ CONFIRM LOCATION BUTTON
                      InkWell(
                        onTap: () async {
                          await locationController.confirmLocationAndSave();

                          // Reload in manage controller
                          manageController.loadSavedLocation();

                          Get.snackbar(
                            "Success ✅",
                            "Location confirmed! Now tap 'Update' button to save to server.",
                            backgroundColor: Colors.green.shade600,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                            margin: const EdgeInsets.all(16),
                            duration: const Duration(seconds: 3),
                            icon: const Icon(Icons.check_circle,
                                color: Colors.white),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF7722),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Confirm Location',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Center(
                        child: Text(
                          locationController.locationDistance.value,
                          style: GoogleFonts.roboto(
                            fontSize: 13,
                            color: Colors.pink[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}