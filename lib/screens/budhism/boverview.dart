import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/manage_controller.dart';

class BOverviewTab extends StatelessWidget {
  const BOverviewTab({super.key});

  @override
  Widget build(BuildContext context) {

    final ManageController controller = Get.find<ManageController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/temp.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      Get.snackbar("Upload", "your Temple has changed", backgroundColor: Colors.blue);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text("Name *", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: controller.nameCtrl,
            style: TextStyle(fontSize: 12,color: Colors.black),
            decoration: InputDecoration(
              hintText: "ISKCON Temple Vrindavan/Hr",
              hintStyle: TextStyle(fontSize: 12,color: Colors.green),
              filled: true,
              fillColor: Color(0xFFF4F4F4),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
          const SizedBox(height: 20),
          const Text("About us *", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: controller.aboutCtrl,
            style: TextStyle(fontSize: 12,color: Colors.black),
            maxLines: 6,
            decoration: InputDecoration(
              hintText: "Write about your temple...",
              hintStyle: TextStyle(fontSize: 12,color: Colors.black),
              filled: true,
              fillColor: Color(0xFFF4F4F4),



              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Contact Number *", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: controller.contactCtrl,
            style: TextStyle(fontSize: 12,color: Colors.black),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "+91 9853228287",
              hintStyle: TextStyle(fontSize: 12,color: Colors.black),
              filled: true,
              fillColor: Color(0xFFEBEBEA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
          const SizedBox(height: 30),
          const Text("Additional Sections", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          _sectionTile("Title *", "****",),
          const SizedBox(height: 12),
          _sectionTile("Content *", "****"),
          const SizedBox(height: 12),

          Center(
            child: TextButton.icon(
              onPressed: () {
                Get.snackbar("Added", "New section added ", backgroundColor: Colors.green);
              },
              icon: const Icon(Icons.add_circle_outline, color: Color(0xFFFF7722)),
              label: const Text(
                "Add More Additional Sections",
                style: TextStyle(color: Color(0xFFFF7722), fontSize: 15),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _sectionTile(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Color(0xFFF4F4F4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}