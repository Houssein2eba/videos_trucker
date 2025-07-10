import 'package:get/get.dart';
import 'package:videos_trucker/controllers/videos/create_video_controller.dart';
import 'package:videos_trucker/controllers/videos/get_videos_controller.dart';
import 'package:videos_trucker/views/home.dart';
import 'package:videos_trucker/views/videos/create.dart';
import 'package:videos_trucker/views/videos/index.dart';

class Routes {
  static const String home = '/';
  static const String videosHome = '/videos-home';
  static const String createVideo = '/create-video';

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
    ];
  }
}
