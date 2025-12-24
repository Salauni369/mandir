// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../../controller/select_location_controller.dart';
//
// class LocationSearchBottomSheet extends StatefulWidget {
//   final PlacesApiService placesService;
//   const LocationSearchBottomSheet({super.key, required this.placesService});
//
//   @override
//   State<LocationSearchBottomSheet> createState() =>
//       _LocationSearchBottomSheetState();
// }
//
// class _LocationSearchBottomSheetState extends State<LocationSearchBottomSheet> {
//   final controller = Get.find<SelectLocationController>();
//   final TextEditingController _searchController = TextEditingController();
//   Timer? _debounceTimer;
//
//   final _suggestions = <LocationSuggestion>[].obs;
//   final _isLoading = false.obs;
//   final _recentSearches = <String>[].obs;
//   final String _prefKey = 'recent_location_searches';
//
//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_onSearchChanged);
//     _loadRecentSearches();
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
//       final results = await widget.placesService.getAutocompleteSuggestions(
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
//   Future<void> _onSuggestionTap(LocationSuggestion suggestion) async {
//     FocusScope.of(context).unfocus();
//     Navigator.pop(context); // close bottom sheet
//     await _saveRecentSearch(suggestion.mainText);
//
//     try {
//       final details =
//       await widget.placesService.getPlaceDetails(placeId: suggestion.placeId);
//       controller.animateToLocation(
//         LatLng(details.latitude, details.longitude),
//       );
//       print("skjsn ${details}");
//       controller.currentLatLng.value = LatLng(details.latitude, details.longitude);
//       controller.formatTitleAndAddress(details.name, details.formattedAddress);
//     } catch (e) {
//       Get.snackbar("Error", "Failed to get place details");
//     }
//   }
//
//   Future<void> _loadRecentSearches() async {
//     final prefs = await SharedPreferences.getInstance();
//     final saved = prefs.getStringList(_prefKey) ?? [];
//     _recentSearches.assignAll(saved);
//   }
//
//   Future<void> _saveRecentSearch(String search) async {
//     if (search.isEmpty) return;
//     _recentSearches.remove(search);
//     _recentSearches.insert(0, search);
//     if (_recentSearches.length > 10) _recentSearches.removeLast();
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList(_prefKey, _recentSearches);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//       expand: false,
//       initialChildSize: 0.9,
//       minChildSize: 0.3,
//       maxChildSize: 0.9,
//       builder: (context, scrollController) {
//         return Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
//           ),
//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
//               child: Column(
//                 children: [
//                   // ---------------- SEARCH ROW ----------------
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _searchController,
//                           decoration: InputDecoration(
//                             hintText: "Search location...",
//                             prefixIcon: const Icon(Icons.search),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide: BorderSide.none,
//                             ),
//                             filled: true,
//                             fillColor: Colors.grey[200],
//                             contentPadding:
//                             const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 5),
//                       GestureDetector(
//                         onTap: () => Navigator.pop(context),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.grey[300],
//                           ),
//                           padding: const EdgeInsets.all(8),
//                           child: const Icon(Icons.close, size: 24),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//
//                   // ---------------- SUGGESTIONS LIST ----------------
//                   Expanded(
//                     child: Obx(() {
//                       if (_searchController.text.isEmpty &&
//                           _recentSearches.isNotEmpty) {
//                         // Show recent searches
//                         return ListView.builder(
//                           controller: scrollController,
//                           itemCount: _recentSearches.length,
//                           itemBuilder: (_, index) {
//                             final recent = _recentSearches[index];
//                             return ListTile(
//                               leading:
//                               const Icon(Icons.history, color: Colors.grey),
//                               title: Text(recent),
//                               onTap: () {
//                                 _searchController.text = recent;
//                                 _fetchSuggestions(recent);
//                               },
//                             );
//                           },
//                         );
//                       } else if (_isLoading.value) {
//                         // Shimmer loading
//                         return ListView.builder(
//                           controller: scrollController,
//                           itemCount: 6,
//                           itemBuilder: (_, index) {
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 8),
//                               child: Shimmer.fromColors(
//                                 baseColor: Colors.grey.shade300,
//                                 highlightColor: Colors.grey.shade100,
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       width: 24,
//                                       height: 24,
//                                       color: Colors.white,
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           Container(
//                                             height: 12,
//                                             color: Colors.white,
//                                           ),
//                                           const SizedBox(height: 6),
//                                           Container(
//                                             height: 12,
//                                             width: 150,
//                                             color: Colors.white,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       } else if (_suggestions.isEmpty) {
//                         return const Center(child: Text("No results found"));
//                       } else {
//                         return ListView.builder(
//                           controller: scrollController,
//                           itemCount: _suggestions.length,
//                           padding: EdgeInsets.zero,
//                           itemBuilder: (_, index) {
//                             final suggestion = _suggestions[index];
//                             final titleText =
//                             suggestion.mainText.isNotEmpty ? suggestion.mainText : suggestion.secondaryText;
//                             final subtitleText =
//                             suggestion.mainText.isNotEmpty ? suggestion.secondaryText : null;
//
//                             return InkWell(
//                               onTap: ()=> _onSuggestionTap(suggestion),
//                               child: Container(
//                                 padding: const EdgeInsetsGeometry.symmetric(vertical: 10),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 6.0),
//                                       child: Icon(Icons.location_on, size: 22, color: Colors.grey.shade700,),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Flexible(
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             titleText,
//                                             style: GoogleFonts.roboto(
//                                               fontSize: 15,
//                                               wordSpacing: 0.3,
//                                               letterSpacing: 0.3,
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                           Text(
//                                             subtitleText.toString(),
//                                             style: GoogleFonts.roboto(
//                                               fontSize: 14,
//                                               wordSpacing: 0.3,
//                                               letterSpacing: 0.3,
//                                               color: Colors.grey.shade600,
//                                               fontWeight: FontWeight.w400,
//                                               height: 1.35,
//                                             ),
//                                             maxLines: 2,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//
//                       }
//                     }),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
