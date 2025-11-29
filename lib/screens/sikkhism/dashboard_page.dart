import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import '../../myRoutes/mypagesname.dart';
import '../../widgets/custom_bottom_nav.dart';
class TempleDashboardPage extends StatelessWidget {

  const TempleDashboardPage({super.key, required this.controller,});
  final MotionTabBarController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A68FE),
        elevation: 0,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
        ),
        title: const Text(
          "Dashboard",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),



      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _statCard(title: "Visitors", percent: "+12%", value: "550k", color: Colors.green)),
                  const SizedBox(width: 12),
                  Expanded(child: _statCard(title: "Donations", percent: "-2%", value: "2.4k", color: Colors.red)),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Live Darshan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("View All →", style: TextStyle(color: Colors.black)),
                ],
              ),
              const SizedBox(height: 16),

              SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _liveCard("Live"),
                      const SizedBox(width: 12),
                      _liveCard(""),
                      const SizedBox(width: 12),
                      _liveCard(""),
                      const SizedBox(width: 12),
                      _liveCard(""),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(children: const [Icon(Icons.edit, size: 16), SizedBox(width: 4), Text("Edit")]),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      image: const DecorationImage(image: AssetImage("assets/images/temp.png"), fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "ISKCON Temple Vrindavan\nRaman Reeti, Vrindavan, Uttar Pradesh 281121",
                      style: TextStyle(fontSize: 13, height: 1.3),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFFFF1E9), borderRadius: BorderRadius.circular(1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Timings",style: TextStyle(color: Colors.black,fontSize: 16 , fontWeight: FontWeight.bold ,),),
                    SizedBox(height: 10,),
                    _timingRow("Morning Darshan", "4:30 AM – 1:00 PM",),
                    const SizedBox(height: 12),
                    _timingRow("Evening Darshan", "4:00 PM – 9:00 PM"),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text("About", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text("ISKCON Vrindavan, also called Sri Krishna Balaram Mandir, is one of the major ISKCON temples in the world. It is a Gaudiya Vaishnava temple located in Vrindavan, Mathura district. The temple is dedicated to Krishna and Balarama.",
                  style: TextStyle(fontSize: 12, height: 1.5,color: Colors.grey)),

              const SizedBox(height: 20),
              const Text("Other Information", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text("The temple attracts millions of devotees annually and is known for its vibrant festivals and spiritual programs.",
                  style: TextStyle(fontSize: 13, height: 1.5,color: Colors.grey)),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // YE SAB AB PRIVATE METHODS HAIN (_ laga diya)
  static Widget _statCard({required String title, required String value, required String percent, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10)]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Text(percent, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
        ]),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("This Month", style: TextStyle(fontSize: 13, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ]),
      ]),
    );
  }

  static Widget _liveCard(String tag) {
    return Container(
      width: 180,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(children: [
          ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), child: Image.asset("assets/images/krishna.png", height: 120, width: double.infinity, fit: BoxFit.cover)),
          if (tag == "Live")
            Positioned(right: 10, top: 10, child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)), child: const Text("Live", style: TextStyle(color: Colors.white, fontSize: 12)))),
        ]),
        const Padding(padding: EdgeInsets.all(10), child: Text("ISKCON Krishna Janmashtami Celebration Live Darshan from Vrindavan", maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(height: 1.3))),
      ]),
    );
  }

  static Widget _timingRow(String label, String time) {

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500,color: Colors.grey)),
      Text(time, style: const TextStyle(fontSize: 13,color: Colors.grey)),
    ]);
  }
}