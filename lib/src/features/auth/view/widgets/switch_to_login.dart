import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/routes/routes.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwitchToLoginButton extends StatelessWidget {
  const SwitchToLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressedCreateAccount,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Already have an account? ",
              style: context.appTextTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: kBlackLight,
              ),
            ),
            TextSpan(
              text: "Log in",
              style: context.appTextTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedCreateAccount(){
    Get.offAndToNamed(RouteGenerator.login);
  }
}
