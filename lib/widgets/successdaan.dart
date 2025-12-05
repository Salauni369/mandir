import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showSuccessDialog({required String title, required String subtitle}) {
  return Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
            child: Icon(Icons.check, color: Colors.white, size: 44),
          ),
          SizedBox(height: 18),
          Text(title, style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 8),
          Text(subtitle, textAlign: TextAlign.center),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              child: Text('Continue'),
            ),
          ),
        ]),
      ),
    ),
    barrierDismissible: false,
  );
}
