// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
// // import '../../../controllers/darshan_controller.dart';
// // import '../../../myRoutes/mypagesname.dart';
// // import '../../../widgets/live_darshan.dart';
// //
// //
// // class DarshanPage extends StatelessWidget {
// //   final MotionTabBarController controller;
// //    DarshanPage({super.key, required this.controller});
// //
// //   final DarshanController c = Get.put(DarshanController());
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Live Darshan")),
// //
// //       body: Padding(
// //         padding: const EdgeInsets.all(14),
// //         child: Obx(() {
// //           return GridView.builder(
// //             itemCount: c.list.length,
// //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //               crossAxisCount: 2,
// //               childAspectRatio: .75,
// //               mainAxisSpacing: 12,
// //               crossAxisSpacing: 12,
// //             ),
// //             itemBuilder: (_, i) {
// //               final model = c.list[i];
// //               return DarshanCard(
// //                 model: model,
// //                 onTap: () => Get.toNamed(MyPagesName.darshandetail, arguments: model),
// //               );
// //             },
// //           );
// //         }),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controllers/darshan_controller.dart';
// import '../../../myRoutes/mypagesname.dart';
// import '../../../widgets/live_darshan.dart';
//
// class DarshanPage extends StatefulWidget {
//   DarshanPage({super.key});
//
//   @override
//   State<DarshanPage> createState() => _DarshanPageState();
// }
//
// class _DarshanPageState extends State<DarshanPage> {
//   final DarshanController c = Get.put(DarshanController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFFF7A00),
//         title: const Text("Darshan"),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 14),
//             child: ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 elevation: 0,
//                 backgroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//               ),
//               child: const Text(
//                 " Add",
//                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
//               ),
//             ),
//           ),
//         ],
//       ),
//
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             // 🔥 Live Darshan Heading
//             const Text(
//               "Live Darshan",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//             ),
//             const SizedBox(height: 12),
//
//             // 🔥 Live Darshan Grid
//             Obx(() {
//               return GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: c.list.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: .74,
//                   mainAxisSpacing: 12,
//                   crossAxisSpacing: 12,
//                 ),
//                 itemBuilder: (_, i) {
//                   final model = c.list[i];
//                   return DarshanCard(
//                     model: model,
//                     // onTap: () => Get.toNamed(MyPagesName.darshandetail, arguments: model),
//                     // onTap: () => Get.toNamed(MyPagesName.darshandetail, arguments: model),
//                   );
//                 },
//               );
//             }),
//
//             const SizedBox(height: 22),
//
//             // 🔥 Past Darshan Heading
//             const Text(
//               "Past Darshans",
//               style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
//             ),
//             const SizedBox(height: 10),
//
//             // 🔥 Past Darshan List
//             Obx(() {
//               return ListView.separated(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: c.list.length,
//                 separatorBuilder: (_, __) => const SizedBox(height: 12),
//                 itemBuilder: (_, i) {
//                   final m = c.list[i];
//                   return Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.grey.shade300),
//                     ),
//                     child: Row(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.network(m.image, height: 70, width: 70, fit: BoxFit.cover),
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: Text(
//                             m.title,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             }),
//
//             const SizedBox(height: 70),
//           ],
//         ),
//       ),
//     );
//   }
// }

// lib/screens/darshan/darshan_main_page.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:untitled/widgets/My_text.dart';
// import '../../../controllers/darshan_controller.dart';
// // import '../../../widgets/My_text.dart';
// import '../../../widgets/app_colors.dart';
// import '../../../widgets/live_darshan.dart';
// import 'add_darshan.dart';
//
// class DarshanMainPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(DarshanController());
//
//     return Scaffold(
//       backgroundColor: AppColors.hinduL1,
//       appBar: AppBar(
//         backgroundColor: AppColors.hinduBase,
//           title: Text("Darshan", style: TextStyle(fontSize: 20,color: Colors.white)),
//
//           actions: [
//           IconButton(icon: Icon(Icons.add, color: Colors.white), onPressed: () {
//             Get.to(() => AddDarshanPage());
//           }),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: AppColors.hinduBase,
//         child: Icon(Icons.add, color: Colors.white),
//         onPressed: () => Get.to(() => AddDarshanPage()),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator(color: AppColors.hinduBase));
//         }
//         if (controller.darshans.isEmpty) {
//           return Center(child: Text("No Darshan Available", style: TextStyle(fontSize: 16)));
//         }
//
//         return RefreshIndicator(
//           onRefresh: controller.fetchDarshans,
//           child: ListView.builder(
//             padding: EdgeInsets.all(16),
//             itemCount: controller.darshans.length,
//             itemBuilder: (context, index) {
//               final darshan = controller.darshans[index];
//               return DarshanCard(darshan: darshan);
//             },
//           ),
//         );
//       }),
//     );
//   }
// }


// lib/screens/darshan/darshan_main_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/dashboard/live_darshan/darshan_details.dart';

import '../../../controllers/darshan_controller.dart';
import '../../../widgets/app_colors.dart';
import '../../../widgets/live_darshan.dart';
import 'add_darshan.dart';
import 'edit_darshan.dart';

class DarshanMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(DarshanController());

    return Scaffold(
      backgroundColor: AppColors.hinduL1,

      appBar: AppBar(
        backgroundColor: AppColors.hinduBase,
        title: Text("Darshan",
            style: TextStyle(fontSize: 20, color: Colors.white)),
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

      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.hinduBase,
      //   child: Icon(Icons.add, color: Colors.white),
      //   onPressed: () => Get.to(() => AddDarshanPage()),
      // ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
              child: CircularProgressIndicator(color: AppColors.hinduBase));
        }

        if (controller.darshans.isEmpty) {
          return Center(
              child: Text("No Darshan Available",
                  style: TextStyle(fontSize: 16)));
        }

        return RefreshIndicator(
          onRefresh: controller.fetchDarshans,
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: controller.darshans.length,
            itemBuilder: (context, index) {
              final darshan = controller.darshans[index];

              return DarshanCard(
                darshan: darshan,
                onTap: () => Get.to(() =>
                    DarshanDetailPage(darshan: darshan)),
              );
            },
          ),
        );
      }),
    );
  }
}
