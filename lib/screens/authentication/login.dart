// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../myRoutes/mypagesname.dart';
// import 'login_controller.dart';
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController phoneCtrl = TextEditingController();
//   List<TextEditingController> otpControllers =
//   List.generate(6, (index) => TextEditingController());
//
//   final auth = Get.put(AuthController());
//
//   bool showOtp = false; // Default false
//   bool loading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           Positioned.fill(child: Container(color: Colors.black)),
//
//           Positioned(
//             top: screenHeight * 0.10,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Image.asset("assets/images/Zemboree_Logo.png", height: 60),
//             ),
//           ),
//
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: double.infinity,
//               height: screenHeight * 0.70,
//               padding: const EdgeInsets.fromLTRB(32, 50, 32, 30),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(40),
//                   topRight: Radius.circular(40),
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text("Welcome",
//                         style: TextStyle(
//                             fontSize: 30, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 8),
//                     const Text(
//                       "Enter number & OTP to access your account.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.grey, fontSize: 15),
//                     ),
//                     const SizedBox(height: 20),
//
//                     // PHONE INPUT
//                     const Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text("Phone Number",
//                             style: TextStyle(fontWeight: FontWeight.w600))),
//                     const SizedBox(height: 10),
//
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 14, vertical: 5),
//                       decoration: BoxDecoration(
//                           color: Colors.grey.shade100,
//                           borderRadius: BorderRadius.circular(12)),
//                       child: Row(
//                         children: [
//                           const Text("+91",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 18)),
//                           Container(
//                               height: 30,
//                               width: 1.5,
//                               margin:
//                               const EdgeInsets.symmetric(horizontal: 12),
//                               color: Colors.grey),
//                           Expanded(
//                             child: TextField(
//                               controller: phoneCtrl,
//                               keyboardType: TextInputType.phone,
//                               enabled: !showOtp, // OTP aane ke baad lock
//                               decoration: const InputDecoration(
//                                   hintText: "Enter phone number",
//                                   border: InputBorder.none),
//                               style: const TextStyle(fontSize: 16),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 30),
//
//                     // OTP FIELDS
//                     if (showOtp) ...[
//                       const Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text("Enter OTP",
//                               style: TextStyle(fontWeight: FontWeight.w600))),
//                       const SizedBox(height: 10),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: List.generate(6, (i) {
//                           return SizedBox(
//                             width: 45,
//                             height: 50,
//                             child: TextField(
//                               controller: otpControllers[i],
//                               maxLength: 1,
//                               textAlign: TextAlign.center,
//                               keyboardType: TextInputType.number,
//                               decoration: const InputDecoration(
//                                 counterText: "",
//                                 border: OutlineInputBorder(),
//                               ),
//                               onChanged: (val) {
//                                 if (val.isNotEmpty && i < 5) {
//                                   FocusScope.of(context).nextFocus();
//                                 } else if (val.isEmpty && i > 0) {
//                                   FocusScope.of(context).previousFocus();
//                                 }
//                               },
//                             ),
//                           );
//                         }),
//                       ),
//                       const SizedBox(height: 40),
//                     ],
//
//                     // MAIN BUTTON
//                     SizedBox(
//                       width: double.infinity,
//                       height: 56,
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           if (!showOtp) {
//                             // Step 1: Validate number
//                             if (phoneCtrl.text.length != 10) {
//                               Get.snackbar("Error", "Enter valid 10–digit mobile number",
//                                   backgroundColor: Colors.red,
//                                   colorText: Colors.white);
//                               return;
//                             }
//
//                             // Step 2: API CALL
//                             await auth.sendOtp(phoneCtrl.text);
//
//                             // Step 3: Show OTP boxes
//                             setState(() => showOtp = true);
//                           } else {
//                             // Step 4: Verify OTP
//                             final otpValue =
//                             otpControllers.map((c) => c.text).join();
//
//                             if (otpValue.length != 6) {
//                               Get.snackbar("Error", "Enter 6-digit OTP",
//                                   backgroundColor: Colors.red,
//                                   colorText: Colors.white);
//                               return;
//                             }
//
//                             await auth.verifyOtp(phoneCtrl.text, otpValue);
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.black,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20))),
//                         child: Text(
//                           showOtp ? "Sign In" : "Get OTP",
//                           style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white),
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../myRoutes/mypagesname.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneCtrl = TextEditingController();
  List<TextEditingController> otpControllers =
  List.generate(6, (index) => TextEditingController());

  final auth = Get.put(AuthController());

  bool showOtp = false; // Default false

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.black)),

          Positioned(
            top: screenHeight * 0.10,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset("assets/images/Zemboree_Logo.png", height: 60),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.70,
              padding: const EdgeInsets.fromLTRB(32, 50, 32, 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome",
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Enter number & OTP to access your account.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const SizedBox(height: 20),

                    // PHONE INPUT
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Phone Number",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            "+91",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Container(
                            height: 30,
                            width: 1.5,
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: TextField(
                              controller: phoneCtrl,
                              keyboardType: TextInputType.phone,
                              enabled: !showOtp, // OTP visible hone ke baad lock
                              decoration: const InputDecoration(
                                hintText: "Enter phone number",
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // OTP FIELDS
                    if (showOtp) ...[
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter OTP",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (i) {
                          return SizedBox(
                            width: 45,
                            height: 50,
                            child: TextField(
                              controller: otpControllers[i],
                              maxLength: 1,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                counterText: "",
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (val) {
                                if (val.isNotEmpty && i < 5) {
                                  FocusScope.of(context).nextFocus();
                                } else if (val.isEmpty && i > 0) {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 40),
                    ],

                    // MAIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Step 1: Get OTP
                          if (!showOtp) {
                            if (phoneCtrl.text.length != 10) {
                              Get.snackbar("Error",
                                  "Enter valid 10–digit mobile number",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                              return;
                            }

                            await auth.sendOtp(phoneCtrl.text);

                            setState(() {
                              showOtp = true; // OTP boxes ON
                            });
                          }

                          // Step 2: Verify OTP
                          else {
                            final otpValue =
                            otpControllers.map((c) => c.text).join();

                            if (otpValue.length != 6) {
                              Get.snackbar("Error", "Enter 6-digit OTP",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                              return;
                            }

                            await auth.verifyOtp(phoneCtrl.text, otpValue);

                            // 🔥 Move to Dashboard after successful verification

                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          showOtp ? "Sign In" : "Get OTP",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
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
