import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/myRoutes/mypagesname.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(MyPagesName.onboardingscreen);
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
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/Zemboree_Logo.png",

                  ),

                  const SizedBox(height: 5), // ← YOUR 5px GAP

                  const Text(
                    "Sacred Space Management",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
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
