

  String formatTime(String hours, String minutes, String seconds) {
    final h = int.tryParse(hours) ?? 0;
    final m = int.tryParse(minutes) ?? 0;
    final s = int.tryParse(seconds) ?? 0;
    
    if (h > 0) return '${h}h ${m}m ${s}s';
    if (m > 0) return '${m}m ${s}s';
    
    return '${s}s';
  }