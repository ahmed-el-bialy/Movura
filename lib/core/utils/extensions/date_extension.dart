import 'package:timeago/timeago.dart' as timeago;

extension DateFormatter on String {
  String toTimeAgo() {
    try {
      final DateTime parsedDate = DateTime.parse(this).toLocal();

      return timeago.format(parsedDate, locale: 'en');
    } catch (e) {
      return '';
    }
  }
}
