import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videos_trucker/controllers/videos/get_videos_controller.dart';
import 'package:videos_trucker/models/video.dart';
import 'package:videos_trucker/routes.dart';
import 'package:videos_trucker/sql/db.dart';

class EditVideoController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController currentHoursController;
  late TextEditingController currentMinutesController;
  late TextEditingController currentSecondsController;
  late Video video;
  

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    currentHoursController = TextEditingController();
    currentMinutesController = TextEditingController();
    currentSecondsController = TextEditingController();
    video = Get.arguments['video'] as Video;
    titleController.text = video.title;
    currentHoursController.text = video.currentHours.toString();
    currentMinutesController.text = video.currentMinutes.toString();
    currentSecondsController.text = video.currentSeconds.toString();

  }

  Future<void> updateVideo() async {
    if (formKey.currentState!.validate()) {
      try {
        final currentHours = int.parse(currentHoursController.text);
        final currentMinutes = int.parse(currentMinutesController.text);
        final currentSeconds = int.parse(currentSecondsController.text);
        final totalHours = video.totalHours;
        final totalMinutes = video.totalMinutes;  
        final totalSeconds = video.totalSeconds;

              final int currentTotalSeconds = currentHours * 3600 + currentMinutes * 60 + currentSeconds;
      final int videoTotalSeconds = totalHours * 3600 + totalMinutes * 60 + totalSeconds;

        if( currentTotalSeconds > videoTotalSeconds) {
          Get.snackbar(
            'Invalid Time',
            'Current progress cannot exceed total duration',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }
        final String sql = '''
          UPDATE videos 
          SET title = ?, 
              currentHours = ?, 
              currentMinutes = ?, 
              currentSeconds = ?, 
              updatedAt = strftime('%s', 'now') 
          WHERE id = ?
        ''';
        final List<Object?> values = [
          titleController.text,
          currentHours,
          currentMinutes,
          currentSeconds,
          video.id
        ];
        int response=await SqlDb().updateData(sql, values: values);

        if (response > 0) {
          Get.snackbar('Success', 'Video updated successfully');
          video.title = titleController.text;
          video.currentHours = currentHours;
          video.currentMinutes = currentMinutes;
          video.currentSeconds = currentSeconds;
                   Get.until((route) => route.settings.name == Routes.videosHome);
                   Get.find<GetVideosController>().fetchVideos();
          update();

        } else {
          Get.snackbar('Error', 'Failed to update video');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to update video: $e');
      }
    }
  }
}
