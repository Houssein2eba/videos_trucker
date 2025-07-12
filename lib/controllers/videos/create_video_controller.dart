import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videos_trucker/controllers/videos/get_videos_controller.dart';
import 'package:videos_trucker/routes.dart';
import 'package:videos_trucker/sql/db.dart';

class CreateVideoController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController currentHoursController;
  late TextEditingController currentMinutesController;
  late TextEditingController currentSecondsController;
  late TextEditingController totalMinutesController;
  late TextEditingController totalSecondsController;
  late TextEditingController totalHoursController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SqlDb sqlDb = SqlDb();
  bool areInputsValid = true;

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    currentHoursController = TextEditingController();
    currentMinutesController = TextEditingController();
    currentSecondsController = TextEditingController();
    totalMinutesController = TextEditingController();
    totalSecondsController = TextEditingController();
    totalHoursController = TextEditingController();
  }

  crateVideo() async{
    if (formKey.currentState!.validate()) {
      try {
      
      final currentHours = int.parse(currentHoursController.text);
      final currentMinutes = int.parse(currentMinutesController.text);
      final currentSeconds = int.parse(currentSecondsController.text);
      
      final totalHours = int.parse(totalHoursController.text);
      final totalMinutes = int.parse(totalMinutesController.text);
      final totalSeconds = int.parse(totalSecondsController.text);

      // Calculate total seconds for comparison
      final int currentTotalSeconds = currentHours * 3600 + currentMinutes * 60 + currentSeconds;
      final int videoTotalSeconds = totalHours * 3600 + totalMinutes * 60 + totalSeconds;

      // Validate current progress doesn't exceed total duration
      if (currentTotalSeconds > videoTotalSeconds) {
        Get.snackbar(
          'Invalid Time',
          'Current progress cannot exceed total duration',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Please enter valid numeric values for time inputs',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }


      final String sql = '''
        INSERT INTO videos (title, currentHours, currentMinutes, currentSeconds, totalHours, totalMinutes, totalSeconds,isCompleted,isCurrent)
        VALUES (?, ?, ?, ?, ?, ?, ?,?,?)
      ''';
      final List<Object?> values = [
        titleController.text,
        int.tryParse(currentHoursController.text),
        int.tryParse(currentMinutesController.text),
        int.tryParse(currentSecondsController.text),
        int.tryParse(totalHoursController.text),
        int.tryParse(totalMinutesController.text),
        int.tryParse(totalSecondsController.text),
        0,
        0,
      ];
      var response=await sqlDb.insertData(sql,values: values);
      if (response > 0) {
        Get.snackbar('Success', 'Video created successfully!');
        titleController.clear();
        currentHoursController.clear();
        currentMinutesController.clear();
        currentSecondsController.clear();
        totalHoursController.clear();
        totalMinutesController.clear();
        totalSecondsController.clear();
        Get.find<GetVideosController>().fetchVideos();
         Get.until((route) => route.settings.name == Routes.videosHome);
      } else {
        Get.snackbar('Error', 'Failed to create video.');
      }

      
    } else {
      Get.snackbar('Error', 'Please fill in all fields correctly.');
    }
  }
}
