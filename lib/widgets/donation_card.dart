import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/donation_model.dart';

import '../screens/dashboard/donation/edit_donation_page.dart';

class DaanCard extends StatelessWidget {
  final DaanModel daan;
  const DaanCard({super.key, required this.daan});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 8, offset: const Offset(0, 4))
      ]),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(daan.imageUrl, height: 180, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(daan.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text("TAP TO EDIT", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF7722), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                    onPressed: () => Get.to(() => EditDaanPage(), arguments: daan),
                    child: Text(daan.buttonLabel, style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}