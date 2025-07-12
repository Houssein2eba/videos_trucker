
import 'package:videos_trucker/models/video.dart';

class PlayList{
    final int id;
  final String title;
  final int isCurrent;
  final int isCompleted;
  final List<Video> videos;
  final DateTime uploadDate;
  final DateTime? finishedDate;

  PlayList({
    required this.id,
    required this.title,
    required this.isCurrent,
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
        videos = [], 
        uploadDate = DateTime.fromMillisecondsSinceEpoch(playlist['createdAt']),
        finishedDate = playlist['updatedAt'] != null
            ? DateTime.fromMillisecondsSinceEpoch(playlist['updatedAt'])
            : null;
  }
