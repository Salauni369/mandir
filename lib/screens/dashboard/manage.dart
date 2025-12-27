// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../controllers/galary_controller.dart';
// import '../../controllers/manage_controller.dart';
//
// import 'overview.dart';
// import 'location.dart';
// import 'timming.dart';
// import 'social_media.dart';
// import 'galary.dart';
//
// class ManageMainPage extends StatelessWidget {
//   const ManageMainPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(GalleryController());
//     final controller = Get.put(ManageController());
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//
//       // ================= APP BAR =================
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(110),
//         child: Container(
//           decoration: const BoxDecoration(
//             color: Color(0xFFFF7722),
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(8),
//               bottomRight: Radius.circular(8),
//             ),
//           ),
//           child: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             automaticallyImplyLeading: false,
//
//             title: const Text(
//               "Manage",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//
//             // ================= UPDATE BUTTON =================
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Obx(
//                       () => ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black,
//                       disabledBackgroundColor: Colors.black54,
//                     ),
//
//                     onPressed: controller.isSaving.value
//                         ? null
//                         : () {
//                       switch (controller.activeTab.value) {
//                         case 0:
//                           controller.saveAll(); // Overview
//                           break;
//                         case 1:
//                           Get.snackbar("Info", "Location update coming soon");
//                           break;
//                         case 2:
//                           controller.saveTiming();
//                           break;
//                         case 3:
//                           controller.saveSocial();
//                           break;
//                         case 4:
//                           Get.snackbar("Info", "Gallery update coming soon");
//                           break;
//                       }
//                     },
//
//                     child: controller.isSaving.value
//                         ? const SizedBox(
//                       width: 16,
//                       height: 16,
//                       child: CircularProgressIndicator(
//                         color: Colors.white,
//                         strokeWidth: 2,
//                       ),
//                     )
//                         : const Text(
//                       "Update",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//
//             // ================= TABS =================
//             bottom: PreferredSize(
//               preferredSize: const Size.fromHeight(60),
//               child: Container(
//                 margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Obx(
//                         () => Row(
//                       children: [
//                         _customTab("Overview", 0, controller),
//                         _customTab("Location", 1, controller),
//                         _customTab("Timing", 2, controller),
//                         _customTab("Social Media", 3, controller),
//                         _customTab("Gallery", 4, controller),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//
//       // ================= BODY =================
//       body: Obx(
//             () => IndexedStack(
//           index: controller.activeTab.value,
//           children:  [
//             OverviewTab(),
//             LocationPage(),
//             TimingTab(),
//             SocialMediaTab(),
//             GalleryTab(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ================= CUSTOM TAB =================
//   Widget _customTab(String title, int index, ManageController controller) {
//     final isSelected = controller.activeTab.value == index;
//
//     return GestureDetector(
//       onTap: () => controller.changeTab(index),
//       child: Container(
//         margin: const EdgeInsets.only(right: 16),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           border: Border(
//             bottom: BorderSide(
//               color: isSelected ? Colors.white : Colors.transparent,
//               width: 3,
//             ),
//           ),
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.white70,
//             fontSize: 16,
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/galary_controller.dart';
import '../../controllers/manage_controller.dart';

import 'overview.dart';
import 'location.dart';
import 'timming.dart';
import 'social_media.dart';
import 'galary.dart';

class ManageMainPage extends StatefulWidget {
  const ManageMainPage({super.key});

  @override
  State<ManageMainPage> createState() => _ManageMainPageState();
}

class _ManageMainPageState extends State<ManageMainPage>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;
  late ManageController controller;

  @override
  void initState() {
    super.initState();

    // Init controllers ONCE
    Get.put(GalleryController());
    controller = Get.put(ManageController());

    // Tab controller for swipe + button sync
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFF7722),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,

            title: const Text(
              "Manage",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            // ================= UPDATE BUTTON =================
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                      () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      disabledBackgroundColor: Colors.black54,
                    ),

                    onPressed: controller.isSaving.value
                        ? null
                        : () {
                      final index = _tabController.index;

                      switch (index) {
                        case 0:
                          controller.saveAll(); // Overview
                          break;

                        case 1:
                         // controller.saveLocation(); // Location
                          break;

                        case 2:
                          controller.saveTiming(); // Timing
                          break;

                        case 3:
                          controller.saveSocial(); // Social
                          break;

                        case 4:
                          Get.snackbar(
                            "Info",
                            "Gallery auto-saves",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          break;
                      }
                    },

                    child: controller.isSaving.value
                        ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text(
                      "Update",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],

            // ================= TABS =================
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: const [
                Tab(text: "Overview"),
                Tab(text: "Location"),
                Tab(text: "Timing"),
                Tab(text: "Social Media"),
                Tab(text: "Gallery"),
              ],
            ),
          ),
        ),
      ),

      // ================= BODY (SWIPE ENABLED) =================
      body: TabBarView(
        controller: _tabController,
        physics: const BouncingScrollPhysics(),
        children: const [
          OverviewTab(),
          LocationPage(),
          TimingTab(),
          SocialMediaTab(),
          GalleryTab(),
        ],
      ),
    );
  }
}
