import 'package:flutter/material.dart';

class JDashboardPage extends StatelessWidget {
  const JDashboardPage({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // TOP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A68FE),
        elevation: 0,
        title: const Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: Icon(Icons.notifications, color: Colors.black),
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // -------------- STATS CARDS --------------
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    title: "Visitors",
                    value: "550k",
                    percent: "12%",
                    percentColor: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    title: "Live Attended",
                    value: "2.4k",
                    percent: "-2%",
                    percentColor: Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // ---------------- LIVE DARSHAN HEADER ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Live Darshan",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Text(
                  "View All →",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 210,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, __) => _liveDarshanCard(),
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemCount: 2,
              ),
            ),

            const SizedBox(height: 28),

            // ---------------- OVERVIEW ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Overview",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                Icon(Icons.edit, size: 18),
              ],
            ),

            const SizedBox(height: 14),
            _overviewCard(),

            const SizedBox(height: 28),

            // ---------------- TIMINGS ----------------
            const Text(
              "Timings",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            _timeRow("Kirtan Darbar", "04:30 AM - 12:45 PM"),
            const SizedBox(height: 10),
            _timeRow("Langar", "4:00 PM - 8:30 PM"),

            const SizedBox(height: 28),

            // ---------------- ABOUT ----------------
            const Text(
              "About",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            const Text(
              "Gurdwara Bangla Sahib is one of the most prominent Sikh gurdwaras, or Sikh house of worship, in Delhi, India, and known for its association with the eighth Sikh Guru, Guru Har Krishan, as well as the holy pond inside its complex, known as the Sarovar",
              style: TextStyle(fontSize: 14, height: 1.4),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------
  // ------------------- WIDGETS ------------------------
  // ----------------------------------------------------

  Widget _statCard({
    required String title,
    required String value,
    required String percent,
    required Color percentColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up, color: percentColor, size: 18),
              const SizedBox(width: 4),
              Text(
                percent,
                style: TextStyle(
                  color: percentColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _liveDarshanCard() {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(14)),
                child: Image.network(
                  "assets/images/krishna.png",
                  height: 130,
                  width: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "Live",
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: const Text(
              "Kirtan Darbar LIVE - Gurdwara Shri Bangla Sahib",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _overviewCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/images/temp.png",
              height: 80,
              width: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              "Hanuman Road Area, Connaught Place, New Delhi, Delhi 110001",
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
          )
        ],
      ),
    );
  }

  Widget _timeRow(String title, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 14)),
        Text(
          time,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
