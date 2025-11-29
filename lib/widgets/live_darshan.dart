// lib/widgets/live_darshan_card.dart
import 'package:flutter/material.dart';
import '../../models/live_darshan_model.dart';

class LiveDarshanCard extends StatelessWidget {
  final LiveDarshanModel darshan;
  const LiveDarshanCard({super.key, required this.darshan});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 8)]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(darshan.image, height: 120, width: double.infinity, fit: BoxFit.cover),
          ),
          if (darshan.isLive)
            Positioned(
              right: 10, top: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
                child: const Text("Live", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
        ]),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            darshan.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, height: 1.3),
          ),
        ),
      ]),
    );
  }
}