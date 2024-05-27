import 'dart:async';

import 'package:flutter/foundation.dart';

/// A utility class for debouncing actions in Flutter applications.
///
/// The `Debouncer` class provides a way to delay the execution of a function
/// by a specified duration, allowing developers to debounce user input or
/// other events to prevent excessive or rapid function calls. This can be
/// especially useful in scenarios such as search bars, where you want to
/// wait for the user to finish typing before performing a search operation.
///
/// After cancelling the previous timer (if any),
/// a new timer is created using the Timer class.
/// The timer will execute the provided action function after the specified duration.
/// In this case, the duration is set to 1000 milliseconds
/// (Duration(milliseconds: Duration.millisecondsPerSecond)),
/// which is equivalent to 1 second.
///
/// Example:
/// ```dart
/// Debouncer.run(() {
///   productBloc.add(
///     /// Perform search,
///   );
/// });
/// ```
class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  static Timer? timer;

  static run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      const Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}