import 'package:club_cash/src/core/helpers/logger.dart';
import 'package:flutter/foundation.dart';

/// Debug Print Utility
///
/// ## Usage
/// To log debug information, call `kPrint(data)` with the desired [data] to print.
/// The information will be displayed in the console during debugging sessions.
///
/// Example:
/// ```dart
/// kPrint("Debug information");
/// ```
void kPrint(dynamic data) {
  if (kDebugMode) {
    print(data);
  }
}


/// Generate message template:
///
/// This method ensures that if there are two %d in the template,
/// the first one replaced by amount and the last one replaced by netBalance.
/// If there's only one %d in the template, it's replaced with amount.
String generateMessage({
  required String message,
  required num amount,
  required num netBalance,
}) {
  const String placeholder = "%d";
  int firstIndex = message.indexOf(placeholder);
  int lastIndex = message.lastIndexOf(placeholder);

  String generatedMessage = message.replaceFirst(
    placeholder,
    amount.toString(),
  );

  if (firstIndex != lastIndex) {
    generatedMessage = generatedMessage.replaceFirst(
      placeholder,
      netBalance.toString(),
    );
  }

  Log.debug(generatedMessage);

  return generatedMessage;
}
