import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import '../screens/dashboard/dashboard_page.dart';
import '../screens/dashboard/donation/add_donation_page.dart';
import '../screens/dashboard/manage.dart';
//
// class CustomBottomNav extends StatefulWidget {
//   const CustomBottomNav({super.key});
//
//   @override
//   State<CustomBottomNav> createState() => _CustomBottomNavState();
// }
//
// class _CustomBottomNavState extends State<CustomBottomNav> {
//   int selectedIndex = 0;
//
//   final List<Widget> pages = const [
//     DashboardPage(),
//     Center(child: Text("Manage Page")),
//     Center(child: Text("Darshan Page")),
//     Center(child: Text("Daan Page")),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[selectedIndex],
//       bottomNavigationBar: _bottomNavBar(),
//     );
//   }
//
//   Widget _bottomNavBar() {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: const BoxDecoration(
//         color: Color(0xFFFF7722),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(26),
//           topRight: Radius.circular(26),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           navItem("assets/icons/dashboard.svg", "Dashboard", 0),
//           navItem("assets/icons/manage.svg", "Manage", 1),
//           navItem("assets/icons/darshan.svg", "Darshan", 2),
//           navItem("assets/icons/daan.svg", "Daan", 3),
//         ],
//       ),
//     );
//   }
//
//   Widget navItem(String icon, String label, int index) {
//     bool isSelected = index == selectedIndex;
//
//     return GestureDetector(
//       onTap: () {
//         setState(() => selectedIndex = index);
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 220),
//         padding: const EdgeInsets.symmetric(
//           vertical: 8,
//           horizontal: 18,
//         ),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.white : Colors.transparent,
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Row(
//           children: [
//             SvgPicture.asset(
//               icon,
//               height: 22,
//               width: 22,
//               colorFilter: ColorFilter.mode(
//                 isSelected ? const Color(0xFFFF7722) : Colors.white,
//                 BlendMode.srcIn,
//               ),
//             ),
//             const SizedBox(width: 6),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 11,
//                 fontWeight: FontWeight.w600,
//                 color: isSelected ? const Color(0xFFFF7722) : Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class MyHomePage extends StatefulWidget {
  final String? title;
  final int selectedTabIndex;

  const MyHomePage({
    Key? key,
    this.title,
    this.selectedTabIndex = 0, // Default to "Home"
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late MotionTabBarController _motionTabBarController;

  @override
  void initState() {
    super.initState();

    // If using Get.arguments to receive index from GetX navigation
    final int tabIndex = Get.arguments ?? widget.selectedTabIndex;

    _motionTabBarController = MotionTabBarController(
      initialIndex: tabIndex,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _motionTabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: _getTabLabel(_motionTabBarController.index),
        useSafeArea: true,
        labels: const ["Home", "Events", "Withdraw Requests", "Profile"],
        icons: const [
          Icons.home,
          Icons.event,
          Icons.currency_rupee_sharp,
          Icons.person_2
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.blue,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.blueAccent,
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(() {
            _motionTabBarController.index = value;
          });
        },
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _motionTabBarController,
        children: <Widget>[
          DashboardPage(controller: _motionTabBarController),
          ManageMainPage(controller: _motionTabBarController),
          AddDaanPage(controller: _motionTabBarController),
          DashboardPage(controller: _motionTabBarController),
        ],
      ),
    );
  }

  /// Returns tab label by index for initialSelectedTab
  String _getTabLabel(int index) {
    const labels = ["Home", "Events", "Withdraw Requests", "Profile"];
    return labels[index];
  }
}