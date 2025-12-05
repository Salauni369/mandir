import 'package:flutter/material.dart';

class Privacypolicy extends StatelessWidget {
  const Privacypolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Color(0xFFFF7A00),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Terms & Conditions",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------------- MAIN HEADING ----------------
            Text(
              "Privacy & Policy",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: 16),

            // ---------------- BLOCK 1 -------------------
            _title("1. Be Carefull"),
            _para(),

            SizedBox(height: 16),

            // ---------------- BLOCK 2 -------------------
            _title("2. Be Positive"),
            _para(),

            SizedBox(height: 16),

            // ---------------- BLOCK 3 -------------------
            _title("3. Fell blessed if you are able to help them"),
            _para(),

            SizedBox(height: 32),

            // ---------------- WARRANTY POLICY ----------------
            Text(
              "Warranty Policy",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: 16),

            // ---------------- WARRANTY BLOCK 1 ----------------
            _title("1. This is the headline"),
            _para(),

            SizedBox(height: 16),

            // ---------------- WARRANTY BLOCK 2 ----------------
            _title("2. This is the headline"),
            _para(),

            SizedBox(height: 16),

            // ---------------- WARRANTY BLOCK 3 ----------------
            _title("3. This is the headline"),
            _para(),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ---------------- REUSABLE TITLE ----------------
  Widget _title(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // ---------------- PARAGRAPH (Figma style) ----------------
  Widget _para() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        "Be kind with everybody "
            "In lacus purus convallis aliquam egestas. Hendrerit ut adipiscing sit at nunc nec porta in sagittis. "
            "Malesuada facilisi dictum non ut. Donec feugiat quam et lobortis leo blandit nullam. "
            "Ornare egestas nunc viverra fermentum ac purus ornare. At auctor accumsan lectus ultrices massa rhoncus.",
        style: TextStyle(
          fontSize: 13,
          height: 1.45,
          color: Colors.black87,
        ),
      ),
    );
  }
}
