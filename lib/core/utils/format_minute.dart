String formatDurationMinutes(num? totalMinutes) {
  if (totalMinutes == null || totalMinutes == 0) return 'N/A';

  int minutesValue = totalMinutes.toInt();

  final int days = minutesValue ~/ 1440; // 24 * 60
  minutesValue %= 1440;

  final int hours = minutesValue ~/ 60;
  minutesValue %= 60;

  final int minutes = minutesValue;

  final List<String> parts = [];

  String plural(int value, String unit) =>
      value == 1 ? '$value $unit' : '$value ${unit}s';

  if (days > 0) parts.add(plural(days, 'day'));
  if (hours > 0) parts.add(plural(hours, 'hour'));

  if (minutes > 0) {
    parts.add("${minutes.toString().padLeft(2, '0')} min");
  }

  return parts.isEmpty ? 'N/A' : parts.join(', ');
}
