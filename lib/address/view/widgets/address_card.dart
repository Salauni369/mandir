// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../controller/get_address_controller.dart';
// import '../../controller/my_address_controller.dart';
// import '../../models/get_address_model.dart';
// import '../screens/select_location_screen.dart';
//
// class AddressCard extends StatelessWidget {
//   final AddressData addressData;
//   final String addressId;
//   final String label;
//   final String distance;
//   final String address;
//   final Color bgColor;
//   final int index;
//   final VoidCallback? onTap; // ✅ new parameter
//
//   AddressCard({
//     Key? key,
//     required this.label,
//     required this.distance,
//     required this.addressId,
//     required this.address,
//     this.bgColor = Colors.white,
//     this.index = 0,
//     required this.addressData,
//     this.onTap, // ✅ assign here
//   }) : super(key: key);
//
//   final getAddressController = Get.find<GetAddressController>();
//   final controller = Get.find<MyAddressController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap, // ✅ card-wide tap
//       borderRadius: BorderRadius.circular(8),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         margin: const EdgeInsets.only(bottom: 8),
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(width: 0.8, color: Colors.grey.shade200),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 📍 Icon
//             Padding(
//               padding: const EdgeInsets.only(top: 7.0),
//               child: Icon(
//                 addressData.types == "office"
//                     ? Icons.location_city
//                     : CupertinoIcons.home,
//                 size: addressData.types == "office" ? 20 : 18,
//                 color: Colors.black87.withAlpha(160),
//               ),
//             ),
//             const SizedBox(width: 10),
//
//             // 🏠 Address Details
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         label,
//                         style: GoogleFonts.roboto(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         '• $distance',
//                         style: GoogleFonts.roboto(
//                           fontSize: 14,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     address,
//                     style: GoogleFonts.roboto(
//                       fontSize: 13,
//                       color: Colors.grey[700],
//                       letterSpacing: 0.3,
//                       wordSpacing: 0.3,
//                     ),
//                     maxLines: 2,
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(width: 8),
//
//             // ⋮ Action Menu
//             InkWell(
//               onTap: () => _showBottomSheet(context),
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 child: const Icon(
//                   Icons.more_vert_outlined,
//                   size: 20,
//                   color: Colors.black54,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // 🔹 Bottom Sheet with Options
//   void _showBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       useSafeArea: true,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
//       ),
//       builder: (context) {
//         return Stack(
//           clipBehavior: Clip.none,
//           children: [
//             Padding(
//               padding:
//               const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Select Option",
//                     style: GoogleFonts.roboto(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//
//                   // ✏️ Edit
//                   _buildOption(
//                     icon: Icons.edit_outlined,
//                     label: "Edit Address",
//                     color: Colors.blueAccent,
//                     onTap: () {
//                       Navigator.pop(context);
//                       Get.to(() => SelectLocationScreen(
//                         type: "edit",
//                         addressData: addressData,
//                       ));
//                     },
//                   ),
//
//                   // 🗑️ Delete
//                   _buildOption(
//                     icon: Icons.delete_outline,
//                     label: "Delete Address",
//                     color: Colors.redAccent,
//                     onTap: () {
//                       Navigator.pop(context);
//                       controller
//                           .deleteAddressApi(addressId)
//                           .then((_) => getAddressController.getAddressListApi());
//                     },
//                   ),
//
//                   // 📍 Set as Default
//                   _buildOption(
//                     icon: Icons.location_on_outlined,
//                     label: "Set as Default Address",
//                     color: Colors.green,
//                     onTap: () {
//                       Navigator.pop(context);
//                       controller
//                           .setAsDefaultAddressApi(addressId)
//                           .then((_) => getAddressController.getAddressListApi());
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//               ),
//             ),
//
//             // ❌ Floating Close Button
//             Positioned(
//               top: -55,
//               left: 0,
//               right: 0,
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: InkWell(
//                   onTap: () => Navigator.pop(context),
//                   borderRadius: BorderRadius.circular(30),
//                   child: CircleAvatar(
//                     radius: 25,
//                     backgroundColor: Colors.black.withOpacity(0.85),
//                     child: const Icon(Icons.close,
//                         color: Colors.white, size: 22),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // 🔹 Option Builder
//   Widget _buildOption({
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       dense: true,
//       minLeadingWidth: 0,
//       contentPadding: EdgeInsets.zero,
//       leading: Icon(icon, size: 20, color: color),
//       title: Text(
//         label,
//         style: GoogleFonts.roboto(
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//           color: Colors.black87,
//         ),
//       ),
//       trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
//       onTap: onTap,
//     );
//   }
// }
