import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_button.dart';
import 'package:club_cash/src/core/widgets/k_outlined_button.dart';
import 'package:flutter/material.dart';

class DialogService {
  static Future<bool?> confirmationDialog({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String negativeActionText,
    required String positiveActionText,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          title: Text(
            title,
            style: context.appTextTheme.titleLarge,
          ),
          content: Text(
            subtitle,
            style: context.appTextTheme.bodySmall,
          ),
          titlePadding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 15,
          ),
          contentPadding: const EdgeInsets.all(15),
          actionsPadding: const EdgeInsets.all(15.0),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: KOutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    borderColor: kPrimaryColor,
                    borderRadius: 4,
                    child: Text(
                      negativeActionText,
                      style: context.outlinedButtonTextStyle,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: KButton(
                    onPressed: () => Navigator.pop(context, true),
                    bgColor: kPrimaryColor,
                    borderRadius: 4,
                    child: Text(
                      positiveActionText,
                      style: context.buttonTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static Future<bool?> customDialog({
    required BuildContext context,
    required String title,
    required AlignmentGeometry dialogPosition,
    List<Widget>? actions,
    Widget? content,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: content,
            ),
            insetPadding: const EdgeInsets.all(15),
            alignment: dialogPosition,
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: context.appTextTheme.titleMedium,
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: actions,
          );
        });
  }

  static Future<bool?> loadingDialog({
    required BuildContext context,
    required AlignmentGeometry dialogPosition,
    required Widget content,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                child: content,
              ),
            ],
          ),
          insetPadding: const EdgeInsets.all(15),
          alignment: dialogPosition,
        );
      },
    );
  }
}
