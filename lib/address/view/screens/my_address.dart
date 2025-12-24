// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:zamboree_devotion/address/view/screens/select_location_screen.dart';
// // import '../../controller/get_address_controller.dart';
// // import '../../controller/my_address_controller.dart';
// // import '../../shimer/address_card_shimmer.dart';
// // import '../widgets/address_card.dart';
// //
// // class MyAddress extends StatefulWidget {
// //   const MyAddress({Key? key}) : super(key: key);
// //
// //   @override
// //   State<MyAddress> createState() => _MyAddressState();
// // }
// //
// // class _MyAddressState extends State<MyAddress> {
// //   final controller = Get.find<GetAddressController>();
// //   final addressController = Get.find<MyAddressController>();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF5F5F5),
// //       appBar: CustomAppBarWidget(
// //         title: "My Address",
// //         height: 58,
// //         onBackPressed: () => Navigator.of(context).pop(),
// //       ),
// //       body: RefreshIndicator(
// //         onRefresh: () async => await controller.getAddressListApi(),
// //         child: ListView(
// //           padding:
// //               const EdgeInsetsGeometry.symmetric(horizontal: 15, vertical: 10),
// //           children: [
// //             // Add New Address Button
// //             InkWell(
// //               onTap: () => Get.to(() => const SelectLocationScreen()),
// //               child: Container(
// //                 padding: const EdgeInsetsGeometry.symmetric(
// //                     horizontal: 14, vertical: 13),
// //                 decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(12),
// //                     border: Border.all(width: 0.8, color: Colors.grey.shade100)),
// //                 child: Row(
// //                   children: [
// //                     const Icon(
// //                       Icons.add,
// //                       color: Colors.pink,
// //                       size: 22,
// //                       fontWeight: FontWeight.w400,
// //                     ),
// //                     const SizedBox(width: 8),
// //                     Text(
// //                       'Add New Address',
// //                       style: GoogleFonts.roboto(
// //                         color: Colors.pink,
// //                         fontSize: 15,
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                     const Spacer(),
// //                     const Icon(
// //                       Icons.arrow_forward_ios,
// //                       color: Colors.black,
// //                       size: 16,
// //                       fontWeight: FontWeight.w400,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             // Saved Addresses Header
// //             Text(
// //               'Saved Address ',
// //               style: GoogleFonts.roboto(
// //                 fontSize: 18,
// //                 fontWeight: FontWeight.w600,
// //                 color: Colors.black,
// //               ),
// //             ),
// //             const SizedBox(height: 15),
// //             // Address Cards
// //             Obx(() {
// //               if (controller.isLoading.value) {
// //                 return ListView.builder(
// //                   itemCount: 5,
// //                   shrinkWrap: true,
// //                   physics: const NeverScrollableScrollPhysics(),
// //                   itemBuilder: (context, index) => const AddressCardShimmer(),
// //                 );
// //               }
// //
// //               if (controller.getAddressDataModel.isEmpty) {
// //                 return Container(
// //                   alignment: Alignment.center,
// //                   padding: const EdgeInsetsGeometry.only(top: 200),
// //                   child: const Text("No saved addresses found."),
// //                 );
// //               }
// //
// //               return ListView.builder(
// //                 itemCount: controller.getAddressDataModel.length,
// //                 shrinkWrap: true,
// //                 physics: const NeverScrollableScrollPhysics(),
// //                 itemBuilder: (context, index) {
// //                   var data = controller.getAddressDataModel[index];
// //                   String distanceText = data.distanceInKm != null &&
// //                           data.distanceInKm != double.infinity
// //                       ? "${data.distanceInKm!.toStringAsFixed(1)} km"
// //                       : "N/A";
// //                   return AddressCard(
// //                       addressData: data,
// //                       index: index,
// //                       bgColor: data.isDefault == true
// //                           ? Colors.pink.shade100.withAlpha(100)
// //                           : Colors.white,
// //                       label: "${data.types?.capitalize}",
// //                       addressId: "${data.id}",
// //                       distance: distanceText,
// //                       address: data.addressLine1 ?? "",
// //                       onTap: () async {
// //                         controller.selectedAddress.value =
// //                             data; // ⭐ VERY IMPORTANT
// //
// //                         await addressController
// //                             .setAsDefaultAddressApi(data.id.toString());
// //                         await controller.getAddressListApi();
// //
// //                         if (!mounted) return;
// //
// //                         await AuthHelper.saveCoordinates(
// //                           latitude:
// //                               double.tryParse(data.latitude.toString()) ?? 0.0,
// //                           longitude:
// //                               double.tryParse(data.longitude.toString()) ?? 0.0,
// //                         );
// //
// //                         await AuthHelper.saveAddressData(
// //                           addressTitle: data.types!.capitalize.toString(),
// //                           addressSubTitle: data.addressLine1.toString(),
// //                           addressPlaceId: data.id ?? "",
// //                         );
// //
// //                         Get.back(); // 👈 Optional
// //                       }
// //
// //
// //                       );
// //                 },
// //               );
// //             }),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:zamboree_devotion/address/view/screens/select_location_screen.dart';
// import '../../../widgets/app_colors.dart';
// import '../../controller/get_address_controller.dart';
// import '../../controller/my_address_controller.dart';
// import '../../shimer/address_card_shimmer.dart';
// import '../widgets/address_card.dart';
//
// class MyAddress extends StatefulWidget {
//   const MyAddress({Key? key}) : super(key: key);
//
//   @override
//   State<MyAddress> createState() => _MyAddressState();
// }
//
// class _MyAddressState extends State<MyAddress> {
//   final controller = Get.find<GetAddressController>();
//   final addressController = Get.find<MyAddressController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//
//       // ✅ NORMAL APPBAR (FIXED)
//       appBar: AppBar(
//         backgroundColor: AppColors.hinduBase, // 👈 Hindu base color
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text(
//           "My Address",
//           style: GoogleFonts.roboto(
//             fontSize: 17,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//       ),
//
//       body: RefreshIndicator(
//         onRefresh: () async => await controller.getAddressListApi(),
//         child: ListView(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//           children: [
//             // Add New Address Button
//             InkWell(
//               onTap: () => Get.to(() => const SelectLocationScreen()),
//               child: Container(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border:
//                   Border.all(width: 0.8, color: Colors.grey.shade100),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.add,
//                       color: Colors.pink,
//                       size: 22,
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       'Add New Address',
//                       style: GoogleFonts.roboto(
//                         color: Colors.pink,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const Spacer(),
//                     const Icon(
//                       Icons.arrow_forward_ios,
//                       color: Colors.black,
//                       size: 16,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             Text(
//               'Saved Address',
//               style: GoogleFonts.roboto(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//               ),
//             ),
//
//             const SizedBox(height: 15),
//
//             // Address Cards
//             Obx(() {
//               if (controller.isLoading.value) {
//                 return ListView.builder(
//                   itemCount: 5,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemBuilder: (context, index) =>
//                   const AddressCardShimmer(),
//                 );
//               }
//
//               if (controller.getAddressDataModel.isEmpty) {
//                 return Container(
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.only(top: 200),
//                   child: const Text("No saved addresses found."),
//                 );
//               }
//
//               return ListView.builder(
//                 itemCount: controller.getAddressDataModel.length,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   var data = controller.getAddressDataModel[index];
//
//                   String distanceText =
//                   data.distanceInKm != null &&
//                       data.distanceInKm != double.infinity
//                       ? "${data.distanceInKm!.toStringAsFixed(1)} km"
//                       : "N/A";
//
//                   return AddressCard(
//                     addressData: data,
//                     index: index,
//                     bgColor: data.isDefault == true
//                         ? Colors.pink.shade100.withAlpha(100)
//                         : Colors.white,
//                     label: "${data.types?.capitalize}",
//                     addressId: "${data.id}",
//                     distance: distanceText,
//                     address: data.addressLine1 ?? "",
//                     onTap: () async {
//                       controller.selectedAddress.value = data;
//
//                       await addressController
//                           .setAsDefaultAddressApi(data.id.toString());
//                       await controller.getAddressListApi();
//
//                       if (!mounted) return;
//
//                       // ❗ AuthHelper error baad me fix karenge
//                       Get.back();
//                     },
//                   );
//                 },
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
