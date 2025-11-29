// lib/widgets/overview_card.dart
import 'package:flutter/material.dart';
import '../../models/dashboard_model.dart';
import '../models/sikkh_dash_model.dart';

class OverviewCard extends StatelessWidget {
  final TempleInfo info;
  const OverviewCard({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Overview", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(info.image, height: 180, width: double.infinity, fit: BoxFit.cover),
          ),
          const SizedBox(height: 16),
          Text(info.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(info.address, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 16),
          const Text("Timings", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(info.timings.replaceAll("\\n", "\n"), style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 16),
          const Text("About", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(info.about, style: const TextStyle(fontSize: 14, height: 1.5)),
        ],
      ),
    );
  }
}