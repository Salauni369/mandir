import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zamboree_devotion/screens/authentication/login.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [

          // =================== TOP IMAGE =====================
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            width: double.infinity,
            child: Image.asset(
              "assets/images/Onboarding_Image.png",
              fit: BoxFit.cover,
            ),
          ),

          // =================== BOTTOM SECTION =====================
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    // ---------- TITLE ----------
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        children: [
                          const TextSpan(text: "Manage Your "),
                          TextSpan(
                            text: "Religious \n Place ",
                            style: TextStyle(color: Colors.blue.shade300),
                          ),
                          const TextSpan(text: " With Ease"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ---------- SUBTITLE ----------
                    const Text(
                      "Update timings, share announcements, go live, and stay connected with your devotees — all from one simple, secure app.",
                      style: TextStyle(color: Colors.white70, height: 1.5),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 35),

                    // ---------- SIGNIN BUTTON ----------
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        // onPressed: () => Get.toNamed('/SignIn'),
                        onPressed: () => Get.to(() => LoginPage()),

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 10,
                        ),
                        child: const Text(
                          "Sign in to the Account",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ---------- BOTTOM TEXT ----------
                    const Text(
                      "Don't have an account? Please contact our Zamboree agent.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
