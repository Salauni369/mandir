// import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
// import 'package:google_api_headers/google_api_headers.dart';
//
// class LocationController extends GetxController {
//   final selectedLatLng = Rx<LatLng>(const LatLng(28.6139, 77.2090));
//   late GoogleMapsPlaces places;
//   GoogleMapController? mapCtrl;
//
//   @override
//   void onInit() async {
//     super.onInit();
//
//     places = GoogleMapsPlaces(
//       apiKey: "YOUR_API_KEY",
//       apiHeaders: await GoogleApiHeaders().getHeaders(),
//     );
//   }
//
//   void setMapController(GoogleMapController controller) {
//     mapCtrl = controller;
//   }
//
//   // Map move hone pe position update
//   void updateFromCamera(CameraPosition pos) {
//     selectedLatLng.value = pos.target;
//   }
//
//   void moveTo(LatLng pos) {
//     selectedLatLng.value = pos;
//
//     mapCtrl?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(target: pos, zoom: 15),
//       ),
//     );
//   }
//
//   Future<void> getCurrentLocation() async {
//     bool enabled = await Geolocator.isLocationServiceEnabled();
//     if (!enabled) {
//       await Geolocator.openLocationSettings();
//       return;
//     }
//
//     LocationPermission perm = await Geolocator.checkPermission();
//     if (perm == LocationPermission.denied) {
//       perm = await Geolocator.requestPermission();
//     }
//
//     if (perm == LocationPermission.deniedForever) return;
//
//     Position pos = await Geolocator.getCurrentPosition();
//
//     moveTo(LatLng(pos.latitude, pos.longitude));
//   }
// }



import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class LocationController extends GetxController {
  final selectedLatLng = Rx<LatLng>(const LatLng(28.6139, 77.2090));
  late GoogleMapsPlaces places;

  GoogleMapController? mapCtrl;

  @override
  void onInit() async {
    super.onInit();

    places = GoogleMapsPlaces(
      apiKey: "YOUR_API_KEY",
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );
  }

  void setMapController(GoogleMapController controller) {
    mapCtrl = controller;
  }

  // Camera move hone par sirf value update
  void updateFromCamera(CameraPosition pos) {
    selectedLatLng.value = pos.target;
  }

  // Camera ko safely move karo
  void moveTo(LatLng pos) {
    selectedLatLng.value = pos;

    if (mapCtrl == null) return;

    mapCtrl!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: pos, zoom: 15),
      ),
    );
  }

  Future<void> getCurrentLocation() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }

    if (perm == LocationPermission.deniedForever) return;

    Position pos = await Geolocator.getCurrentPosition();

    moveTo(LatLng(pos.latitude, pos.longitude));
  }

  @override
  void onClose() {
    mapCtrl?.dispose();
    mapCtrl = null;
    super.onClose();
  }
}

