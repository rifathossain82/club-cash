import 'package:connectivity_plus/connectivity_plus.dart';

/// A service class for handling internet connectivity checks.
///
/// This class provides an asynchronous function, [hasInternet], to determine the device's internet connectivity status.
class ConnectivityService {
  /// Asynchronously checks the device's internet connectivity.
  ///
  /// Uses the Connectivity plugin to determine the current connection status.
  ///
  /// Returns a `Future<bool>` indicating whether the device has an active internet connection or not.
  ///
  /// * `true` if the device is connected to the internet (Wi-Fi or cellular network).
  /// * `false` if the device is not connected to any network or the connection type is unknown.
  ///
  /// Usage:
  /// ```dart
  /// bool isConnected = await ConnectivityService.hasInternet;
  /// if (isConnected) {
  ///   // Perform actions requiring internet connection.
  /// } else {
  ///   // Handle the case when there is no internet connection.
  /// }
  /// ```
  ///
  /// Please ensure the `connectivity` plugin is added to your `pubspec.yaml` file.
  /// For more information, visit: https://pub.dev/packages/connectivity
  static Future<bool> get hasInternet async {
    var result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
