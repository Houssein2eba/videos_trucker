import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videos_trucker/controllers/videos/get_videos_controller.dart';
import 'package:videos_trucker/core/constant/colors_class.dart';
import 'package:videos_trucker/core/functions/format_time.dart';
import 'package:videos_trucker/core/widgets/loadin_indicator.dart';
import 'package:videos_trucker/routes.dart';
import 'package:videos_trucker/widgets/list_videos_card.dart';
import 'package:videos_trucker/widgets/no_videos.dart';

class VideosHome extends GetView<GetVideosController> {
  const VideosHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Videos'),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.fetchVideos(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.createVideo),
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add, size: 28),
      ),
      body: GetBuilder<GetVideosController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: LoadinIndicator());
          }

          if (controller.videos.isEmpty) {
            return Center(
              child: NoVideos(onPressed: () => Get.toNamed(Routes.createVideo)),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.videos.length,
            separatorBuilder: (context, index) => const Divider(height: 16),
            itemBuilder: (context, index) {
              final video = controller.videos[index];
              final progress = controller.calculateProgress(video);
              return ListVideosCard(background: video.isCurrent==1 ? AppColors.splashColor : AppColors.backgroundColor,progress: progress,video: video,onPressed: (){
                controller.markVideoAsWatched(video: video);
              },);
            },
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String videoId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Video'),
            content: const Text('Are you sure you want to delete this video?'),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}
