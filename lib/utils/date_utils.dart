import 'package:intl/intl.dart';

class IDDateUtils {

  static String PATTERN_dd_MMM_yyyy = 'dd MMM, yyyy';
  static String PATTERN_HH_mm_a = 'HH:mm a';

  static String formatDateTime(DateTime dateTime, String pattern) {
    return DateFormat(pattern).format(dateTime);
  }
}
