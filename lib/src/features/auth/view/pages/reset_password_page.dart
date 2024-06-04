import 'package:club_cash/src/core/errors/messages.dart';
import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/helpers/validators.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_button.dart';
import 'package:club_cash/src/core/widgets/k_button_progress_indicator.dart';
import 'package:club_cash/src/core/widgets/k_logo.dart';
import 'package:club_cash/src/core/widgets/k_text_form_field_builder_with_title.dart';
import 'package:club_cash/src/features/auth/controller/auth_controller.dart';
import 'package:club_cash/src/features/auth/view/widgets/custom_back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: const [
            _ResetPasswordForm(),
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

class _ResetPasswordForm extends StatefulWidget {
  const _ResetPasswordForm({Key? key}) : super(key: key);

  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<_ResetPasswordForm> {
  final authController = Get.find<AuthController>();
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isNewPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  'Reset Your Password\nTo reset your password, simply enter a new password and confirm it.',
                  textAlign: TextAlign.center,
                  style: context.appTextTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 20),
              _buildPasswordField(
                controller: _newPasswordController,
                title: 'New Password',
                visible: _isNewPasswordVisible,
              ),
              _buildPasswordField(
                controller: _confirmPasswordController,
                title: 'Confirm Password',
                visible: _isConfirmPasswordVisible,
              ),
              const SizedBox(height: 10),
              Obx(() {
                return KButton(
                  onPressed: _onResetPassword,
                  borderRadius: 4,
                  child: authController.isResetPasswordLoading.value
                      ? const KButtonProgressIndicator()
                      : Text(
                          'Reset'.toUpperCase(),
                          style: context.buttonTextStyle,
                        ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String title,
    required bool visible,
  }) {
    String hintText = 'Enter $title';
    TextInputType inputType = TextInputType.visiblePassword;
    TextInputAction inputAction = TextInputAction.next;
    String? Function(dynamic value)? validator = Validators.passwordValidator;

    if (controller == _confirmPasswordController) {
      inputAction = TextInputAction.done;
      validator = _getConfirmPasswordValidator();
    }

    return KTextFormFieldBuilderWithTitle(
      controller: controller,
      title: title,
      hintText: hintText,
      validator: validator,
      inputType: inputType,
      inputAction: inputAction,
      prefixIconData: Icons.lock_outline,
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            if (controller == _newPasswordController) {
              _isNewPasswordVisible = !_isNewPasswordVisible;
            } else {
              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
            }
          });
        },
        child: Icon(
          visible ? Icons.visibility_off : Icons.visibility,
          color: kBlackLight,
        ),
      ),
    );
  }

  String? Function(dynamic value) _getConfirmPasswordValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return Message.emptyPassword;
      } else if (value.length < 6) {
        return Message.invalidPassword;
      } else if (value != _newPasswordController.text) {
        return Message.doNotMatchPasswords;
      }
      return null;
    };
  }

  void _onResetPassword() {
    if (_formKey.currentState!.validate()) {
      authController.resetPassword(
        newPassword: _newPasswordController.text.trim(),
      );
    }
  }
}
