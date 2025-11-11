import 'package:club_cash/src/core/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: kPrimarySwatchColor,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kScaffoldBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: kPrimaryColor,
      foregroundColor: kWhite,
      elevation: 0,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,

        /// Status bar brightness (optional)
        statusBarIconBrightness: Brightness.light, // For Android (light icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: kPrimaryColor,
      foregroundColor: kWhite,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(Typography.blackCupertino),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStatePropertyAll(kPrimaryColor),
      checkColor: WidgetStatePropertyAll(kWhite),
      side: BorderSide(color: kGrey),
    ),
    iconTheme: IconThemeData(
      color: kGrey,
    ),
  );

  static void setDarkStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    );
  }

  static void setLightStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // For Android (light icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    );
  }

  static void enableInitialThemeSetting() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  /// to hide top and bottom, both status bar
  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  /// Enable Android 15 compatible edge-to-edge mode
  static void enableEdgeToEdge() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    /// Transparent overlays → Let Flutter draw under them
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
  }
}
