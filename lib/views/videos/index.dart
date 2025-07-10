import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videos_trucker/routes.dart';

class VideosHome extends StatelessWidget {
  const VideosHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create video page
          Get.toNamed(Routes.createVideo);
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Text('Welcome to the Videos Home Page!'),
      ),
    );
  }
}