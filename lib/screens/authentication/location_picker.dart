// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import '../../services/location_service.dart';
//
// class LocationPickerPage extends StatefulWidget {
//   const LocationPickerPage({super.key});
//
//   @override
//   State<LocationPickerPage> createState() => _LocationPickerPageState();
// }
//
// class _LocationPickerPageState extends State<LocationPickerPage> {
//   GoogleMapController? mapController;
//   LatLng? selectedLatLng;
//   String selectedAddress = "Searching...";
//   bool isLoading = true;
//
//   final TextEditingController searchCtrl = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       Get.snackbar("Error", "Please enable location service");
//       return;
//     }
//
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         Get.snackbar("Error", "Location permission denied");
//         return;
//       }
//     }
//
//     Position position = await Geolocator.getCurrentPosition();
//     setState(() {
//       selectedLatLng = LatLng(position.latitude, position.longitude);
//       isLoading = false;
//     });
//     if (mapController != null) {
//       mapController!.animateCamera(CameraUpdate.newLatLng(selectedLatLng!));
//     }
//     _getAddressFromLatLng(selectedLatLng!);
//   }
//
//   Future<void> _getAddressFromLatLng(LatLng latLng) async {
//     setState(() {
//       selectedAddress = "Lat: ${latLng.latitude.toStringAsFixed(4)}, Lng: ${latLng.longitude.toStringAsFixed(4)}";
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Select Temple Location"),
//         backgroundColor: Colors.orange.shade700,
//         foregroundColor: Colors.white,
//         actions: [
//           TextButton(
//             onPressed: selectedLatLng == null
//                 ? null
//                 : () {
//               LocationService.setLocation(selectedAddress);
//               Get.back(); // wapas signup page pe
//             },
//             child: const Text("DONE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           ),
//         ],
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator(color: Colors.orange))
//           : Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: selectedLatLng ?? const LatLng(20.5937, 78.9629),
//               zoom: 15,
//             ),
//             myLocationEnabled: true,
//             myLocationButtonEnabled: true,
//             onMapCreated: (controller) => mapController = controller,
//             onTap: (latLng) {
//               setState(() {
//                 selectedLatLng = latLng;
//               });
//               _getAddressFromLatLng(latLng);
//             },
//             markers: selectedLatLng != null
//                 ? {
//               Marker(
//                 markerId: const MarkerId("selected"),
//                 position: selectedLatLng!,
//                 icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
//               )
//             }
//                 : {},
//           ),
//
//           // SEARCH BAR
//           Positioned(
//             top: 10,
//             left: 15,
//             right: 15,
//             child: Card(
//               child: TextField(
//                 controller: searchCtrl,
//                 decoration: InputDecoration(
//                   hintText: "Search location...",
//                   prefixIcon: const Icon(Icons.search),
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.my_location),
//                     onPressed: _getCurrentLocation,
//                   ),
//                   border: InputBorder.none,
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                 ),
//                 onSubmitted: (value) {
//                   // Future mein Google Places API laga dena
//                   Get.snackbar("Info", "Search coming soon!");
//                 },
//               ),
//             ),
//           ),
//
//           // CENTER MARKER ICON
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 35),
//               child: Icon(Icons.location_on, size: 50, color: Colors.orange.shade700),
//             ),
//           ),
//
//           // ADDRESS DISPLAY
//           Positioned(
//             bottom: 20,
//             left: 15,
//             right: 15,
//             child: Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Text(
//                   selectedAddress,
//                   style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// views/auth/location_picker_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; // ← YE ADD KIYA (REAL ADDRESS KE LIYE)

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({super.key});
  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  GoogleMapController? mapController;
  LatLng? selectedLatLng;
  String selectedAddress = "Searching for your location...";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Error", "Location service is disabled", backgroundColor: Colors.red);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Error", "Location permission denied", backgroundColor: Colors.red);
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    LatLng currentLatLng = LatLng(position.latitude, position.longitude);

    String address = await _getAddressFromLatLng(currentLatLng);

    setState(() {
      selectedLatLng = currentLatLng;
      selectedAddress = address;
      isLoading = false;
    });

    mapController?.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, 16));
  }

  // REAL ADDRESS NIKALEGA (Google Geocoding)
  Future<String> _getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      Placemark place = placemarks[0];
      return "${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}".replaceAll(", ,", ",").trim();
    } catch (e) {
      return "Location Selected";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Temple Location"),
        backgroundColor: Colors.orange.shade700,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: selectedLatLng == null
                ? null
                : () {
              // YE ADDRESS SIGNUP PAGE PE WAAPAS BHEJEGA
              Get.back(result: selectedAddress);
            },
            child: const Text("DONE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: selectedLatLng ?? const LatLng(20.5937, 78.9629),
              zoom: 16,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (controller) => mapController = controller,
            onTap: (latLng) async {
              String address = await _getAddressFromLatLng(latLng);
              setState(() {
                selectedLatLng = latLng;
                selectedAddress = address;
              });
            },
            markers: selectedLatLng != null
                ? {
              Marker(
                markerId: const MarkerId("temple_location"),
                position: selectedLatLng!,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
              )
            }
                : {},
          ),

          // CENTER MARKER (fixed)
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Icon(Icons.location_on, size: 50, color: Colors.orange),
            ),
          ),

          // CURRENT LOCATION BUTTON
          Positioned(
            right: 15,
            bottom: 100,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: _getCurrentLocation,
              child: const Icon(Icons.my_location, color: Colors.orange),
            ),
          ),

          // ADDRESS CARD
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Text(
                  selectedAddress,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}