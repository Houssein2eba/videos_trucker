
import 'package:videos_trucker/models/video.dart';

class PlayList{
    final String id;
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
}