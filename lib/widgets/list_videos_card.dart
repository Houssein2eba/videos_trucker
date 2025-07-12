import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videos_trucker/core/functions/get_progress_color.dart';
import 'package:videos_trucker/models/video.dart';
import 'package:videos_trucker/widgets/build_time_text.dart';

class ListVideosCard extends StatelessWidget {
  final Video video;
  final void Function()? onPressed;
  final void Function(DismissDirection)? onDismissed;
  final double progress;
  final Color? background;
  const ListVideosCard({
    super.key,
    required this.video,
    required this.progress,
    required this.onPressed,
    required this.background,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(video.id.toString()),
      onDismissed: onDismissed,
      confirmDismiss: (direction) async {
        return await Get.defaultDialog(
          title: 'Delete Video',
          middleText: 'Are you sure you want to delete this video?',
          textConfirm: 'Delete',
          textCancel: 'Cancel',
          onConfirm: () => Get.back(result: true),
        );
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Card(
        elevation: 2,
        color: background ?? Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              leading: IconButton(
                onPressed: onPressed,
                icon: video.isCurrent == 1
                    ? const Icon(Icons.play_circle)
                    : const Icon(Icons.stop_circle),
              ),
              title: Text(
                video.title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 8,
                          backgroundColor: Colors.grey[200],
                          color: getProgressColor(progress),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1, // 1 part of available space
                        child: Text(
                          '${(progress * 100).toStringAsFixed(1)}%',
                          style: TextStyle(
                            color: getProgressColor(progress),
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
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
                          children: buildTimeTexts(context, video),
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: buildTimeTexts(context, video),
                        );
                      }
                    },
                  ),
                ],
              ),
              trailing: progress * 100 == 100
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.play_circle_outline,
                      color: Color.fromARGB(255, 235, 35, 35)),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: video.isCurrent == 1 ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  video.isCurrent == 1 ? 'Current' : 'Not Current',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
