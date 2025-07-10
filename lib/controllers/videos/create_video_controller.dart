

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateVideoController extends GetxController{
  late TextEditingController titleController;
  late TextEditingController currentHoursController;
  late TextEditingController currentMinutesController;
  late TextEditingController currentSecondsController;
  late TextEditingController totalMinutesController;
  late TextEditingController totalSecondsController;
  late TextEditingController totalHoursController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  crateVideo() {
    if (formKey.currentState!.validate()) {
      // Process the data
      Get.snackbar('Success', 'Video created successfully!');
    } else {
      Get.snackbar('Error', 'Please fill in all fields correctly.');
    }
  }
}