import 'package:videos_trucker/models/video.dart';

class PlayList {
   int id;
   String title;
   int isCurrent;
  int videoCount;
   int isCompleted;
   List<Video> videos;
   DateTime uploadDate;
   DateTime? finishedDate;

  PlayList({
    required this.id,
    required this.title,
    required this.isCurrent,
    required this.videoCount,
    required this.isCompleted,
    required this.videos,
    required this.uploadDate,
    required this.finishedDate,
  });

  PlayList.fromMap(Map<String, dynamic> playlist)
    : id = playlist['id'],
      title = playlist['title'],
      isCurrent = playlist['isCurrent'],
      isCompleted = playlist['isCompleted'],
      videoCount = playlist['videoCount'] ?? 1,
      videos = [],
      uploadDate = DateTime.fromMillisecondsSinceEpoch(playlist['createdAt']),
      finishedDate =
          playlist['updatedAt'] != null
              ? DateTime.fromMillisecondsSinceEpoch(playlist['updatedAt'])
              : null;
}
