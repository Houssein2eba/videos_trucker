import 'package:get/get.dart';
import 'package:videos_trucker/models/playlist.dart';
import 'package:videos_trucker/sql/db.dart';
import 'package:flutter/material.dart';

class GetPlayListsController extends GetxController{

  List<PlayList> playList=<PlayList>[];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    getPlayLists();
  }

  Future<void> getPlayLists()async{
    isLoading=true;
    update();

    List<Map<String, dynamic>> response = await SqlDb().readData(
      "SELECT *,COUNT(videoId) as videoCount FROM playlists ORDER BY createdAt DESC"
    );
    playList=response.map((playlist) => PlayList.fromMap(playlist)).toList();
    print("first playlist: ${playList.firstOrNull?.title ?? 'No playlists found'}");
    isLoading=false;
    update();
  }

  Future<void> toggleIsCurrent({required PlayList playlist}) async {
    final bool newIsCurrentStatus = playlist.isCurrent == 0 ? true : false;
    final String sql = 'UPDATE playlists SET isCurrent = ?, updatedAt = ? WHERE id = ?';
    final List<Object?> values = [
      newIsCurrentStatus ? 1 : 0,
      DateTime.now().millisecondsSinceEpoch,
      playlist.id,
    ];

    final int response = await SqlDb().updateData(sql, values: values);

    if (response <= 0) {
      Get.snackbar(
        'Error',
        'Failed to update current playlist status',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    playList = playList.map((pl) {
      if (pl.id == playlist.id) {
        return pl.copyWith(isCurrent: newIsCurrentStatus ? 1 : 0);
      }
      return pl;
    }).toList();

    update();
  }

  Future<void> markPlaylistAsWatched({required PlayList playlist}) async {
    final bool newWatchedStatus = playlist.isCompleted == 0 ? true : false;
    final int response = await SqlDb().updatePlaylistCompletionStatus(
      playlist.id,
      newWatchedStatus ? 1 : 0,
    );

    if (response <= 0) {
      Get.snackbar(
        'Error',
        'Failed to mark playlist as watched',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    playList = playList.map((pl) {
      if (pl.id == playlist.id) {
        return pl.copyWith(isCompleted: newWatchedStatus ? 1 : 0);
      }
      return pl;
    }).toList();

    update();
  }

  Future<void> deletePlaylist(PlayList playlist) async {
    final String sql = 'DELETE FROM playlists WHERE id = ?';
    final List<Object?> values = [playlist.id];

    final int response = await SqlDb().deleteData(sql, values: values);

    if (response > 0) {
      playList.removeWhere((pl) => pl.id == playlist.id);
      Get.snackbar(
        'Success',
        'Playlist deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      update();
    } else {
      Get.snackbar(
        'Error',
        'Failed to delete playlist',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}