import 'package:videos_trucker/models/video.dart';
import 'package:videos_trucker/sql/db.dart';

import 'package:get/get.dart';

class GetVideosController extends GetxController{

  List<Video> videos = <Video>[];
  bool isLoading = false;


  @override
  void onInit() {
    super.onInit();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    isLoading = true;
    update();
    final String sql = '''
      SELECT * FROM videos
      ORDER BY createdAt DESC
    ''';
    List<Map<String, dynamic>> response = await SqlDb().readData(sql);
    videos = response.map((video) => Video.fromMap(video)).toList();
    isLoading = false;
    update();
  }
}