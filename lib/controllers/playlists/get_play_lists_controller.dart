import 'package:get/get.dart';
import 'package:videos_trucker/models/playlist.dart';
import 'package:videos_trucker/sql/db.dart';

class GetPlayListsController extends GetxController{

  List<PlayList> playList=<PlayList>[];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    getPlayLists();
  }

  Future<void> getPlayLists()async{
    isLoading=true;
    update();

    List<Map<String, dynamic>> response = await SqlDb().readData(
      "SELECT * FROM playlists ORDER BY createdAt DESC"
    );
    playList=response.map((playlist) => PlayList.fromMap(playlist)).toList();
    print("first playlist: ${playList.firstOrNull?.title ?? 'No playlists found'}");
    isLoading=false;
    update();
  }
}