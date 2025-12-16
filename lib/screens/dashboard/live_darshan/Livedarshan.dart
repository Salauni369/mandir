


// lib/screens/darshan/darshan_main_page.dart

import '../../../widgets/live_darshan.dart';
import '../../../widgets/pastdarshan.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/darshan_controller.dart';
import '../../../widgets/app_colors.dart';
import 'add_darshan.dart';
import 'darshan_details.dart';

class DarshanMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(DarshanController());
    final controller = Get.find<DarshanController>();


    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: AppColors.hinduBase,
        title: Text(
          "Live Darshan",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),

        // Rounded bottom-left and bottom-right
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () => Get.to(() => AddDarshanPage()),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.white, size: 20),
                    SizedBox(width: 6),
                    Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.hinduBase),
          );
        }

        final live = controller.liveDarshans;
        final past = controller.pastDarshans;

        return RefreshIndicator(
          onRefresh: controller.fetchDarshans,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [


              Text(
                "Live Darshan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 12),

              live.isEmpty
                  ? Text("No Live Darshan",
                  style: TextStyle(fontSize: 14))
                  : GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: live.length,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (_, i) {
                  final darshan = live[i];
                  return DarshanCard(
                    darshan: darshan,
                    onTap: () => Get.to(
                          () => DarshanDetailPage(darshan: darshan),
                    ),
                  );
                },
              ),

              SizedBox(height: 25),

              // ---------------- PAST SECTION ----------------
              Container(
                padding: EdgeInsets.all(8),
                color: Color(0xFFFFF1E9),
                child: Text(
                  "Past Darshans",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 14),

              past.isEmpty
                  ? Text("No Past Darshan",
                  style: TextStyle(fontSize: 14))
                  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: past.length,
                itemBuilder: (_, i) {
                  final item = past[i];
                  return PastDarshanCard(
                    darshan: item,
                    onTap: () => Get.to(
                          () => DarshanDetailPage(darshan: item),
                    ),
                  );
                },
              ),

              SizedBox(height: 40),
            ],
          ),
        );
      }),
    );
  }
}


