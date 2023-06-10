import 'package:intl/intl.dart';

class IDDateUtils {

  static String PATTERN_DD_MMM_YYYY = 'dd MMM, yyyy';
  static String PATTERN_HH_MM_A = 'HH:mm a';

  static String formatDateTime(DateTime dateTime, String pattern) {
    return DateFormat(pattern).format(dateTime);
  }
}
