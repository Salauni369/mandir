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
        const SizedBox(height: 18),
        Obx(
          () => Column(
            children: controller.darshanTimings
                .map((t) => _darshanCard(controller, t))
                .toList(),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: _addMoreButton(
            "Add More Darshan Timings",
            onPressed: () {
              controller.addDarshanTiming(
                TimingModel(
                  title: "New Darshan",
                  startTime: "00:00",
                  endTime: "00:00",
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 30),
        _sectionHeader("Aarti Timings"),
        const SizedBox(height: 16),
        Obx(
          () => Column(
            children: controller.aartiTimings
                .map((t) => _darshanCard(controller, t, isAarti: true))
                .toList(),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: _addMoreButton(
            "Add More Aarti Timings",
            onPressed: () {
              controller.addAartiTiming(
                TimingModel(
                  title: "New Aarti",
                  startTime: "00:00",
                  endTime: "00:00",
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }

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
          Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
        ],
      ),
    );
  }

  Widget _darshanCard(ManageController controller, t, {bool isAarti = false}) {
    final titleCtrl = TextEditingController()..text = t.title;
    final startCtrl = TextEditingController()..text = t.startTime;
    final endCtrl = TextEditingController()..text = t.endTime;

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
          const Text(
            "Title *",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: titleCtrl,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Start & End Time *",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _timePickerField(startCtrl)),
              const SizedBox(width: 12),
              Expanded(child: _timePickerField(endCtrl)),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                if (isAarti) {
                  controller.aartiTimings.remove(t);
                } else {
                  controller.darshanTimings.remove(t);
                }
              },
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.red,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timePickerField(TextEditingController controller) {
    return TextField(
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: Colors.black87),
        suffixIcon: const Icon(Icons.access_time, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _addMoreButton(String text, {required VoidCallback onPressed}) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add_circle_outline, color: Color(0xFFFF7722)),
      label: Text(
        text,
        style: const TextStyle(color: Color(0xFFFF7722), fontSize: 13),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: Color(0xFFFF7722), width: 1.5),
        ),
      ),
    );
  }
}
