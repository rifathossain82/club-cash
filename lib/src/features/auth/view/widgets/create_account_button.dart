import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/routes/routes.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressedCreateAccount,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "No Account? ",
              style: context.appTextTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: kBlackLight,
              ),
            ),
            TextSpan(
              text: "Create One",
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
    Get.offAndToNamed(RouteGenerator.register);
  }
}
