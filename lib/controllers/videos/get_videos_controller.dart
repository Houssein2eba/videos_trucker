import 'package:flutter/material.dart';
import 'package:videos_trucker/models/video.dart';
import 'package:videos_trucker/sql/db.dart';

import 'package:get/get.dart';

class GetVideosController extends GetxController {
  List<Video> videos = <Video>[];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    isLoading = true;
    update();
    final String sql = '''
      SELECT * FROM videos
      ORDER BY createdAt DESC
    ''';
    List<Map<String, dynamic>> response = await SqlDb().readData(sql);
    videos = response.map((video) => Video.fromMap(video)).toList();
    isLoading = false;
    update();
  }

  Future<void> markVideoAsWatched({required Video video}) async {
    
    String sql=video.isCurrent == 1? 'UPDATE videos SET isCurrent=0 WHERE id=?': 'UPDATE videos SET isCurrent=1 WHERE id=?';
    

    List<Object?> values = [video.id];

    final int response = await SqlDb().updateData(sql, values: values);
    if (response <= 0) {
      Get.snackbar(
        'Error',
        'Failed to mark video as watched',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      
      update();
      return;
    }
    videos =
        videos.map((vid) {
          if (vid.id == video.id) {
            vid.isCurrent = 1 - vid.isCurrent; 
          }
          return vid;
        }).toList();
    
    update();
  }

  double calculateProgress(Video video) {
    try {
      final current =
          (video.currentHours * 3600) +
          (video.currentMinutes * 60) +
          video.currentSeconds;
      final total =
          (video.totalHours * 3600) +
          (video.totalMinutes * 60) +
          video.totalSeconds;

      if (total == 0) {
        return 0.0;
      }

      return (current / total).clamp(0.0, 1.0);
    } catch (e) {
      print('Error calculating progress for video ${video.id}: $e');
      return 0.0;
    }
  }
}
