// // // // // // import 'package:get/get.dart';
// // // // // // import 'package:geolocator/geolocator.dart';
// // // // // // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // // // // //
// // // // // // class LocationController extends GetxController {
// // // // // //   // CURRENT camera position
// // // // // //   final selectedLatLng = Rx<LatLng>(const LatLng(28.6139, 77.2090)); // default delhi
// // // // // //
// // // // // //   GoogleMapController? mapCtrl;
// // // // // //
// // // // // //   // SET MAP CONTROLLER
// // // // // //   void setMapController(GoogleMapController controller) {
// // // // // //     mapCtrl = controller;
// // // // // //   }
// // // // // //
// // // // // //   // GET CURRENT LOCATION
// // // // // //   Future<void> getCurrentLocation() async {
// // // // // //     bool enabled = await Geolocator.isLocationServiceEnabled();
// // // // // //     if (!enabled) {
// // // // // //       await Geolocator.openLocationSettings();
// // // // // //       return;
// // // // // //     }
// // // // // //
// // // // // //     LocationPermission perm = await Geolocator.checkPermission();
// // // // // //     if (perm == LocationPermission.denied) {
// // // // // //       perm = await Geolocator.requestPermission();
// // // // // //     }
// // // // // //
// // // // // //     if (perm == LocationPermission.deniedForever) return;
// // // // // //
// // // // // //     Position pos = await Geolocator.getCurrentPosition();
// // // // // //
// // // // // //     selectedLatLng.value = LatLng(pos.latitude, pos.longitude);
// // // // // //
// // // // // //     // MOVE MAP CAMERA
// // // // // //     mapCtrl?.animateCamera(
// // // // // //       CameraUpdate.newLatLngZoom(selectedLatLng.value, 15),
// // // // // //     );
// // // // // //   }
// // // // // // }
// // // // //
// // // // //
// // // // //
// // // // // import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
// // // // // import 'package:get/get.dart';
// // // // // import 'package:geolocator/geolocator.dart';
// // // // // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // // // //
// // // // // import 'package:google_api_headers/google_api_headers.dart';
// // // // //
// // // // // class LocationController extends GetxController {
// // // // //   final selectedLatLng = Rx<LatLng>(const LatLng(28.6139, 77.2090));
// // // // //   GoogleMapController? mapCtrl;
// // // // //
// // // // //   late GoogleMapsPlaces places;
// // // // //
// // // // //   @override
// // // // //   void onInit() {
// // // // //     super.onInit();
// // // // //
// // // // //     places = GoogleMapsPlaces(
// // // // //       apiKey: "YOUR_API_KEY",
// // // // //       apiHeaders: const ApiHeaders().getHeaders(),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   void setMapController(GoogleMapController controller) {
// // // // //     mapCtrl = controller;
// // // // //   }
// // // // //
// // // // //   void moveTo(LatLng latLng) {
// // // // //     selectedLatLng.value = latLng;
// // // // //
// // // // //     mapCtrl?.animateCamera(
// // // // //       CameraUpdate.newLatLngZoom(latLng, 15),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   Future<void> getCurrentLocation() async {
// // // // //     bool enabled = await Geolocator.isLocationServiceEnabled();
// // // // //     if (!enabled) {
// // // // //       await Geolocator.openLocationSettings();
// // // // //       return;
// // // // //     }
// // // // //
// // // // //     LocationPermission perm = await Geolocator.checkPermission();
// // // // //     if (perm == LocationPermission.denied) {
// // // // //       perm = await Geolocator.requestPermission();
// // // // //     }
// // // // //
// // // // //     if (perm == LocationPermission.deniedForever) return;
// // // // //
// // // // //     Position pos = await Geolocator.getCurrentPosition();
// // // // //
// // // // //     moveTo(LatLng(pos.latitude, pos.longitude));
// // // // //   }
// // // // // }
// // // // //
// // // //
// // // // import 'package:get/get.dart';
// // // // import 'package:geolocator/geolocator.dart';
// // // // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // // // import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
// // // // import 'package:google_api_headers/google_api_headers.dart';
// // // //
// // // // class LocationController extends GetxController {
// // // //   final selectedLatLng = Rx<LatLng>(const LatLng(28.6139, 77.2090));
// // // //   GoogleMapController? mapCtrl;
// // // //
// // // //   late GoogleMapsPlaces places;
// // // //
// // // //   @override
// // // //   void onInit() async {
// // // //     super.onInit();
// // // //
// // // //     places = GoogleMapsPlaces(
// // // //       apiKey: "YOUR_API_KEY",
// // // //       apiHeaders: await const GoogleApiHeaders().getHeaders(), // ✔ fixed
// // // //     );
// // // //   }
// // // //
// // // //   void setMapController(GoogleMapController controller) {
// // // //     mapCtrl = controller;
// // // //   }
// // // //
// // // //   void moveTo(LatLng pos) {
// // // //     selectedLatLng.value = pos;
// // // //
// // // //     mapCtrl?.animateCamera(
// // // //       CameraUpdate.newLatLngZoom(pos, 15),
// // // //     );
// // // //   }
// // // //
// // // //   Future<void> getCurrentLocation() async {
// // // //     bool enabled = await Geolocator.isLocationServiceEnabled();
// // // //     if (!enabled) {
// // // //       await Geolocator.openLocationSettings();
// // // //       return;
// // // //     }
// // // //
// // // //     LocationPermission perm = await Geolocator.checkPermission();
// // // //     if (perm == LocationPermission.denied) {
// // // //       perm = await Geolocator.requestPermission();
// // // //     }
// // // //
// // // //     if (perm == LocationPermission.deniedForever) return;
// // // //
// // // //     Position pos = await Geolocator.getCurrentPosition();
// // // //
// // // //     moveTo(LatLng(pos.latitude, pos.longitude));
// // // //   }
// // // // }
// // // //
// // //
// // //
// // // import 'package:get/get.dart';
// // // import 'package:geolocator/geolocator.dart';
// // // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // // import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
// // // import 'package:google_api_headers/google_api_headers.dart';
// // //
// // // class LocationController extends GetxController {
// // //   final selectedLatLng = Rx<LatLng>(const LatLng(28.6139, 77.2090));
// // //   GoogleMapController? mapCtrl;
// // //
// // //   // 🔥 marker set
// // //   var markers = <Marker>{}.obs;
// // //
// // //   late GoogleMapsPlaces places;
// // //
// // //   @override
// // //   void onInit() async {
// // //     super.onInit();
// // //
// // //     // initialize google places
// // //     places = GoogleMapsPlaces(
// // //       apiKey: "YOUR_API_KEY",
// // //       apiHeaders: await const GoogleApiHeaders().getHeaders(),
// // //     );
// // //
// // //     // default marker
// // //     markers.value = {
// // //       const Marker(
// // //         markerId: MarkerId("default"),
// // //         position: LatLng(28.6139, 77.2090),
// // //       )
// // //     };
// // //   }
// // //
// // //   // map controller set
// // //   void setMapController(GoogleMapController controller) {
// // //     mapCtrl = controller;
// // //   }
// // //
// // //   // 🔥 move camera + add pin
// // //   void moveTo(LatLng pos) {
// // //     selectedLatLng.value = pos;
// // //
// // //     markers.value = {
// // //       Marker(
// // //         markerId: const MarkerId("selected"),
// // //         position: pos,
// // //       )
// // //     };
// // //
// // //     mapCtrl?.animateCamera(
// // //       CameraUpdate.newLatLngZoom(pos, 15),
// // //     );
// // //   }
// // //
// // //   // 🔥 get user's location
// // //   Future<void> getCurrentLocation() async {
// // //     bool enabled = await Geolocator.isLocationServiceEnabled();
// // //     if (!enabled) {
// // //       await Geolocator.openLocationSettings();
// // //       return;
// // //     }
// // //
// // //     LocationPermission perm = await Geolocator.checkPermission();
// // //     if (perm == LocationPermission.denied) {
// // //       perm = await Geolocator.requestPermission();
// // //     }
// // //
// // //     if (perm == LocationPermission.deniedForever) return;
// // //
// // //     Position pos = await Geolocator.getCurrentPosition();
// // //
// // //     moveTo(LatLng(pos.latitude, pos.longitude));
// // //   }
// // // }
// //
// //
// // import 'package:get/get.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
// // import 'package:google_api_headers/google_api_headers.dart';
// //
// // class LocationController extends GetxController {
// //   final selectedLatLng = Rx<LatLng>(const LatLng(28.6139, 77.2090));
// //   GoogleMapController? mapCtrl;
// //
// //   late GoogleMapsPlaces places;
// //
// //   @override
// //   void onInit() async {
// //     super.onInit();
// //
// //     places = GoogleMapsPlaces(
// //       apiKey: "YOUR_API_KEY",
// //       apiHeaders: await const GoogleApiHeaders().getHeaders(),
// //     );
// //   }
// //
// //   void setMapController(GoogleMapController controller) {
// //     mapCtrl = controller;
// //   }
// //
// //   void updatePosition(CameraPosition position) {
// //     selectedLatLng.value = position.target;
// //   }
// //
// //   void moveTo(LatLng pos) {
// //     selectedLatLng.value = pos;
// //     mapCtrl?.animateCamera(CameraUpdate.newLatLngZoom(pos, 16));
// //   }
// //
// //   Future<void> getCurrentLocation() async {
// //     bool enabled = await Geolocator.isLocationServiceEnabled();
// //     if (!enabled) {
// //       await Geolocator.openLocationSettings();
// //       return;
// //     }
// //
// //     LocationPermission perm = await Geolocator.checkPermission();
// //     if (perm == LocationPermission.denied) {
// //       perm = await Geolocator.requestPermission();
// //     }
// //
// //     if (perm == LocationPermission.deniedForever) return;
// //
// //     Position pos = await Geolocator.getCurrentPosition();
// //
// //     moveTo(LatLng(pos.latitude, pos.longitude));
// //   }
// // }
//
//
// import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
// import 'package:google_api_headers/google_api_headers.dart';
//
// class LocationController extends GetxController {
//   final selectedLatLng = Rx<LatLng>(const LatLng(28.6139, 77.2090));
//   GoogleMapController? mapCtrl;
//
//   late GoogleMapsPlaces places;
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
//
//     // MAP DRAG LISTENER
//     mapCtrl!.addListener(() async {
//       final pos = await mapCtrl!.getLatLng(
//         ScreenCoordinate(
//           x: 150, // center approx
//           y: 100,
//         ),
//       );
//
//       selectedLatLng.value = pos;
//     });
//   }
//
//   // MOVE THE MAP + ZOOM
//   void moveTo(LatLng pos) {
//     selectedLatLng.value = pos;
//
//     mapCtrl?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: pos,
//           zoom: 15,
//         ),
//       ),
//     );
//   }
//
//   // CURRENT LOCATION
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

  // Map move hone pe position update
  void updateFromCamera(CameraPosition pos) {
    selectedLatLng.value = pos.target;
  }

  void moveTo(LatLng pos) {
    selectedLatLng.value = pos;

    mapCtrl?.animateCamera(
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
}
