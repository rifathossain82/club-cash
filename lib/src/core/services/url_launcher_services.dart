import 'package:club_cash/src/core/helpers/logger.dart';
import 'package:club_cash/src/core/services/snack_bar_services.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherServices {
  static void sendWhatsappMessage({
    required String phoneNumber,
    required String message,
  }) async {
    Uri uri = Uri.parse(
      "whatsapp://send?phone=+88$phoneNumber&text=${Uri.encodeFull(message)}",
    );

    _launchUri(uri);
  }

  static void makeCall({required String phoneNumber}) async {
    final String url = 'tel:$phoneNumber';
    Uri uri = Uri.parse(url);

    _launchUri(uri);
  }

  static void sendEmail({
    required String email,
    required String message,
  }) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Invoice%20&body=${Uri.encodeFull(message)}%20',
    );

    _launchUri(params);
  }

  static void _launchUri(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
    try {} catch (e) {
      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    }
  }

  static void openSite({
    required String siteURL,
    LaunchMode launchMode = LaunchMode.inAppWebView,
  }) async {
    try {
      final Uri uri = Uri.parse(siteURL);

      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: launchMode,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    }
  }
}
