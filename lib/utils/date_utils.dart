import 'package:intl/intl.dart';

class IDDateUtils {

  static const String DDMMMYYYY = 'dd MMM, yyyy';
  static const String HHMMA = 'HH:mm a';

  static String formatDateTime(DateTime dateTime, String pattern) {
    return DateFormat(pattern).format(dateTime);
  }
}
