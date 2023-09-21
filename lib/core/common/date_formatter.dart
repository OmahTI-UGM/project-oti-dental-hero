import 'package:intl/intl.dart';

class DateFormatter {
  static String homeScreenDate(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  static String galleryScreenDate(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }
}
