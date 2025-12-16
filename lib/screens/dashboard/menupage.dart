// import 'package:flutter/material.dart';
// import 'package:zamboree_devotion/screens/dashboard/privacypolicy.dart';
// import 'package:zamboree_devotion/screens/dashboard/term&condition.dart';
//
// import 'contactsupport.dart';
// import 'helpcenter.dart';
//
// class MenuPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFFFF7A00),
//         title: Text("Menu", style: TextStyle(color: Colors.white)),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//
//       body: Padding(
//         padding: EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             Text("Help & Support",
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//
//             ListTile(
//               title: Text("Help Center / FAQs",style: TextStyle(fontSize: 12),),
//               trailing: Icon(Icons.chevron_right),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => HelpCenterPage()),
//                 );
//               },
//             ),
//
//
//             ListTile(
//               title: Text("Contact Support",style: TextStyle(fontSize: 12),),
//               trailing: Icon(Icons.chevron_right),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => ContactSupportPage()),
//                 );
//               },
//             ),
//
//
//             SizedBox(height: 10),
//
//             Text("App Information",
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//
//             ListTile(
//               title: Text("Terms & Conditions",style: TextStyle(fontSize: 12),),
//               trailing: Icon(Icons.chevron_right),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => TermsConditionsPage()),
//                 );
//               },
//             ),
//
//
//             ListTile(
//               title: Text("Privacy & Policy ",style: TextStyle(fontSize: 12),),
//               trailing: Icon(Icons.chevron_right),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => Privacypolicy()),
//                 );
//               },
//             ),
//             ListTile(
//               title: Text("App Version"),
//               trailing: Text("1.0"),
//             ),
//
//             Spacer(),
//
//             ListTile(
//               title: Text("Sign Out",
//                   style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:zamboree_devotion/screens/dashboard/privacypolicy.dart';
import 'package:zamboree_devotion/screens/dashboard/term&condition.dart';

import 'contactsupport.dart';
import 'helpcenter.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF7A00),
        title: Text(
          "Menu",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------------- HELP & SUPPORT ----------------
            Text(
              "Help & Support",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(height: 6),   // VERY SMALL GAP

            _menuTile(
              title: "Help Center / FAQs",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HelpCenterPage()),
                );
              },
            ),

            _menuTile(
              title: "Contact Support",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ContactSupportPage()),
                );
              },
            ),

            SizedBox(height: 8),   // SMALL GAP BEFORE NEXT SECTION

            // ---------------- APP INFORMATION ----------------
            Text(
              "App Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(height: 6),

            _menuTile(
              title: "Terms & Conditions",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TermsConditionsPage()),
                );
              },
            ),

            _menuTile(
              title: "Privacy & Policy",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Privacypolicy()),
                );
              },
            ),

            _menuTile(
              title: "App Version",
              trailing: Text("1.0", style: TextStyle(fontSize: 12)),
            ),

            Spacer(),

            _menuTile(
              title: "Sign Out",
              titleColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  // ------------------- REUSABLE TILE -------------------
  Widget _menuTile({
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
    Color titleColor = Colors.black,
  }) {
    return ListTile(
      dense: true, // reduces vertical height
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      minVerticalPadding: 0,
      visualDensity: VisualDensity(vertical: -2), // tighter spacing

      title: Text(
        title,
        style: TextStyle(fontSize: 12, color: titleColor),
      ),

      trailing: trailing ??
          Icon(Icons.chevron_right, size: 18, color: Colors.black54),

      onTap: onTap,
    );
  }
}
