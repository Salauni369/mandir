import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../controllers/BottomNavController.dart';
import '../../controllers/darshan_controller.dart';
import '../../controllers/dashboard_cotroller.dart';
import '../../models/live_darshan_model.dart';

import '../../utils/imageconverter.dart';
import 'live_darshan/Livedarshan.dart';
import 'live_darshan/darshan_details.dart';
import 'manage.dart';
import 'menupage.dart';
import 'notification.dart';
import 'overview.dart';

class DashboardPage extends StatefulWidget {
   DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // final DarshanController controller = Get.put((DarshanController()));
   final TempleHomeController controller = Get.find<TempleHomeController>();

   final items = Get.find<DarshanController>().liveDarshans;

   @override
  void initState() {
     controller.fetchHomeData();
    super.initState();
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(


      backgroundColor: Colors.white,

      // TOP BAR
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          child: AppBar(
            backgroundColor: const Color(0xFFFF7A00),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Get.to(() => MenuPage());
              },
            ),
            title: const Text(
              "Dashboard",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Get.to(() => NotificationsPage());
                },
                child: Container(
                  margin: EdgeInsets.only(right: 16),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,     // PURE WHITE BG
                    shape: BoxShape.circle,  // CIRCULAR SHAPE
                  ),
                  child: Icon(
                    Icons.notifications,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ],

          ),
        ),
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
              children: [
                const Text(
                  "Live Darshan",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                       MaterialPageRoute(builder: (context) => DarshanMainPage()),
                    );
                  },
                  child: const Text(
                    "View All →",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
                // Text(
                //   "View All →",
                //   style: TextStyle(
                //     fontSize: 14,
                //     color: Colors.black87,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
              ],
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 210,
              child: Obx(() {
                final items = Get.find<DarshanController>().liveDarshans;

                if (items.isEmpty) {
                  return const Center(child: Text("No Live Darshan"));
                }

                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (_, i) => _liveDarshanCard(items[i]),
                );
              }),
            ),




            const SizedBox(height: 28),

            // ---------------- OVERVIEW ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Overview",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {
                    Get.find<BottomNavController>().changeTab(1);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 18, color: Colors.black87),
                      SizedBox(width: 5),
                      Text(
                        "Edit",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),

            const SizedBox(height: 14),
            _overviewCard(),

            const SizedBox(height: 28),

            // ---------------- TIMINGS ----------------
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 0),     // Make it full-width
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFFFF1E9),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Timings",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),

                  SizedBox(height: 12),

                  Obx(() {
                    final home = controller.homeData.value;
                    if (home == null) return SizedBox();

                    final darshan = home.timings["darshan"] ?? [];
                    final aarti = home.timings["aarti"] ?? [];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...darshan.map((e) => _timeRow(
                          "${_capitalize(e['title'])} Darshan",
                          "${e['start']} - ${e['end']}",
                        )),

                        if (aarti.isNotEmpty) SizedBox(height: 10),

                        ...aarti.map((e) => _timeRow(
                          "${_capitalize(e['title'])} Aarti",
                          "${e['start']} - ${e['end']}",
                        )),
                      ],
                    );
                  }),
                ],
              ),
            ),




            const SizedBox(height: 28),

            // ---------------- ABOUT ----------------
            const Text(
              "About",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            Obx(() {
              final home = controller.homeData.value;
              if (home == null) return SizedBox();
              return Text(
                home.about,
                style: TextStyle(fontSize: 12, height: 1.4,color:  Color(0xFFADADAD)),
              );
            }),

            const SizedBox(height: 10),


            // const Text(
            //   "ISKCON Vrindavan, also called Sri Krishna Balaram Mandir, is one of the major ISKCON temples in the world...",
            //   style: TextStyle(fontSize: 14, height: 1.4),
            // ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

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

   Widget _liveDarshanCard(DarshanModel darshan) {
     // SAFE IMAGE PICKER
     String? img;

     if (darshan.mobile_image != null && darshan.mobile_image!.isNotEmpty) {
       img = ImageConverter.optimizeCloudinaryUrl(darshan.mobile_image!);
     } else if (darshan.image.isNotEmpty) {
       img = ImageConverter.optimizeCloudinaryUrl(darshan.image);
     } else {
       img = "https://picsum.photos/200";
     }


     return GestureDetector(
       onTap: () => Get.to(() => DarshanDetailPage(darshan: darshan)),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Container(
             height: 160,
             width: 160,
             decoration: BoxDecoration(
               color: Colors.grey.shade200,
               borderRadius: BorderRadius.circular(8),
             ),
             child: Stack(
               children: [
                 Positioned.fill(
                   child: img!.startsWith("http")
                       ? CachedNetworkImage(
                     imageUrl: img!,
                     fit: BoxFit.cover,
                     placeholder: (_, __) =>
                     const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                     errorWidget: (_, __, ___) =>
                     const Icon(Icons.broken_image),
                   )
                       : Image.file(
                     File(img!),
                     fit: BoxFit.cover,
                   ),
                 ),


                 // ------------- LIVE BADGE (TOP RIGHT) -------------
                 if (darshan.isLive)
                   Positioned(
                     top: 6,
                     right: 6,
                     child: Container(
                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                       decoration: BoxDecoration(
                         color: Colors.red,
                         borderRadius: BorderRadius.circular(10),
                       ),
                       child: const Text(
                         "LIVE",
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 10,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                     ),
                   ),
               ],
             ),
           ),

           const SizedBox(height: 6),
           SizedBox(
             width: 160,
             child: Text(
               darshan.title,
               maxLines: 2,
               overflow: TextOverflow.ellipsis,
               style: const TextStyle(
                 fontSize: 12,
                 color: Colors.black,
               ),
             ),
           ),
         ],
       ),
     );
   }

   Widget _overviewCard() {
     return Obx(() {
       final home = controller.homeData.value;
       // if (controller.loading.value) {
       //   return Container(
       //     height: 120,
       //     child: Center(child: CircularProgressIndicator()),
       //   );
       // }
       if (home == null) {
         return Container(
           padding: const EdgeInsets.all(14),
           child: Text("No data available"),
         );
       }

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
               child:
               CachedNetworkImage(
                 imageUrl: ImageConverter.optimizeCloudinaryUrl(home.image),
                 height: 80,
                 width: 90,
                 fit: BoxFit.cover,
                 placeholder: (_, __) =>
                 const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                 errorWidget: (_, __, ___) => Container(
                   height: 80,
                   width: 90,
                   color: Colors.grey.shade300,
                   child: const Icon(Icons.broken_image),
                 ),
               ),



             ),

             const SizedBox(width: 14),
             Expanded(
               child: Text(
                 "${home.name}\n${home.location['city']}, ${home.location['state']}, ${home.location['country']}",
                 style: TextStyle(fontSize: 13, height: 1.4),
               ),
             )
           ],
         ),
       );
     }
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

   String _capitalize(String? s) {
     if (s == null || s.isEmpty) return "";
     return s[0].toUpperCase() + s.substring(1);
   }
}

