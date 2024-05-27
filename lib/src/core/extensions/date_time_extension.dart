import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// Returns the date in 'yyyy/MM/dd' format (e.g., 01/01/2023).
  String get formattedDateWithSlashes {
    return "$year/$month/$day";
  }

  /// Returns the date in 'dd MMM yyyy' format (e.g., 01 Jan 2023).
  String get formattedDate {
    return DateFormat('dd MMM yyyy').format(this);
  }

  /// Returns the date and time in 'dd MMM yyyy, hh:mm AM/PM' format.
  /// (e.g., 01 Jan 2023, 03:30 PM).
  String get formattedDateTime {
    return DateFormat('dd MMM yyyy, hh:mm a').format(this);
  }

  /// Returns the date in 'yyyy-MM-dd' format (e.g., 2023-01-01).
  String get formattedRequestDate {
    return DateFormat('yyyy-MM-dd').format(this);
  }
}
