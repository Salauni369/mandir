//
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'app_colors.dart';
//
// Future<bool?> Function({
// required String cancelText,
// required String confirmText,
// required String content,
// required bool isDanger,
// required String title
// })
//  {
//   return Get.dialog<bool>(
//     AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//       content: Text(content),
//       actions: [
//         TextButton(
//           onPressed: () => Get.back(result: false),
//           child: Text(cancelText, style: TextStyle(color: Colors.grey[700])),
//         ),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(backgroundColor: isDanger ? AppColors.red : AppColors.hinduBase),
//           onPressed: () => Get.back(result: true),
//           child: Text(confirmText, style: TextStyle(color: Colors.white)),
//         ),
//       ],
//     ),
//     barrierDismissible: false,
//   );
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_colors.dart';

Future<bool?> showConfirmDialog({
  required String title,
  required String content,
  required String confirmText,
  required String cancelText,
  bool isDanger = false,
}) {
  return Get.dialog<bool>(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: Text(cancelText, style: TextStyle(color: Colors.grey[700])),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
            isDanger ? AppColors.red : AppColors.hinduBase,
          ),
          onPressed: () => Get.back(result: true),
          child: Text(
            confirmText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
