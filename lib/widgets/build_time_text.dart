  import 'package:flutter/material.dart';
import 'package:videos_trucker/core/functions/format_time.dart';

List<Widget> buildTimeTexts(BuildContext context, video) {
    return [
      Text(
        'Progress: ${formatTime(video.currentHours.toString(), video.currentMinutes.toString(), video.currentSeconds.toString())}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      Text(
        'Total: ${formatTime(video.totalHours.toString(), video.totalMinutes.toString(), video.totalSeconds.toString())}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    ];
  }