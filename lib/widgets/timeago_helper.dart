class TimeAgoHelper {
  static String getDetailedDifference(String apiTime) {
    final parsedTime = DateTime.parse(apiTime).toLocal();
    final now = DateTime.now();

    final diff = now.difference(parsedTime);

    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}m';
    } else {
      return '${diff.inSeconds}s';
    }
  }
}
