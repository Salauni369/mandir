import 'package:flutter/material.dart';
import 'package:untitled/screens/dashboard/privacypolicy.dart';
import 'package:untitled/screens/dashboard/term&condition.dart';

import 'contactsupport.dart';
import 'helpcenter.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF7A00),
        title: Text("Menu", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Help & Support",
                style: TextStyle(fontWeight: FontWeight.bold)),

            ListTile(
              title: Text("Help Center / FAQs"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HelpCenterPage()),
                );
              },
            ),


            ListTile(
              title: Text("Contact Support"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ContactSupportPage()),
                );
              },
            ),


            SizedBox(height: 10),

            Text("App Information",
                style: TextStyle(fontWeight: FontWeight.bold)),

            ListTile(
              title: Text("Terms & Conditions"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TermsConditionsPage()),
                );
              },
            ),


            ListTile(
              title: Text("Privacy & Policy "),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Privacypolicy()),
                );
              },
            ),
            ListTile(
              title: Text("App Version"),
              trailing: Text("1.0"),
            ),

            Spacer(),

            ListTile(
              title: Text("Sign Out",
                  style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
