import 'package:get/get.dart';
import 'package:videos_trucker/controllers/playlists/create_play_list_controller.dart';
import 'package:videos_trucker/controllers/playlists/get_play_lists_controller.dart';
import 'package:videos_trucker/controllers/videos/create_video_controller.dart';
import 'package:videos_trucker/controllers/videos/edit_video_controller.dart';
import 'package:videos_trucker/controllers/videos/get_videos_controller.dart';
import 'package:videos_trucker/views/home.dart';
import 'package:videos_trucker/views/playlists/create.dart';
import 'package:videos_trucker/views/playlists/index.dart';
import 'package:videos_trucker/views/videos/create.dart';
import 'package:videos_trucker/views/videos/edit.dart';
import 'package:videos_trucker/views/videos/index.dart';

class Routes {
  static const String home = '/';
  static const String videosHome = '/videos-home';
  static const String createVideo = '/create-video';
  static const String editVideo = '/edit-video';
  static const String playlistsHome = '/playlists-home';
  static const String createPlaylist = '/create-playlist';

  static List<GetPage> getPages() {
    return [
      GetPage(
        name: home,
        page: () => const Home(),
      ),
      GetPage(
        name: videosHome,
        page: () => const VideosHome(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => GetVideosController());
        }),
      ),
      GetPage(
        name: createVideo,
        page: () => const CreateVideo(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CreateVideoController());
        }),
      ),
      GetPage(
        name: editVideo,
        page: () => const EditVideo(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => EditVideoController());
        }),
      ),
      GetPage(
        name: playlistsHome,
        page: () => const PlaylistsHome(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => GetPlayListsController());
        })
      ),
      GetPage(
        name: createPlaylist,
        page: () => const CreatePlayList(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CreatePlayListController());
        })
      )
      
    ];
  }
}
