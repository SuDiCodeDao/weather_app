import 'package:intl/intl.dart';

class AppUtils {
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('EEEE dd - ').add_jm().format(dateTime);
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat().add_jm().format(dateTime);
  }
}
