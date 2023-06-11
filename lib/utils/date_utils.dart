import 'package:intl/intl.dart';

class IDDateUtils {

  static const String patternDDMMYYY = 'dd MMM, yyyy';
  static const String patternHHMMA = 'HH:mm a';

  static String formatDateTime(DateTime dateTime, String pattern) {
    return DateFormat(pattern).format(dateTime);
  }
}
