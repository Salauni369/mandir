import 'package:flutter/material.dart';

class ContactSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF7A00),
        title: Text("Contact Support", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            // IMAGE
            Image.asset(
              "assets/images/contact.png",
              height: 180,
            ),

            SizedBox(height: 15),

            Text(
              "OUR CUSTOMER SUPPORT TEAM IS READY TO\nMAKE SURE YOU HAVE THE BEST SERVICE.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 20),

            Divider(),

            SizedBox(height: 10),

            // SEND EMAIL + CALL US ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.email_outlined, size: 36, color: Colors.orange),
                    SizedBox(height: 6),
                    Text("Send Email",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  ],
                ),

                Column(
                  children: [
                    Icon(Icons.call_outlined, size: 36, color: Colors.orange),
                    SizedBox(height: 6),
                    Text("Call Us",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),

            Divider(),

            SizedBox(height: 15),

            // GIVE FEEDBACK
            Text(
              "GIVE APP FEEDBACK",
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Help us improve",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 8),

            Text(
              "Report a bug or suggest ways to make the app better.",
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),

            SizedBox(height: 20),

            // FEEDBACK BUTTON
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Give Feedback", style: TextStyle(fontSize: 14)),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
