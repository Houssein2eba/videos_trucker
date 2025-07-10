
class Video {
  final String id;
  final String title;
  final int currentHours;
  final int currentMinutes;
  final int currentSeconds;
  final int totalHours;
  final int totalMinutes;
  final int totalSeconds;
  final int isCurrent;
  final int isCompleted;
  final DateTime uploadDate;
  final DateTime? finishedDate;

  Video({
    required this.id,
    required this.title,
    required this.currentHours,
    required this.currentMinutes,
    required this.currentSeconds,
    required this.totalHours,
    required this.totalMinutes,
    required this.totalSeconds,
    required this.isCurrent,
    required this.isCompleted,
    required this.uploadDate,
    this.finishedDate
  });

  Video.fromMap(Map<String, dynamic> map)
      : id = map['id'].toString(),
        title = map['title'],
        currentHours = map['currentHours'],
        currentMinutes = map['currentMinutes'],
        currentSeconds = map['currentSeconds'],
        totalHours = map['totalHours'],
        totalMinutes = map['totalMinutes'],
        totalSeconds = map['totalSeconds'],
        isCurrent = map['isCurrent'],
        isCompleted = map['isCompleted'],
        uploadDate = DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
        finishedDate = map['updatedAt'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
            : null;



}

