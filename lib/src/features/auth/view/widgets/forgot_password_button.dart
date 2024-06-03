import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/routes/routes.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: _onPressed,
        child: Text(
          'Forgot Password?',
          style: context.appTextTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: kBlackLight,
          ),
        ),
      ),
    );
  }

  void _onPressed(){
    Get.toNamed(RouteGenerator.forgotPassword);
  }
}
