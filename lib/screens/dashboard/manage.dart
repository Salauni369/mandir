import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';

import '../../controllers/manage_controller.dart';
import 'overview.dart';
import 'location.dart';
import 'timming.dart';
import 'social_media.dart';
import 'galary.dart';

// class CustomBottomNav extends StatelessWidget {
//   final int currentIndex;
//   const CustomBottomNav({super.key, required this.currentIndex});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.symmetric(vertical: 14),
//       decoration: BoxDecoration(
//         color: const Color(0xFFFF7722),
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _navItem("dashboard.svg", "Dashboard", 0, '/dashboard'),
//           _navItem("manage.svg", "Manage", 1, '/manage'),
//           _navItem("live.svg", "Live", 2, '/live'),
//           _navItem("donate.svg", "Donate", 3, '/donate'),
//         ],
//       ),
//     );
//   }
//
//   Widget _navItem(String icon, String label, int index, String route) {
//     bool isSelected = currentIndex == index;
//     return GestureDetector(
//       onTap: () {
//         if (!isSelected) Get.offAllNamed(route);
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SvgPicture.asset(
//             "assets/icons/$icon",
//             width: 26,
//             height: 26,
//             colorFilter: ColorFilter.mode(
//               isSelected ? Colors.yellow : Colors.white,
//               BlendMode.srcIn,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               color: isSelected ? Colors.yellow : Colors.white,
//               fontSize: 11,
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ManageMainPage extends StatelessWidget {
  final MotionTabBarController controller;

 const ManageMainPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ManageController());

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFF7722),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const Text("Manage", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),

                  onPressed: () => controller.saveAll(),
                  child: const Text("Update", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16,)),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(() => Row(
                    children: [
                      _customTab("Overview", 0, controller),
                      _customTab("Location", 1, controller),
                      _customTab("Timing", 2, controller),
                      _customTab("Social Media", 3, controller),
                      _customTab("Gallery", 4, controller),
                    ],
                  )),
                ),
              ),
            ),
          ),
        ),
      ),

      // BODY — TABS SMOOTHLY SWITCH HONGE
      body: Obx(() => IndexedStack(
        index: controller.activeTab.value,
        children: const [
          OverviewTab(),
          LocationTab(),
          TimingTab(),
          SocialMediaTab(),
          GalleryTab(),
        ],
      )),

      // YE HI  this is to much predicticable to ya sy ha hb xhja zhyxa PREMIUM BOTTOM NAV AB SAB JAGAH CHALEGA
      //bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
    );
  }

  Widget _customTab(String title, int index, ManageController controller) {
    final isSelected = controller.activeTab.value == index;

    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}