import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videos_trucker/core/constant/colors_class.dart';
import 'package:videos_trucker/models/playlist.dart';

class ListPlaylistsCard extends StatelessWidget {
  final PlayList playlist;
  final void Function()? onTap;
  final void Function()? onMarkWatched;
  final void Function(DismissDirection)? onDismissed;

  const ListPlaylistsCard({
    super.key,
    required this.playlist,
    this.onTap,
    this.onMarkWatched,
    this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(playlist.id.toString()),
      onDismissed: onDismissed,
      confirmDismiss: (direction) async {
        return await Get.defaultDialog(
          title: 'Delete Playlist',
          middleText: 'Are you sure you want to delete this playlist?',
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
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.playlist_play,
                      size: 50,
                      color: AppColors.primaryColor,
                    ),
                    IconButton(
                      onPressed: onMarkWatched,
                      icon: playlist.isCompleted == 1
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : const Icon(Icons.circle_outlined, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  playlist.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  'Videos: ${playlist.videoCount}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
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