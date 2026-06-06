extension RuntimeFormatterExt on num {
  String runtimeFormatter() {
    int totalMinutes = toInt();

    int hours = totalMinutes ~/ 60;

    int minutes = totalMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return '${hours}h ${minutes}m';
    } else if (hours > 0) {
      return '${hours}h';
    } else {
      return '${minutes}m';
    }
  }
}
