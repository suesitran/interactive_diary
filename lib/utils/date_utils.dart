import 'package:intl/intl.dart';

class IDDateUtils {

  static const String pattern_dd_mm_yyyy = 'dd MMM, yyyy';
  static const String pettern_hh_mm_a = 'HH:mm a';

  static String formatDateTime(DateTime dateTime, String pattern) {
    return DateFormat(pattern).format(dateTime);
  }
}
