
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videos_trucker/controllers/playlists/get_play_lists_controller.dart';
import 'package:videos_trucker/core/constant/colors_class.dart';
import 'package:videos_trucker/core/widgets/loadin_indicator.dart';
import 'package:videos_trucker/routes.dart';
import 'package:videos_trucker/widgets/no_play_lists.dart';
import 'package:videos_trucker/widgets/list_playlists_card.dart';

class PlaylistsHome extends GetView<GetPlayListsController> {
  const PlaylistsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlists'),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<GetPlayListsController>(
        builder: (controller) {
          return  controller.isLoading ? const Center(child: LoadinIndicator()) : controller.playList.isEmpty?NoPlayLists(onPressed: () => Get.toNamed(Routes.createPlaylist)) : GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemCount: controller.playList.length, 
            itemBuilder: (context, index) {
              final playlist = controller.playList[index];
              return ListPlaylistsCard(
                playlist: playlist,
                onTap: () {
                  Get.toNamed(Routes.singlePlayListVideo, arguments: {'playListId': playlist.id});
                },
                onMarkWatched: () {
                  controller.markPlaylistAsWatched(playlist: playlist);
                },
                onDismissed: (direction) {
                  controller.deletePlaylist(playlist);
                },
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.createPlaylist);
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}
