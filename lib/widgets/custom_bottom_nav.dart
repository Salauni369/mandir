// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/BottomNavController.dart';
// import '../screens/dashboard/dashboard_page.dart';
// import '../screens/dashboard/donation/add_donation_page.dart';
// import '../screens/dashboard/donation/daanmain.dart';
// import '../screens/dashboard/live_darshan/Livedarshan.dart';
// import '../screens/dashboard/manage.dart';
// import 'package:get_storage/get_storage.dart';
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
// class _MyHomePageState extends State<MyHomePage> {
//   final bottomNav = Get.put(BottomNavController());
//   final box = GetStorage();
//   static final List<Widget> _widgetOptions = [
//     DashboardPage(),
//     ManageMainPage(),
//     DarshanMainPage(),
//     DaanMainPage(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final religion = box.read("religion") ?? "No religion saved";
//     return Scaffold(
//       body: Obx(() => Center(
//         child: _widgetOptions.elementAt(bottomNav.selectedIndex.value),
//       )),
//
//       bottomNavigationBar: Obx(() => BottomNavigationBar(
//         items:religion=='Sikhism'?
//
//
//         const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
//           BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Manage'),
//           BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'Darshan'),
//           BottomNavigationBarItem(icon: Icon(Icons.clean_hands), label: 'Daan'),
//         ]: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
//           BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Manage'),
//           BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'Darshan'),
//           BottomNavigationBarItem(icon: Icon(Icons.clean_hands), label: 'Daan'),
//         ],
//         currentIndex: bottomNav.selectedIndex.value,
//         selectedItemColor: Colors.amber[800],
//         unselectedItemColor: Colors.grey,
//         onTap: (i) => bottomNav.changeTab(i),
//       )),
//     );
//   }
// }
//
// // class _MyHomePageState extends State<MyHomePage> {
// //   final bottomNav = Get.put(BottomNavController());
// //   int _selectedIndex = 0;
// //   static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
// //   static final List<Widget> _widgetOptions = <Widget>[
// //      DashboardPage(),
// //     const ManageMainPage(),
// //     DarshanMainPage(),
// //     DaanMainPage(),
// //   ];
// //
// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final hindu="madir";
// //     Get.put(AddDaanController());
// //     Get.put(AddDaanController());
// //     return Scaffold(
// //
// //       body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
// //       bottomNavigationBar: BottomNavigationBar(
// //         items: const <BottomNavigationBarItem>[
// //           BottomNavigationBarItem(icon: Icon(Icons.home), label:'Dashboard'),
// //           BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Manage'),
// //           BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'Darshan'),
// //           BottomNavigationBarItem(icon: Icon(Icons.clean_hands_rounded), label: 'Daan'),
// //         ],
// //         currentIndex: _selectedIndex,
// //         selectedItemColor: Colors.amber[800],
// //         unselectedItemColor: Colors.grey,
// //         onTap: _onItemTapped,
// //       ),
// //     );
// //   }
// //}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/BottomNavController.dart';
import '../screens/dashboard/dashboard_page.dart';
import '../screens/dashboard/donation/add_donation_page.dart';
import '../screens/dashboard/donation/daanmain.dart';
import '../screens/dashboard/live_darshan/Livedarshan.dart';
import '../screens/dashboard/manage.dart';
import 'package:get_storage/get_storage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bottomNav = Get.put(BottomNavController());
  final box = GetStorage();

  static final List<Widget> _widgetOptions = [
    DashboardPage(),
    ManageMainPage(),
    DarshanMainPage(),
    DaanMainPage(),
  ];

  // 🔥 BACK BUTTON HANDLER (ONLY ADDITION)
  Future<bool> _onWillPop() async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Exit App"),
        content: const Text("Are you sure you want to exit the app?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text("Yes"),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final religion = box.read("religion") ?? "No religion saved";

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Obx(
              () => Center(
            child: _widgetOptions.elementAt(
              bottomNav.selectedIndex.value,
            ),
          ),
        ),
        bottomNavigationBar: Obx(
              () => BottomNavigationBar(
            items: religion == 'Sikhism'
                ? const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Dashboard'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.note), label: 'Manage'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.live_tv), label: 'Darshan'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.clean_hands), label: 'Daan'),
            ]
                : const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Dashboard'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.note), label: 'Manage'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.live_tv), label: 'Darshan'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.clean_hands), label: 'Daan'),
            ],
            currentIndex: bottomNav.selectedIndex.value,
            selectedItemColor: Colors.amber[800],
            unselectedItemColor: Colors.grey,
            onTap: (i) => bottomNav.changeTab(i),
          ),
        ),
      ),
    );
  }
}
