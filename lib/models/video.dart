
class Video {
  int id;
  String title;
  int currentHours;
  int currentMinutes;
  int currentSeconds;
  int totalHours;
  int totalMinutes;
  int totalSeconds;
  int isCurrent;
  int isCompleted;
  DateTime uploadDate;
  DateTime? finishedDate;

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
    this.finishedDate,
  });

  Video.fromMap(Map<String, dynamic> map)
      : id = map['id'],
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

  Video copyWith({
    int? id,
    String? title,
    int? currentHours,
    int? currentMinutes,
    int? currentSeconds,
    int? totalHours,
    int? totalMinutes,
    int? totalSeconds,
    int? isCurrent,
    int? isCompleted,
    DateTime? uploadDate,
    DateTime? finishedDate,
  }) {
    return Video(
      id: id ?? this.id,
      title: title ?? this.title,
      currentHours: currentHours ?? this.currentHours,
      currentMinutes: currentMinutes ?? this.currentMinutes,
      currentSeconds: currentSeconds ?? this.currentSeconds,
      totalHours: totalHours ?? this.totalHours,
      totalMinutes: totalMinutes ?? this.totalMinutes,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      isCurrent: isCurrent ?? this.isCurrent,
      isCompleted: isCompleted ?? this.isCompleted,
      uploadDate: uploadDate ?? this.uploadDate,
      finishedDate: finishedDate ?? this.finishedDate,
    );
  }
}

