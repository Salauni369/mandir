import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/live_darshan.dart';


class LiveDarshanScreen extends StatelessWidget {
  const LiveDarshanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LiveController>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7722),
        title: const Text("Darshan", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        actions: [
          IconButton(icon: const Icon(Icons.add, color: Colors.white), onPressed: () => Get.to(() => const AddDarshanPage())),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFFFF7722)));
        }

        final liveList = controller.liveDarshans.where((e) => e.isLive).toList();
        final pastList = controller.liveDarshans.where((e) => !e.isLive).toList();

        return RefreshIndicator(
          onRefresh: controller.fetchDarshans,
          child: ListView(padding: const EdgeInsets.all(16), children: [
            const Text("Live Darshan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: liveList.isEmpty
                  ? const Center(child: Text("No live darshan right now", style: TextStyle(fontSize: 16)))
                  : ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: liveList.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (_, i) => LiveDarshanCard(darshan: liveList[i]),
              ),
            ),
            const SizedBox(height: 32),
            const Text("Past Darshans", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            pastList.isEmpty ? const Center(child: Text("No past darshans yet", style: TextStyle(fontSize: 16))) : Column(children: pastList.map((item) => PastDarshanCard(darshan: item)).toList()),
            const SizedBox(height: 80),
          ]),
        );
      }),
    );
  }
}
