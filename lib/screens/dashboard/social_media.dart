// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/manage_controller.dart';
//
// class SocialMediaTab extends StatelessWidget {
//   const SocialMediaTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final ManageController controller = Get.find();
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Obx(() => Column(
//         children: [
//           for (int i = 0; i < controller.socialList.length; i++)
//             Column(children: [
//               _socialField(controller, i),
//               const SizedBox(height: 16),
//             ]),
//           const SizedBox(height: 50),
//         ],
//       )),
//     );
//   }
//
//   Widget _socialField(ManageController controller, int i) {
//     final item = controller.socialList[i];
//     final textCtrl = TextEditingController()..text = item.username;
//
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       Text(item.platform, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//       const SizedBox(height: 8),
//       Row(children: [
//         Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: const BorderRadius.only(topLeft: Radius.circular(2), bottomLeft: Radius.circular(2))), child: Text(item.prefix, style: const TextStyle(fontWeight: FontWeight.w500))),
//         Expanded(child: TextField(enabled: item.enabled, controller: textCtrl, decoration: InputDecoration(hintText: item.username, filled: true, fillColor: Colors.grey.shade100, border: OutlineInputBorder(borderRadius: const BorderRadius.only(topRight: Radius.circular(2), bottomRight: Radius.circular(2)), borderSide: BorderSide.none)))),
//         //const SizedBox(width: 8),
//         //ElevatedButton(onPressed: () => controller.updateSocialUsername(i, textCtrl.text.trim()), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF7722), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: const Text("Save")),
//       ]),
//     ]);
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/manage_controller.dart';

class SocialMediaTab extends StatelessWidget {
  const SocialMediaTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ManageController controller = Get.find();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Obx(() => Column(
        children: [
          for (int i = 0; i < controller.socialList.length; i++)
            Column(
              children: [
                _socialField(controller, i),
                const SizedBox(height: 16),
              ],
            ),
          const SizedBox(height: 50),
        ],
      )),
    );
  }

  Widget _socialField(ManageController controller, int i) {
    final item = controller.socialList[i];
    final textCtrl = TextEditingController()..text = item.username;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // PLATFORM NAME — untouched
        Text(
          item.platform,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            // LEFT PREFIX BOX (font size 12)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  bottomLeft: Radius.circular(2),
                ),
              ),
              child: Text(
                item.prefix,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,      // 👈 FONT SIZE ONLY CHANGE
                ),
              ),
            ),

            // TEXTFIELD (font size 12)
            Expanded(
              child: TextField(
                enabled: item.enabled,
                controller: textCtrl,
                style: const TextStyle(
                  fontSize: 12,       // 👈 MAIN INPUT FONT SIZE
                ),
                decoration: InputDecoration(
                  hintText: item.username,
                  hintStyle: const TextStyle(
                    fontSize: 12,     // 👈 HINT FONT SIZE
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(2),
                      bottomRight: Radius.circular(2),
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
