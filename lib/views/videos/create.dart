import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videos_trucker/controllers/videos/create_video_controller.dart';
import 'package:videos_trucker/widgets/time_inputs.dart';

class CreateVideo extends GetView<CreateVideoController> {
  const CreateVideo({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Video'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('Current Progress', style: TextStyle(fontSize: 16.0)),
                const SizedBox(height: 8.0),
                TimeInputs(
                  hoursController: controller.currentHoursController,
                  minutesController: controller.currentMinutesController,
                  secondsController: controller.currentSecondsController,
                ),
                //total time inputs
                const Text('Total Duration', style: TextStyle(fontSize: 16.0)),
                const SizedBox(height: 8.0),
                TimeInputs(
                  hoursController: controller.totalHoursController,
                  minutesController: controller.totalMinutesController,
                  secondsController: controller.totalSecondsController,
                ),
                const SizedBox(height: 32.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        print('Video Created: ${controller.titleController.text}');
                        print('Current Progress: ${controller.currentHoursController.text}:${controller.currentMinutesController.text}:${controller.currentSecondsController.text}');
                        print('Total Duration: ${controller.totalHoursController.text}:${controller.totalMinutesController.text}:${controller.totalSecondsController.text}');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 18.0),
                    ),
                    child: const Text('Create Video'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    
    );
  }
}