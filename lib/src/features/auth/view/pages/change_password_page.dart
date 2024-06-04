import 'package:club_cash/src/core/errors/messages.dart';
import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/helpers/validators.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_button.dart';
import 'package:club_cash/src/core/widgets/k_button_progress_indicator.dart';
import 'package:club_cash/src/core/widgets/k_logo.dart';
import 'package:club_cash/src/core/widgets/k_text_form_field_builder_with_title.dart';
import 'package:club_cash/src/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: const _ChangePasswordForm(),
    );
  }
}

class _ChangePasswordForm extends StatefulWidget {
  const _ChangePasswordForm({Key? key}) : super(key: key);

  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<_ChangePasswordForm> {
  final authController = Get.find<AuthController>();
  late final TextEditingController _oldPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isOldPasswordVisible = true;
  bool _isNewPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
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
          vertical: context.screenHeight * 0.03,
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
                  'Update your account password to keep your information secure.',
                  textAlign: TextAlign.center,
                  style: context.appTextTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 20),
              _buildPasswordField(
                controller: _oldPasswordController,
                title: 'Old Password',
                visible: _isOldPasswordVisible,
              ),
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
                  onPressed: _onChangePassword,
                  borderRadius: 4,
                  child: authController.isChangePasswordLoading.value
                      ? const KButtonProgressIndicator()
                      : Text(
                          'Change'.toUpperCase(),
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
            if (controller == _oldPasswordController) {
              _isOldPasswordVisible = !_isOldPasswordVisible;
            } else if (controller == _newPasswordController) {
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

  void _onChangePassword() {
    if (_formKey.currentState!.validate()) {
      authController.changePassword(
        oldPassword: _oldPasswordController.text.trim(),
        newPassword: _newPasswordController.text.trim(),
      );
    }
  }
}
