String secondToMinute(int totalSeconds) {
  if (totalSeconds < 0) throw Exception('Time can not be negative');
  if (totalSeconds >= 60 * 60) throw Exception('Time can be only lower 1 hour');
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}
