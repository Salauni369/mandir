// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../controller/get_address_controller.dart';
// import '../../controller/my_address_controller.dart';
// import '../../models/get_address_model.dart';
//
// class AddAddressDetailsScreen extends StatefulWidget {
//   final AddressData? addressData;
//   final LatLng selectedLatLng;
//   final String selectedAddress;
//   final String selectedTitle;
//   final String pageType;
//
//   // Optional location components
//   final String country;
//   final String city;
//   final String state;
//   final String zipCode;
//
//   const AddAddressDetailsScreen({
//     Key? key,
//     required this.selectedLatLng,
//     required this.selectedAddress,
//     required this.pageType,
//     this.addressData,
//     this.selectedTitle = '',
//     this.country = '',
//     this.city = '',
//     this.state = '',
//     this.zipCode = '',
//   }) : super(key: key);
//
//   @override
//   State<AddAddressDetailsScreen> createState() => _AddAddressDetailsScreenState();
// }
//
// class _AddAddressDetailsScreenState extends State<AddAddressDetailsScreen> {
//   final _addressController = Get.find<MyAddressController>();
//   final _getAddressController = Get.find<GetAddressController>();
//
//   final TextEditingController _buildingController = TextEditingController();
//   final TextEditingController _landmarkController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//
//   RxString selectedLabel = 'home'.obs;
//
//   bool get isButtonEnabled =>
//       _nameController.text.isNotEmpty && _phoneController.text.isNotEmpty;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController.addListener(_updateState);
//     _phoneController.addListener(_updateState);
//     _saveData();
//   }
//
//   _saveData(){
//     if(widget.addressData?.id != null && widget.pageType == "edit"){
//       selectedLabel.value = widget.addressData?.types ?? "Home";
//       _buildingController.text = widget.addressData?.flat ?? "";
//       _landmarkController.text = widget.addressData?.landmark ?? "";
//       _nameController.text = widget.addressData?.firstName ?? "";
//       _phoneController.text = widget.addressData!.mobile.toString();
//     }
//   }
//
//   void _updateState() => setState(() {});
//
//   @override
//   void dispose() {
//     _buildingController.dispose();
//     _landmarkController.dispose();
//     _nameController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("sjhsb ${selectedLabel.value}");
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Add Address Details',
//           style: GoogleFonts.roboto(
//             fontSize: 17,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 🌍 MAP SECTION
//             SizedBox(
//               height: 250,
//               width: double.infinity,
//               child: GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: widget.selectedLatLng,
//                   zoom: 16,
//                 ),
//                 markers: {
//                   Marker(
//                     markerId: const MarkerId('selectedLocation'),
//                     position: widget.selectedLatLng,
//                   ),
//                 },
//                 mapType: MapType.normal,
//                 zoomGesturesEnabled: true,
//                 zoomControlsEnabled: false,
//                 myLocationButtonEnabled: false,
//                 mapToolbarEnabled: false,
//                 trafficEnabled: true,
//                 buildingsEnabled: true,
//                 compassEnabled: true,
//                 onMapCreated: (GoogleMapController controller) async {
//                   await Future.delayed(const Duration(milliseconds: 400));
//                   controller.animateCamera(
//                     CameraUpdate.newCameraPosition(
//                       CameraPosition(
//                         target: widget.selectedLatLng,
//                         zoom: 16.5,
//                         tilt: 35,
//                       ),
//                     ),
//                   );
//                   controller.setMapStyle(null);
//                 },
//               ),
//             ),
//
//             // 📍 ADDRESS SUMMARY
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 border: Border(
//                   bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         if (widget.selectedTitle.isNotEmpty)
//                           Text(
//                             widget.selectedTitle,
//                             style: GoogleFonts.roboto(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         const SizedBox(height: 2),
//                         Text(
//                           widget.selectedAddress,
//                           style: GoogleFonts.roboto(
//                             fontSize: 14,
//                             color: Colors.grey[700],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   OutlinedButton(
//                     onPressed: () => Get.back(),
//                     style: OutlinedButton.styleFrom(
//                       side: const BorderSide(color: Colors.black),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
//                     ),
//                     child: const Text(
//                       'Change',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // 🧾 ADDRESS FORM
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _sectionTitle('Add Address'),
//                   const SizedBox(height: 12),
//                   // _buildLabel('House No. & Floor *'),
//                   // const SizedBox(height: 8),
//                   // _buildTextField(_houseController, 'Enter house number..'),
//                   // const SizedBox(height: 20),
//                   _buildLabel('Building & Block No. (Optional)'),
//                   const SizedBox(height: 8),
//                   _buildTextField(_buildingController, 'Enter building..'),
//                   const SizedBox(height: 20),
//                   _buildLabel('Landmark & Area Name (Optional)'),
//                   const SizedBox(height: 8),
//                   _buildTextField(_landmarkController, 'Enter landmark..'),
//                   const SizedBox(height: 32),
//
//                   _sectionTitle('Add Address Label'),
//                   const SizedBox(height: 12),
//                   // 📍 Add this inside your build() where label buttons are shown
//                   Obx(() => Row(
//                     children: [
//                       _buildLabelChipWithIcon('home', Icons.home, selectedLabel.value == 'home'),
//                       const SizedBox(width: 12),
//                       _buildLabelChipWithIcon('office', Icons.work_outline, selectedLabel.value == 'office'),
//                     ],
//                   )),
//
//
//                   const SizedBox(height: 25),
//                   _sectionTitle('Receiver Details'),
//                   const SizedBox(height: 12),
//                   _buildLabel("Receiver's Name"),
//                   const SizedBox(height: 8),
//                   _buildTextField(_nameController, 'Enter full name..', suffixIcon: Icons.person_outline),
//                   const SizedBox(height: 20),
//                   _buildLabel("Receiver's Phone Number"),
//                   const SizedBox(height: 8),
//                   _buildTextField(_phoneController, 'Enter phone number..',
//                       prefixText: '+91 ', keyboardType: TextInputType.phone),
//                   const SizedBox(height: 40),
//
//                   // 💾 SAVE BUTTON
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: Obx(()=> ElevatedButton(
//                         onPressed: isButtonEnabled || widget.pageType == "edit"
//                             ? () async {
//                           final type = selectedLabel;
//                           final deliveryTime = type == "home"
//                               ? "7am - 9pm"
//                               : "10am - 6pm";
//                           await _addressController.addAndEditAddressApi(
//                             pageType: widget.pageType,
//                             addressId: widget.addressData?.id ?? "",
//                             type: selectedLabel.value,
//                             deliveryTime: deliveryTime,
//                             firstName: _nameController.text,
//                             country: widget.country,
//                             addressLine1: widget.selectedAddress,
//                             latitude: widget.selectedLatLng.latitude.toString(),
//                             longitude: widget.selectedLatLng.longitude.toString(),
//                             mobile: _phoneController.text,
//                             flat: _buildingController.text,
//                             landmark: _landmarkController.text,
//                             city: widget.city,
//                             state: widget.state,
//                             zipCode: widget.zipCode,
//                             isDefault: true,
//                           );
//                           if(mounted){
//                             Navigator.of(context).pop();
//                             Navigator.of(context).pop();
//                             _getAddressController.getAddressListApi();
//                           }
//                         } : null,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: isButtonEnabled  || widget.pageType == "edit" ? Colors.pink : Colors.grey[400],
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: _addressController.isLoading.value
//                             ? const SizedBox(
//                           height: 24,
//                           width: 24,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2.5,
//                             color: Colors.white,
//                           ),
//                         ) : Text(
//                           'SAVE ADDRESS',
//                           style: GoogleFonts.roboto(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _sectionTitle(String text) => Text(
//     text,
//     style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
//   );
//
//   Widget _buildLabelChipWithIcon(String label, IconData icon, bool isSelected) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: () => selectedLabel.value = label, // ✅ GetX reactive update
//         child: Obx(() => Container(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           decoration: BoxDecoration(
//             color: selectedLabel.value == label ? Colors.black : Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: selectedLabel.value == label
//                   ? Colors.black
//                   : const Color(0xFFE0E0E0),
//               width: 0.8,
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 size: 16,
//                 color: selectedLabel.value == label
//                     ? Colors.white
//                     : Colors.grey[700],
//               ),
//               const SizedBox(width: 6),
//               Text(
//                 label.capitalize!,
//                 style: GoogleFonts.roboto(
//                   color: selectedLabel.value == label
//                       ? Colors.white
//                       : Colors.grey[700],
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         )),
//       ),
//     );
//   }
//
//   Widget _buildLabel(String text) =>
//       Text(text, style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[700]));
//
//   Widget _buildTextField(TextEditingController controller, String hint,
//       {IconData? suffixIcon, String? prefixText, TextInputType? keyboardType}) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         hintText: hint,
//         filled: true,
//         fillColor: Colors.white,
//         hintStyle: TextStyle(color: Colors.grey[700]),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
//         prefixText: prefixText,
//         prefixStyle: const TextStyle(
//           color: Colors.black,
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//         ),
//         suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.black54) : null,
//       ),
//     );
//   }
// }
