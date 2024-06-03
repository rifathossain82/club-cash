import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/helpers/validators.dart';
import 'package:club_cash/src/core/widgets/k_button.dart';
import 'package:club_cash/src/core/widgets/k_button_progress_indicator.dart';
import 'package:club_cash/src/core/widgets/k_custom_loader.dart';
import 'package:club_cash/src/core/widgets/k_logo.dart';
import 'package:club_cash/src/core/widgets/k_text_form_field_builder_with_title.dart';
import 'package:club_cash/src/features/auth/controller/auth_controller.dart';
import 'package:club_cash/src/features/auth/view/widgets/custom_back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: const [
            _ForgotPasswordForm(),
            Positioned(
              top: 15,
              left: 15,
              child: CustomBackButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ForgotPasswordForm extends StatefulWidget {
  const _ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<_ForgotPasswordForm> {
  late final TextEditingController _phoneTextController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _phoneTextController = TextEditingController();
    authController.getUserPhoneNumber().then((value){
      _phoneTextController.text = authController.phoneNumber.value.toString();
    });
  }

  @override
  void dispose() {
    _phoneTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return authController.isLoadingUserPhoneNumber.value
          ? const KCustomLoader()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: context.screenHeight * 0.05,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const KLogo(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Forgot Your Password?\nNo worries! Verify your phone number with an OTP to reset your password and regain access to your account.',
                          textAlign: TextAlign.center,
                          style: context.appTextTheme.bodySmall,
                        ),
                      ),
                      const SizedBox(height: 20),
                      KTextFormFieldBuilderWithTitle(
                        controller: _phoneTextController,
                        title: 'Phone Number',
                        hintText: '+880 1*********',
                        validator: Validators.phoneNumberValidator,
                        inputType: TextInputType.phone,
                        inputAction: TextInputAction.done,
                        prefixIconData: Icons.phone,
                        readOnly: true,
                      ),
                      const SizedBox(height: 15),
                      KButton(
                        onPressed: _onVerifyPhoneNumber,
                        borderRadius: 4,
                        child: authController.isVerificationLoading.value
                            ? const KButtonProgressIndicator()
                            : Text(
                                'verify'.toUpperCase(),
                                style: context.buttonTextStyle,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
    });
  }

  void _onVerifyPhoneNumber() {
    if (_formKey.currentState!.validate()) {
      authController.verifyPhoneNumber(
        phoneNumber: _phoneTextController.text.trim(),
      );
    }
  }
}
