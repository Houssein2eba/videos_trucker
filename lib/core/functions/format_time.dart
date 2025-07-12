

  String formatTime(String hours, String minutes, String seconds) {
    final h = int.tryParse(hours) ?? 0;
    final m = int.tryParse(minutes) ?? 0;
    final s = int.tryParse(seconds) ?? 0;
    
    if (h > 0) return '${h}h ${m>0? '${m}m': '${m}0'}m ';
    if (m > 0) return '${m}m ${s>0? '${s}s': '${s}0'}s';
    return '${s}s';
  }