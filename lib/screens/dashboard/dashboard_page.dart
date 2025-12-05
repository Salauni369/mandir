import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../controllers/BottomNavController.dart';
import '../../controllers/darshan_controller.dart';
import '../../controllers/dashboard_cotroller.dart';
import '../../models/live_darshan_model.dart';
import '../budhism/boverview.dart';
import 'live_darshan/Livedarshan.dart';
import 'live_darshan/darshan_details.dart';
import 'manage.dart';
import 'menupage.dart';
import 'overview.dart';

class DashboardPage extends StatelessWidget {
   DashboardPage({super.key});
  // final DarshanController controller = Get.put((DarshanController()));
   // inside class
   final TempleHomeController controller = Get.put(TempleHomeController());


   @override
  Widget build(BuildContext context) {
    return Scaffold(


      backgroundColor: Colors.white,

      // TOP BAR
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
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
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 18,
                  child: Icon(Icons.person, color: Colors.black),
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
                final items = Get.find<DarshanController>().darshans;

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

  Widget _liveDarshanCard(DarshanModel darshan) {
    return InkWell(
      onTap: () {
        Get.to(() => DarshanDetailPage(darshan: darshan));
      },
      child: Container(
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
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                  child: Image.network(
                    darshan.webImage ?? "",
                    height: 130,
                    width: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
              child: Text(
                darshan.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, height: 1.3),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Widget _overviewCard() {
  //   return Container(
  //     padding: const EdgeInsets.all(14),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(14),
  //       border: Border.all(color: Colors.grey.shade300),
  //     ),
  //     child: Row(
  //       children: [
  //         ClipRRect(
  //           borderRadius: BorderRadius.circular(12),
  //           child: Image.asset(
  //             "assets/images/temp.png",
  //             height: 80,
  //             width: 90,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         const SizedBox(width: 14),
  //         const Expanded(
  //           child: Text(
  //             "ISKCON Temple Vrindavan\nHM98+352, Raman Reti, Vrindavan, Uttar Pradesh 281121",
  //             style: TextStyle(fontSize: 13, height: 1.4),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

   Widget _overviewCard() {
     return Obx(() {
       final home = controller.homeData.value;
       if (controller.loading.value) {
         return Container(
           height: 120,
           child: Center(child: CircularProgressIndicator()),
         );
       }
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
               child: Image.network(
                 home.image,
                 height: 80,
                 width: 90,
                 fit: BoxFit.cover,
                 errorBuilder: (context, error, stack) =>
                     Container(
                       height: 80,
                       width: 90,
                       color: Colors.grey.shade300,
                       child: Icon(Icons.broken_image, color: Colors.grey),
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
     });
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
