import 'package:get/get.dart';
import 'package:videos_trucker/models/video.dart';
import 'package:videos_trucker/sql/db.dart';

class MarkVideoWatchedController extends GetxController {
  final SqlDb _sqlDb = SqlDb();

  Future<void> markVideoWatched(Video video, bool watched) async {
    try {
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
      await _sqlDb.updateVideoCompletionStatus(video.id, watched ? 1 : 0);
      Get.snackbar(
        'Success',
        watched ? 'Video marked as watched' : 'Video marked as unwatched',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update video status: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}