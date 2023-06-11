import 'package:intl/intl.dart';

class IDDateUtils {

  static String _formatDateTime(DateTime dateTime, String pattern) {
    return DateFormat(pattern).format(dateTime);
  }

  static String dateFormatDDMMMYYYY(DateTime dateTime) {
    return _formatDateTime(dateTime, 'dd MMM, yyyy');
  }

  static String dateFormatHHMMA(DateTime dateTime) {
    return _formatDateTime(dateTime, 'HH:mm a');
  }
}
