import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/helpers/validators.dart';
import 'package:club_cash/src/core/theme/app_theme.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_button.dart';
import 'package:club_cash/src/core/widgets/k_button_progress_indicator.dart';
import 'package:club_cash/src/core/widgets/k_logo.dart';
import 'package:club_cash/src/core/widgets/k_text_form_field_builder_with_title.dart';
import 'package:club_cash/src/features/auth/controller/auth_controller.dart';
import 'package:club_cash/src/features/auth/view/widgets/create_account_button.dart';
import 'package:club_cash/src/features/auth/view/widgets/forgot_password_button.dart';
import 'package:club_cash/src/features/auth/view/widgets/or_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: context.screenHeight * 0.05,
            ),
            child: const _LoginForm(),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  late final TextEditingController _usernameTextController;
  late final TextEditingController _passwordTextController;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  bool _isPasswordVisible = true;
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    AppTheme.setDarkStatusBar();
    _usernameTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const KLogo(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Welcome Back!\nLog in to access your account and enjoy all the benefits of being a member.',
              textAlign: TextAlign.center,
              style: context.appTextTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 20),
          KTextFormFieldBuilderWithTitle(
            controller: _usernameTextController,
            title: 'Username',
            hintText: 'Enter username',
            validator: Validators.emptyValidator,
            inputType: TextInputType.name,
            inputAction: TextInputAction.next,
            prefixIconData: Icons.person_outline,
          ),
          KTextFormFieldBuilderWithTitle(
            controller: _passwordTextController,
            title: 'Password',
            hintText: 'Enter password',
            validator: Validators.passwordValidator,
            inputType: TextInputType.visiblePassword,
            inputAction: TextInputAction.next,
            prefixIconData: Icons.lock_outline,
            bottomPadding: 0,
            obscureText: _isPasswordVisible,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              child: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: kBlackLight,
              ),
            ),
          ),
          const ForgotPasswordButton(),
          const SizedBox(height: 15),
          KButton(
            onPressed: _onLogin,
            borderRadius: 4,
            child: Obx(() {
              return authController.isLoginLoading.value
                  ? const KButtonProgressIndicator()
                  : Text(
                      'Login'.toUpperCase(),
                      style: context.buttonTextStyle,
                    );
            }),
          ),
          // const OrText(),
          // const CreateAccountButton(),
        ],
      ),
    );
  }

  void _onLogin() {
    if (_loginFormKey.currentState!.validate()) {
      authController.login(
        username: _usernameTextController.text.trim(),
        password: _passwordTextController.text.trim(),
      );
    }
  }
}
