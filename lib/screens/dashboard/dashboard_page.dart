// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// import '../../controllers/dashboard_cotroller.dart';
//
//
// class DashboardPage extends StatelessWidget {
//   final TempleHomeController controller = Get.put(TempleHomeController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFFF7A1A),
//         elevation: 0,
//         title: const Text(
//           'Dashboard',
//           style: TextStyle(
//               fontWeight: FontWeight.w600, color: Colors.white),
//         ),
//       ),
//
//       body: Obx(() {
//         if (controller.loading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         final data = controller.homeData.value;
//
//         if (data == null) {
//           return const Center(child: Text("No Data Found"));
//         }
//
//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Row(
//                 children: [
//
//
//                 ],
//               ),
//
//               const SizedBox(height: 25),
//
//               /// ---------------- Overview ----------------
//               Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: CachedNetworkImage(
//                       imageUrl: data.image,
//                       width: 80,
//                       height: 80,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(data.name,
//                             style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600)),
//                         Text(
//                           "${data.location['city']}, ${data.location['state']}",
//                           style:
//                           TextStyle(color: Colors.grey[700]),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//
//               const SizedBox(height: 25),
//
//               /// ---------------- Timings ----------------
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                     color: Colors.orange.shade50,
//                     borderRadius: BorderRadius.circular(8)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text("Timings",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w600)),
//                     const SizedBox(height: 10),
//                     ..._buildTimings(data.timings),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//
//               /// ---------------- Gallery ----------------
//               const Text("Gallery",
//                   style: TextStyle(fontWeight: FontWeight.w600)),
//               const SizedBox(height: 10),
//
//               SizedBox(
//                 height: 120,
//                 child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: data.gallery.length,
//                   separatorBuilder: (_, __) =>
//                   const SizedBox(width: 10),
//                   itemBuilder: (_, i) =>
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: CachedNetworkImage(
//                           imageUrl: data.gallery[i],
//                           width: 150,
//                           height: 120,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//
//               /// ---------------- About ----------------
//               const Text("About",
//                   style: TextStyle(fontWeight: FontWeight.w600)),
//               const SizedBox(height: 8),
//               Text(data.about),
//             ],
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _imageCard(String url, {double height = 150}) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: CachedNetworkImage(
//         imageUrl: url,
//         height: height,
//         width: double.infinity,
//         fit: BoxFit.cover,
//         placeholder: (_, __) =>
//             Container(color: Colors.grey.shade200),
//       ),
//     );
//   }
//
//   List<Widget> _buildTimings(Map<String, dynamic> timings) {
//     final darshan = timings["darshan"] ?? [];
//     final aarti = timings["aarti"] ?? [];
//
//     List<Widget> list = [];
//
//     if (darshan.isNotEmpty) {
//       list.add(const Text("Darshan",
//           style: TextStyle(fontWeight: FontWeight.w600)));
//
//       for (var d in darshan) {
//         list.add(
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 4),
//             child: Row(
//               mainAxisAlignment:
//               MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(d["title"]),
//                 Text("${d["start"]} - ${d["end"]}"),
//               ],
//             ),
//           ),
//         );
//       }
//     }
//
//     if (aarti.isNotEmpty) {
//       list.add(const SizedBox(height: 8));
//       list.add(const Text("Aarti",
//           style: TextStyle(fontWeight: FontWeight.w600)));
//
//       for (var a in aarti) {
//         list.add(
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 4),
//             child: Row(
//               mainAxisAlignment:
//               MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(a["title"]),
//                 Text("${a["start"]} - ${a["end"]}"),
//               ],
//             ),
//           ),
//         );
//       }
//     }
//
//     return list;
//   }
// }
//
// //
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:cached_network_image/cached_network_image.dart';
// //
// // import '../../controllers/dashboard_cotroller.dart';
// //
// // class DashboardPage extends StatelessWidget {
// //   final TempleHomeController controller = Get.put(TempleHomeController());
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFFFF7A1A),
// //         elevation: 0,
// //         title: const Text(
// //           "Dashboard",
// //           style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
// //         ),
// //       ),
// //
// //       body: Obx(() {
// //         if (controller.loading.value) {
// //           return const Center(child: CircularProgressIndicator());
// //         }
// //
// //         final data = controller.homeData.value;
// //
// //         if (data == null) {
// //           return const Center(child: Text("No Data Found"));
// //         }
// //
// //         return SingleChildScrollView(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //
// //               /// ---------------- Banner ----------------
// //               ClipRRect(
// //                 borderRadius: BorderRadius.circular(14),
// //                 child: CachedNetworkImage(
// //                   imageUrl: data.image,
// //                   height: 180,
// //                   width: double.infinity,
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 18),
// //
// //               /// ---------------- Overview with Edit button ----------------
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   const Text(
// //                     "Overview",
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.w700,
// //                     ),
// //                   ),
// //
// //                   /// EDIT BUTTON
// //                   InkWell(
// //                     onTap: () {
// //                       Get.snackbar("Edit", "Edit clicked (Connect page later)");
// //                     },
// //                     child: Row(
// //                       children: const [
// //                         Icon(Icons.edit, size: 16, color: Colors.orange),
// //                         SizedBox(width: 4),
// //                         Text(
// //                           "Edit",
// //                           style: TextStyle(
// //                             color: Colors.orange,
// //                             fontWeight: FontWeight.w600,
// //                             fontSize: 14,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //
// //               const SizedBox(height: 8),
// //
// //               _overviewCard(data),
// //
// //               const SizedBox(height: 20),
// //
// //               /// ---------------- Gallery REMOVED ----------------
// //               // _sectionHeader("Gallery"),
// //               // const SizedBox(height: 10),
// //               // Gallery temporarily hidden
// //
// //               /// ---------------- Timings ----------------
// //               const Text(
// //                 "Timings",
// //                 style: TextStyle(
// //                     fontSize: 16, fontWeight: FontWeight.w700),
// //               ),
// //
// //               const SizedBox(height: 10),
// //               _timingCard(data.timings),
// //
// //               const SizedBox(height: 20),
// //
// //               /// ---------------- About ----------------
// //               const Text(
// //                 "About",
// //                 style: TextStyle(
// //                     fontSize: 16, fontWeight: FontWeight.w700),
// //               ),
// //               const SizedBox(height: 8),
// //
// //               Text(
// //                 data.about,
// //                 style: const TextStyle(
// //                   height: 1.4,
// //                   fontSize: 14,
// //                   color: Colors.black87,
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 20),
// //             ],
// //           ),
// //         );
// //       }),
// //     );
// //   }
// //
// //   // ---------------- COMPONENTS -----------------
// //
// //   Widget _overviewCard(data) {
// //     return Container(
// //       padding: const EdgeInsets.all(14),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(14),
// //         border: Border.all(color: Colors.grey.shade300),
// //       ),
// //       child: Row(
// //         children: [
// //           ClipRRect(
// //             borderRadius: BorderRadius.circular(12),
// //             child: CachedNetworkImage(
// //               imageUrl: data.image,
// //               width: 80,
// //               height: 80,
// //               fit: BoxFit.cover,
// //             ),
// //           ),
// //
// //           const SizedBox(width: 12),
// //
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   data.name,
// //                   style: const TextStyle(
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.w700,
// //                   ),
// //                 ),
// //
// //                 const SizedBox(height: 4),
// //
// //                 Text(
// //                   "${data.location['city']}, ${data.location['state']}",
// //                   style: const TextStyle(fontSize: 14, color: Colors.black54),
// //                 ),
// //
// //                 const SizedBox(height: 4),
// //
// //                 Text(
// //                   data.location['address'] ?? "",
// //                   maxLines: 2,
// //                   overflow: TextOverflow.ellipsis,
// //                   style: const TextStyle(fontSize: 12, color: Colors.black54),
// //                 ),
// //               ],
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _timingCard(Map<String, dynamic> timings) {
// //     final darshan = timings["darshan"] ?? [];
// //     final aarti = timings["aarti"] ?? [];
// //
// //     return Container(
// //       padding: const EdgeInsets.all(14),
// //       decoration: BoxDecoration(
// //         color: Colors.orange.shade50,
// //         borderRadius: BorderRadius.circular(14),
// //       ),
// //       child: Column(
// //         children: [
// //           if (darshan.isNotEmpty) ...[
// //             const Text("Darshan",
// //                 style: TextStyle(fontWeight: FontWeight.w700)),
// //             const SizedBox(height: 6),
// //             ...darshan.map((d) => _timingRow(d)).toList(),
// //           ],
// //
// //           const SizedBox(height: 14),
// //
// //           if (aarti.isNotEmpty) ...[
// //             const Text("Aarti",
// //                 style: TextStyle(fontWeight: FontWeight.w700)),
// //             const SizedBox(height: 6),
// //             ...aarti.map((a) => _timingRow(a)).toList(),
// //           ],
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _timingRow(d) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 4),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text(d["title"], style: const TextStyle(fontSize: 13)),
// //           Text("${d["start"]} - ${d["end"]}",
// //               style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// //



import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';

class DashboardPage extends StatelessWidget {
  final MotionTabBarController controller;
  const DashboardPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // TOP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7A00),
        elevation: 0,
        title: const Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: Icon(Icons.person, color: Colors.black),
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // -------------- STATS CARDS --------------
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    title: "Visitors",
                    value: "550k",
                    percent: "12%",
                    percentColor: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    title: "Live Attended",
                    value: "2.4k",
                    percent: "-2%",
                    percentColor: Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // ---------------- LIVE DARSHAN HEADER ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Live Darshan",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Text(
                  "View All →",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 210,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, __) => _liveDarshanCard(),
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemCount: 2,
              ),
            ),

            const SizedBox(height: 28),

            // ---------------- OVERVIEW ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Overview",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                Icon(Icons.edit, size: 18),
              ],
            ),

            const SizedBox(height: 14),
            _overviewCard(),

            const SizedBox(height: 28),

            // ---------------- TIMINGS ----------------
            const Text(
              "Timings",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            _timeRow("Morning Darshan", "04:30 AM - 12:45 PM"),
            const SizedBox(height: 10),
            _timeRow("Evening Darshan", "4:00 PM - 8:30 PM"),

            const SizedBox(height: 28),

            // ---------------- ABOUT ----------------
            const Text(
              "About",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            const Text(
              "ISKCON Vrindavan, also called Sri Krishna Balaram Mandir, is one of the major ISKCON temples in the world...",
              style: TextStyle(fontSize: 14, height: 1.4),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------
  // ------------------- WIDGETS ------------------------
  // ----------------------------------------------------

  Widget _statCard({
    required String title,
    required String value,
    required String percent,
    required Color percentColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up, color: percentColor, size: 18),
              const SizedBox(width: 4),
              Text(
                percent,
                style: TextStyle(
                  color: percentColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _liveDarshanCard() {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(14)),
                child: Image.network(
                  "assets/images/krishna.png",
                  height: 130,
                  width: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "Live",
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: const Text(
              "ISKCON Krishna Janmashtami Live Darshan from Vrindavan",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _overviewCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/images/temp.png",
              height: 80,
              width: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              "ISKCON Temple Vrindavan\nHM98+352, Raman Reti, Vrindavan, Uttar Pradesh 281121",
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
          )
        ],
      ),
    );
  }

  Widget _timeRow(String title, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 14)),
        Text(
          time,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
