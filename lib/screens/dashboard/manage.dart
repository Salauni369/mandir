import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controllers/galary_controller.dart';
import '../../controllers/manage_controller.dart';
import 'overview.dart';
import 'location.dart';
import 'timming.dart';
import 'social_media.dart';
import 'galary.dart';


class ManageMainPage extends StatelessWidget {
 const ManageMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GalleryController());
    final controller = Get.put(ManageController());

    return Scaffold(
      backgroundColor: Colors.white,

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
            title: const Text("Manage", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),

                  onPressed: () => controller.saveAll(),
                  child: const Text("Update", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14,)),
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
        children:  [
          OverviewTab(),
          LocationTab(),
          TimingTab(),
          SocialMediaTab(),
          GalleryTab(),
        ],
      )),

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
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}