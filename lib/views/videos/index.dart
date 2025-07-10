import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videos_trucker/controllers/videos/get_videos_controller.dart';
import 'package:videos_trucker/core/constant/colors_class.dart';
import 'package:videos_trucker/routes.dart';

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
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.videos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.video_library, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No videos available',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.createVideo),
                    child: const Text('Create your first video'),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.videos.length,
            separatorBuilder: (context, index) => const Divider(height: 16),
            itemBuilder: (context, index) {
              final video = controller.videos[index];
              final progress = _calculateProgress(video);
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  leading: const Icon(Icons.video_collection, size: 32),
                  title: Text(
                    video.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            flex: 5, // 5 parts of available space
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 8,
                              backgroundColor: Colors.grey[200],
                              color: _getProgressColor(progress),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1, // 1 part of available space
                            child: Text(
                              '${(progress * 100).toStringAsFixed(1)}%',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Changed to Column for small screens
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 400) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: _buildTimeTexts(context, video),
                            );
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _buildTimeTexts(context, video),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _showDeleteDialog(context, video.id),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  List<Widget> _buildTimeTexts(BuildContext context, video) {
    return [
      Text(
        'Progress: ${_formatTime(video.currentHours.toString(), video.currentMinutes.toString(), video.currentSeconds.toString())}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      Text(
        'Total: ${_formatTime(video.totalHours.toString(), video.totalMinutes.toString(), video.totalSeconds.toString())}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    ];
  }

  double _calculateProgress(video) {
    try {
      final current = (int.tryParse(video.currentHours) ?? 0) * 3600 +
          (int.tryParse(video.currentMinutes) ?? 0) * 60 +
          (int.tryParse(video.currentSeconds) ?? 0);
      final total = (int.tryParse(video.totalHours) ?? 1) * 3600 +
          (int.tryParse(video.totalMinutes) ?? 0) * 60 +
          (int.tryParse(video.totalSeconds) ?? 0);

          print('Current: $current, Total: $total'); // Debugging line  
      
      return total > 0 ? (current / total).clamp(0.0, 1.0) : 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  Color _getProgressColor(double progress) {
    if (progress < 0.3) return Colors.red;
    if (progress < 0.7) return Colors.orange;
    return Colors.green;
  }

  String _formatTime(String hours, String minutes, String seconds) {
    final h = int.tryParse(hours) ?? 0;
    final m = int.tryParse(minutes) ?? 0;
    final s = int.tryParse(seconds) ?? 0;
    
    if (h > 0) return '${h}h ${m}m';
    if (m > 0) return '${m}m ${s}s';
    return '${s}s';
  }

  void _showDeleteDialog(BuildContext context, String videoId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Video'),
        content: const Text('Are you sure you want to delete this video?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              
            },
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