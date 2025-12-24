import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpCenterPage extends StatelessWidget {
  final List<Map<String, dynamic>> faqs = [
    {
      "q": "This is the question",
      "a":
      "Lorem ipsum dolor sit amet consectetur. Commodo quam nunc nibh amet..."
    },
    {"q": "This is the question", "a": ""},
    {"q": "This is the question", "a": ""},
    {"q": "What is your favorite book?", "a": ""},
    {"q": "How do you define success?", "a": ""},
    {"q": "What inspires you the most?", "a": ""},
    {"q": "What is your biggest challenge?", "a": ""},
    {"q": "Who has influenced you the most?", "a": ""},
    {"q": "What are your long-term goals?", "a": ""},
    {"q": "How do you handle stress?", "a": ""},
    {"q": "What is your dream job?", "a": ""},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Color(0xFFFF7A00),
        title: Text("Help Center / FAQs", style: TextStyle(  color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),

      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: faqs.length,
        separatorBuilder: (_, __) => Divider(color: Colors.grey.shade300),
        itemBuilder: (context, index) {
          return ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text(
              "${index + 1}. ${faqs[index]['q']}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            children: [
              if (faqs[index]['a'] != "")
                Padding(
                  padding: EdgeInsets.only(bottom: 16, top: 8),
                  child: Text(
                    faqs[index]['a'],
                    style: TextStyle(color: Colors.grey[700], fontSize: 13),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
