import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmLeaveDialog extends StatelessWidget {
  const ConfirmLeaveDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text("Leave This Page?", textAlign: TextAlign.center),
      content: const Text("You've entered some information. If you go back, the details won't be saved.", textAlign: TextAlign.center),
      actions: [
        TextButton(onPressed: () => Get.back(result: false), child: const Text("Discard", style: TextStyle(color: Colors.grey))),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF7722), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
          onPressed: () => Get.back(result: true),
          child: const Text("Keep Editing", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}