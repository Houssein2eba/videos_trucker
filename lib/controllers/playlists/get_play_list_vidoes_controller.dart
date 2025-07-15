import 'package:flutter/material.dart';
import 'package:videos_trucker/models/video.dart';
import 'package:videos_trucker/sql/db.dart';

import 'package:get/get.dart';

class GetPlayListVidoesController extends GetxController {
  List<Video> videos = <Video>[];
  late int playListId;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    playListId = Get.arguments['playListId'] as int;
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    isLoading = true;
    update();
    final String sql = '''
      SELECT * FROM videos
      WHERE playListId = ?
      ORDER BY createdAt DESC
    ''';
    List<Object?> values = [playListId];
    List<Map<String, dynamic>> response = await SqlDb().readData(sql,values: values);
    videos = response.map((video) => Video.fromMap(video)).toList();
    isLoading = false;
    update();
  }

  Future<void> markVideoAsWatched({required Video video}) async {
    final int currentTotalSeconds = video.currentHours * 3600 +
          video.currentMinutes * 60 +
          video.currentSeconds;
      final int videoTotalSeconds = video.totalHours * 3600 +
          video.totalMinutes * 60 +
          video.totalSeconds;

      if (currentTotalSeconds == videoTotalSeconds) {
        Get.snackbar(
          'Already Watched',
          'This video is already marked as watched.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    final bool newWatchedStatus = video.isCompleted == 0 ? true : false;
    final int response = await SqlDb().updateVideoCompletionStatus(
      video.id,
      newWatchedStatus ? 1 : 0,
    );

    if (response <= 0) {
      Get.snackbar(
        'Error',
        'Failed to mark video as watched',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    videos = videos.map((vid) {
      if (vid.id == video.id) {
        return vid.copyWith(isCompleted: newWatchedStatus ? 1 : 0);
      }
      return vid;
    }).toList();

    update();
  }

  Future<void> toggleIsCurrent({required Video video}) async {
    final int currentTotalSeconds = video.currentHours * 3600 +
          video.currentMinutes * 60 +
          video.currentSeconds;
      final int videoTotalSeconds = video.totalHours * 3600 +
          video.totalMinutes * 60 +
          video.totalSeconds;

      if (currentTotalSeconds == videoTotalSeconds) {
        Get.snackbar(
          'Already Watched',
          'This video is not is completed.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    final bool newIsCurrentStatus = video.isCurrent == 0 ? true : false;
    final String sql = 'UPDATE videos SET isCurrent = ?, updatedAt = ? WHERE id = ?';
    final List<Object?> values = [
      newIsCurrentStatus ? 1 : 0,
      DateTime.now().millisecondsSinceEpoch,
      video.id,
    ];

    final int response = await SqlDb().updateData(sql, values: values);

    if (response <= 0) {
      Get.snackbar(
        'Error',
        'Failed to update current video status',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    videos = videos.map((vid) {
      if (vid.id == video.id) {
        return vid.copyWith(isCurrent: newIsCurrentStatus ? 1 : 0);
      }
      return vid;
    }).toList();

    update();
  }

  Future<void> deleteVideo(Video video) async {
    final String sql = 'DELETE FROM videos WHERE id = ?';
    final List<Object?> values = [video.id];
    

    final int response = await SqlDb().deleteData(sql, values: values);

    if (response > 0) {
      videos.removeWhere((vid) => vid.id == video.id);
      Get.snackbar(
        'Success',
        'Video deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      update();
    } else {
      Get.snackbar(
        'Error',
        'Failed to delete video',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
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
