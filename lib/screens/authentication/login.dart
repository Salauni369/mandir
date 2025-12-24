// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
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
//   final auth = Get.put(AuthController());
//
//   bool showOtp = false; // OTP boxes visibility
//
//   late List<FocusNode> otpNodes;
//   late List<TextEditingController> otpCtrls;
//
//   @override
//   void initState() {
//     super.initState();
//
//     otpCtrls = List.generate(6, (_) => TextEditingController());
//     otpNodes = List.generate(6, (_) => FocusNode());
//
//     // If user edits phone number → hide OTP
//     phoneCtrl.addListener(() {
//       if (showOtp && phoneCtrl.text.length < 10) {
//         setState(() => showOtp = false);
//         clearOtp();
//       }
//     });
//   }
//
//   void clearOtp() {
//     for (var c in otpCtrls) c.clear();
//   }
//
//   void handleOtpPaste(String pasted) {
//     if (pasted.length == 6) {
//       for (int i = 0; i < 6; i++) {
//         otpCtrls[i].text = pasted[i];
//       }
//       FocusScope.of(context).unfocus();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           Obx(() => auth.loading.value
//               ? const Center(child: CircularProgressIndicator(color: Colors.grey))
//               : const SizedBox()),
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
//           // White Bottom Sheet
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: double.infinity,
//               height: screenHeight * 0.70,
//               padding: const EdgeInsets.fromLTRB(32, 50, 32, 30),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40)),
//               ),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     const Text("Welcome",
//                         style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 8),
//                     const Text(
//                       "Enter number & OTP to access your account.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.grey, fontSize: 15),
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     // PHONE FIELD
//                     const Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text("Phone Number",
//                             style: TextStyle(fontWeight: FontWeight.w600))),
//                     const SizedBox(height: 10),
//
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
//                       decoration: BoxDecoration(
//                           color: Colors.grey.shade100,
//                           borderRadius: BorderRadius.circular(12)),
//                       child: Row(
//                         children: [
//                           const Text("+91",
//                               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                           Container(
//                               height: 30, width: 1.5,
//                               margin: const EdgeInsets.symmetric(horizontal: 12),
//                               color: Colors.grey),
//                           Expanded(
//                             child: TextField(
//                               controller: phoneCtrl,
//                               keyboardType: TextInputType.number,
//                               maxLength: 10,
//                               decoration: const InputDecoration(
//                                   counterText: "",
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
//                     // OTP SECTION (VISIBLE ONLY AFTER GET OTP)
//                     if (showOtp) ...[
//                       const Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text("Enter OTP",
//                             style: TextStyle(fontWeight: FontWeight.w600)),
//                       ),
//                       const SizedBox(height: 10),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: List.generate(6, (i) {
//                           return SizedBox(
//                             width: 45,
//                             height: 50,
//                             child: TextField(
//                               controller: otpCtrls[i],
//                               focusNode: otpNodes[i],
//                               maxLength: 1,
//                               textAlign: TextAlign.center,
//                               keyboardType: TextInputType.number,
//                               decoration: const InputDecoration(
//                                   counterText: "", border: OutlineInputBorder()),
//                               onChanged: (val) {
//                                 if (val.length > 1) {
//                                   handleOtpPaste(val); // paste support
//                                   return;
//                                 }
//
//                                 if (!RegExp(r"[0-9]").hasMatch(val)) {
//                                   otpCtrls[i].clear();
//                                   return;
//                                 }
//
//                                 if (val.isNotEmpty && i < 5) {
//                                   otpNodes[i + 1].requestFocus();
//                                 } else if (val.isEmpty && i > 0) {
//                                   otpNodes[i - 1].requestFocus();
//                                 }
//                               },
//                             ),
//                           );
//                         }),
//                       ),
//
//                       const SizedBox(height: 12),
//
//                       Obx(() {
//                         if (auth.resendSeconds.value > 0) {
//                           return Text("Resend OTP in ${auth.resendSeconds.value}s",
//                               style: const TextStyle(fontSize: 13, color: Colors.grey));
//                         } else {
//                           return GestureDetector(
//                             onTap: () async {
//                               await auth.sendOtp(phoneCtrl.text);
//                             },
//                             child: const Text("Resend OTP",
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold)),
//                           );
//                         }
//                       }),
//
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
//                             if (phoneCtrl.text.length != 10) {
//                               Get.snackbar("Error",
//                                   "Enter valid 10–digit mobile number",
//                                   backgroundColor: Colors.red,
//                                   colorText: Colors.white);
//                               return;
//                             }
//
//                             await auth.sendOtp(phoneCtrl.text);
//                             setState(() => showOtp = true); // SHOW OTP NOW
//                           } else {
//                             final otp = otpCtrls.map((c) => c.text).join();
//                             if (otp.length != 6) {
//                               Get.snackbar("Error", "Enter 6-digit OTP",
//                                   backgroundColor: Colors.red,
//                                   colorText: Colors.white);
//                               return;
//                             }
//
//                             await auth.verifyOtp(phoneCtrl.text, otp);
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.black,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20)),
//                         ),
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
//


import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:pinput/pinput.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneCtrl = TextEditingController();
  final auth = Get.find<AuthController>();

  bool showOtp = false;

  @override
  void initState() {
    super.initState();

    phoneCtrl.addListener(() {
      if (showOtp && phoneCtrl.text.length < 10) {
        setState(() => showOtp = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final pinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Loading
          Obx(() => auth.loading.value
              ? const Center(child: CircularProgressIndicator(color: Colors.white))
              : const SizedBox()),

          // Logo
          Positioned(
            top: screenHeight * 0.10,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset("assets/images/Zemboree_Logo.png", height: 60),
            ),
          ),

          // White Bottom Sheet (same as original)
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
                  children: [
                    const Text("Welcome",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text(
                      "Enter number & OTP to access your account.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),

                    const SizedBox(height: 20),

                    // PHONE FIELD (same)
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Phone Number",
                            style: TextStyle(fontWeight: FontWeight.w600))),
                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          const Text("+91",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          Container(
                              height: 30, width: 1.5,
                              margin: const EdgeInsets.symmetric(horizontal: 12),
                              color: Colors.grey),
                          Expanded(
                            child: TextField(
                              controller: phoneCtrl,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              decoration: const InputDecoration(
                                  counterText: "",
                                  hintText: "Enter phone number",
                                  border: InputBorder.none),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // OTP FIELD (pinput se – auto-fill support + better look)
                    if (showOtp) ...[
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Enter OTP",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 16),

                      // Pinput(
                      //   length: 6,
                      //   androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
                      //   listenForMultipleSmsOnAndroid: true,
                      //   defaultPinTheme: pinTheme,
                      //   focusedPinTheme: pinTheme.copyWith(
                      //     decoration: pinTheme.decoration!.copyWith(
                      //       border: Border.all(color: Colors.black, width: 2),
                      //     ),
                      //   ),
                      //   onCompleted: (pin) async {
                      //     await auth.verifyOtp(phoneCtrl.text.trim(), pin);
                      //   },
                      // ),
                      Pinput(
                        length: 6,
                        defaultPinTheme: pinTheme,
                        onCompleted: (pin) {
                          auth.verifyOtp(phoneCtrl.text.trim(), pin);
                        },
                      ),




                      const SizedBox(height: 16),

                      // Resend OTP – timer sirf resend pe start
                      Obx(() {
                        if (auth.resendSeconds.value > 0) {
                          return Text("Resend OTP in ${auth.resendSeconds.value}s",
                              style: const TextStyle(fontSize: 13, color: Colors.grey));
                        } else {
                          return GestureDetector(
                            onTap: () async {
                              await auth.sendOtp(phoneCtrl.text.trim());
                              auth.startResendTimer(); // ← SIRF YAHAN START
                            },
                            child: const Text("Resend OTP",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          );
                        }
                      }),

                      const SizedBox(height: 40),
                    ],

                    // MAIN BUTTON (same)
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: auth.loading.value ? null : () async {
                          final phone = phoneCtrl.text.trim();
                          if (phone.length != 10) {
                            Get.snackbar("Error", "Enter valid 10-digit number",
                                backgroundColor: Colors.red, colorText: Colors.white);
                            return;
                          }

                          if (!showOtp) {
                            await auth.sendOtp(phone);
                            if (!auth.loading.value) {
                              setState(() => showOtp = true);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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