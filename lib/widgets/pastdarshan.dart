import 'package:flutter/material.dart';

import '../models/live_darshan_model.dart';

class PastDarshanCard extends StatelessWidget {
  final DarshanModel darshan;
  final VoidCallback? onTap;

  const PastDarshanCard({
    super.key,
    required this.darshan,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                darshan.mobile_image ??
                   // darshan.webImage ??
                    "https://picsum.photos/200",
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 12),

            // TITLE + TAG
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    darshan.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),

                  SizedBox(height: 8),

                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE7D6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Ended on ${formatDate(darshan.createdAt)}",
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return "${date.day} ${_month(date.month)}, ${date.year}";
  }

  String _month(int m) {
    const months = [
      "Jan","Feb","Mar","Apr","May","Jun",
      "Jul","Aug","Sep","Oct","Nov","Dec"
    ];
    return months[m - 1];
  }
}
