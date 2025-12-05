import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/donation_controllers.dart';
import '../../../widgets/app_colors.dart';
import '../../../widgets/daancard.dart';


class DaanListPage extends StatelessWidget {
  final controller = Get.find<DaanController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.hinduL1,
      appBar: AppBar(
        backgroundColor: AppColors.hinduBase,
        title: Text('Daan', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ElevatedButton.icon(
              onPressed: () => Get.toNamed('/addDaan'),
              icon: Icon(Icons.add),
              label: Text('Add'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: StadiumBorder()),
            ),
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: AppColors.hinduBase));
        }
        if (controller.list.isEmpty) {
          return Center(child: Text('No daan available'));
        }
        return RefreshIndicator(
          onRefresh: controller.fetch,
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: controller.list.length,
            itemBuilder: (_, i) => DaanCard(daan: controller.list[i]),
          ),
        );
      }),
    );
  }
}
