extension RuntimeListExtension on List<int>? {
  String get formattedAverageRuntime {
    if (this == null || this!.isEmpty) return "N/A";

    double avg = this!.reduce((a, b) => a + b) / this!.length;

    return "${avg.round()} min";
  }
}
