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
String generateMessageTemplate({
  required String template,
  required int amount,
  required int netBalance,
}) {
  const String placeholder = "%d";
  int firstIndex = template.indexOf(placeholder);
  int lastIndex = template.lastIndexOf(placeholder);

  String generatedMessage = template.replaceFirst(
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
