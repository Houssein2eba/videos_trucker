import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videos_trucker/sql/db.dart';

class CreatePlayListController extends GetxController{
  late TextEditingController titleController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
  }

  Future<void> createPlaylist() async {
    if(!formKey.currentState!.validate()){
      return;
    }

    final String sql= '''
      INSERT INTO playlists (title, isCurrent, isCompleted, createdAt, updatedAt)
      VALUES (?, 0, 0, strftime('%s', 'now'), strftime('%s', 'now'))
    ''';
    int response = await SqlDb().insertData(sql, values: [titleController.text]);
    if(response > 0){
      Get.snackbar('Success', 'Playlist created successfully');
      Get.until((route) => route.settings.name == '/playlists-home');
      
    } else {
      Get.snackbar('Error', 'Failed to create playlist');
    }


  }
}