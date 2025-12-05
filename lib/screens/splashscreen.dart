// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:untitled/myRoutes/mypagesname.dart';
// import 'package:untitled/screens/dashboard/dashboard_page.dart';
// import 'package:untitled/widgets/custom_bottom_nav.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/dashboard/dashboard_page.dart';
import 'package:untitled/widgets/custom_bottom_nav.dart';

import '../onboarding2.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
       Get.offAll(()=> OnboardingScreen());
    //  // Get.offAll(() => LoginScreen());
    //
       // Get.offAll(()=> MyHomePage());
     });

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/Splash 3.png",
            fit: BoxFit.cover,
          ),

          // Container(
          //   color: Colors.black.withOpacity(0.4),
          // ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/Zemboree_Logo.png",
                    width: MediaQuery.of(context).size.width-50,
                  ),

                  const SizedBox(height: 5), // ← YOUR 5px GAP

                  Center(
                    child: const Text(
                      "Sacred Space Management",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
