import 'package:flutter/material.dart';

class SocialMediaTab extends StatefulWidget {
  const SocialMediaTab({super.key});

  @override
  State<SocialMediaTab> createState() => _SocialMediaLinksTabState();
}

class _SocialMediaLinksTabState extends State<SocialMediaTab> {
  final youtubeCtrl = TextEditingController();
  final facebookCtrl = TextEditingController();
  final instagramCtrl = TextEditingController();
  final linkedinCtrl = TextEditingController();

  @override
  void dispose() {
    youtubeCtrl.dispose();
    facebookCtrl.dispose();
    instagramCtrl.dispose();
    linkedinCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSocialField(
              label: "Youtube",
              prefix: "youtube.com/",
              controller: youtubeCtrl,
              hint: "@ISKCONVrndavan",
            ),
            const SizedBox(height: 20),
            _buildSocialField(
              label: "Facebook",
              prefix: "facebook.com/",
              controller: facebookCtrl,
              hint: "iskconvrindavann",
            ),
            const SizedBox(height: 20),
            _buildSocialField(
              label: "Instagram",
              prefix: "Instagram.com/",
              controller: instagramCtrl,
              hint: "iskcon_vrindavana",
            ),
            const SizedBox(height: 20),
            _buildSocialField(
              label: "Linkedin",
              prefix: "Linkedin.com/in/",
              controller: linkedinCtrl,
              hint: "N/A",
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialField({
    required String label,
    required String prefix,
    required TextEditingController controller,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade400, width: 1),
          ),
          child: Row(
            children: [
              // Prefix container
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
                child: Text(
                  prefix,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              // Text field
              Expanded(
                child: TextField(
                  controller: controller,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}