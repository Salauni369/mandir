import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/manage_controller.dart';
import '../../models/timming_model.dart';

class TimingTab extends StatelessWidget {
  const TimingTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ManageController controller = Get.find();

    return ListView(
      padding: const EdgeInsets.all(1),
      children: [
        _sectionHeader("Darshan Timings"),
        const SizedBox(height: 16),

        Obx(() => Column(
          children: controller.darshanTimings
              .map((t) => _timingCard(controller, t, false))
              .toList(),
        )),

        const SizedBox(height: 10),

        Center(
          child: _addBtn("Add More Darshan Timings", () {
            controller.addDarshanTiming(
              TimingModel(title: "", startTime: "", endTime: ""),
            );
          }),
        ),

        const SizedBox(height: 30),

        _sectionHeader("Aarti Timings"),
        const SizedBox(height: 16),

        Obx(() => Column(
          children: controller.aartiTimings
              .map((t) => _timingCard(controller, t, true))
              .toList(),
        )),

        const SizedBox(height: 10),

        Center(
          child: _addBtn("Add More Aarti Timings", () {
            controller.addAartiTiming(
              TimingModel(title: "", startTime: "", endTime: ""),
            );
          }),
        ),

        const SizedBox(height: 40),
      ],
    );
  }

  // SECTION HEADER UI
  Widget _sectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1E9),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  // MAIN TIMING CARD
  Widget _timingCard(
      ManageController controller, TimingModel t, bool isAarti) {
    final titleCtrl = TextEditingController(text: t.title);
    final startCtrl = TextEditingController(text: t.startTime);
    final endCtrl = TextEditingController(text: t.endTime);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Title *",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),

          TextField(
            controller: titleCtrl,
            style: const TextStyle(fontSize: 12),
            onChanged: (v) => t.title = v,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide.none,
              ),
              contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            ),
          ),

          const SizedBox(height: 16),

          const Text("Start & End Time *",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),

          Row(
            children: [
              Expanded(child: _timeField(startCtrl, (v) => t.startTime = v)),
              const SizedBox(width: 12),
              Expanded(child: _timeField(endCtrl, (v) => t.endTime = v)),
            ],
          ),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                isAarti
                    ? controller.aartiTimings.remove(t)
                    : controller.darshanTimings.remove(t);
              },
              icon: const Icon(Icons.delete_forever, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // TIME PICKER FIELD
  Widget _timeField(
      TextEditingController ctrl, Function(String) onTimePicked) {
    return TextField(
      readOnly: true,
      controller: ctrl,
      style: const TextStyle(fontSize: 12),
      onTap: () async {
        TimeOfDay? picked = await showTimePicker(
          context: Get.context!,
          initialTime: TimeOfDay.now(),
        );

        if (picked != null) {
          String formatted = picked.format(Get.context!);
          ctrl.text = formatted;
          onTimePicked(formatted);
        }
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        suffixIcon: const Icon(Icons.access_time, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide.none,
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }

  // ADD BUTTON
  Widget _addBtn(String txt, VoidCallback action) {
    return IntrinsicWidth(
      child: TextButton.icon(
        onPressed: action,
        icon: const Icon(Icons.add_circle_outline, color: Color(0xFFFF7722)),
        label: Text(txt,
            style: const TextStyle(color: Color(0xFFFF7722), fontSize: 12)),
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: Color(0xFFFF7722)),
          ),
        ),
      ),
    );
  }
}
