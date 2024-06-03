import 'package:club_cash/src/core/errors/messages.dart';
import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/widgets/k_button.dart';
import 'package:club_cash/src/core/widgets/k_button_progress_indicator.dart';
import 'package:club_cash/src/core/widgets/k_logo.dart';
import 'package:club_cash/src/features/auth/controller/auth_controller.dart';
import 'package:club_cash/src/features/auth/view/widgets/custom_back_button_widget.dart';
import 'package:club_cash/src/features/auth/view/widgets/pin_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyOTPPage extends StatefulWidget {
  final String phone;

  const VerifyOTPPage({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  final authController = Get.find<AuthController>();

  final pinTextController = TextEditingController();
  final verifyOTPFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _verifyOTPPageBody(),
            const Positioned(
              top: 15,
              left: 15,
              child: CustomBackButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _verifyOTPPageBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(
          left: 15,
          right: 15,
          top: context.screenHeight * 0.08,
          bottom: context.screenHeight * 0.03,
        ),
        child: Form(
          key: verifyOTPFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// logo and welcome text
              const KLogo(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Text(
                  'We have just sent a 6 digit OTP code to your mobile number (${widget.phone})',
                  textAlign: TextAlign.center,
                  style: context.appTextTheme.bodySmall,
                ),
              ),

              /// phone textField
              _buildPinTextFiled(),

              /// verify otp button
              KButton(
                height: 45,
                onPressed: _verifyOTPMethod,
                child: Obx(() {
                  return authController.isVerificationLoading.value
                      ? const KButtonProgressIndicator()
                      : Text(
                    'Verify OTP',
                    style: context.buttonTextStyle,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinTextFiled() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: PinFieldWidget(
        labelText: 'Pin',
        fieldController: pinTextController,
        icon: Icons.visibility,
        keyType: TextInputType.number,
        validation: (value) {
          if (value!.isEmpty) {
            return Message.emptyOTP;
          } else if (value.toString().length < 6) {
            return Message.invalidOTP;
          }
          return null;
        },
      ),
    );
  }

  void _verifyOTPMethod() {
    if (verifyOTPFormKey.currentState!.validate()) {
      authController.signInWithOTP(
        otp: pinTextController.text.trim(),
      );
    }
  }
}
