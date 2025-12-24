// lib/widgets/confordaan.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool?> showConfirmDiscard({
  required String title,
  required String content,
  String confirmText = "Discard",
  String cancelText = "Keep Editing",
  bool isDanger = false, // ← YE ADD KAR DIYA!
}) {
  return Get.dialog<bool>(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isDanger ? Colors.red : Colors.black,
        ),
      ),
      content: Text(content),
      actions: [
        // CANCEL BUTTON
        TextButton(
          onPressed: () => Get.back(result: false),
          child: Text(
            cancelText,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),

        // CONFIRM BUTTON
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isDanger ? Colors.red : const Color(0xFFFF7A00),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: () => Get.back(result: true),
          child: Text(
            confirmText,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}