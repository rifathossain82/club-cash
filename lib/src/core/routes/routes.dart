import 'package:club_cash/src/features/auth/view/pages/change_password_page.dart';
import 'package:club_cash/src/features/auth/view/pages/forgot_password_page.dart';
import 'package:club_cash/src/features/auth/view/pages/login_page.dart';
import 'package:club_cash/src/features/auth/view/pages/otp_verification_page.dart';
import 'package:club_cash/src/features/auth/view/pages/reset_password_page.dart';
import 'package:club_cash/src/features/contact/view/pages/selectable_contact_list_page.dart';
import 'package:club_cash/src/features/home/view/pages/cash_in_transaction_add_update_page.dart';
import 'package:club_cash/src/features/home/view/pages/cash_out_transaction_add_update_page.dart';
import 'package:club_cash/src/features/home/view/pages/homepage.dart';
import 'package:club_cash/src/features/member/view/pages/member_list_page.dart';
import 'package:club_cash/src/features/message_history/view/pages/message_history_page.dart';
import 'package:club_cash/src/features/message_template/view/pages/message_template_page.dart';
import 'package:club_cash/src/features/settings/view/pages/settings_page.dart';
import 'package:club_cash/src/features/splash/view/pages/splash_page.dart';
import 'package:get/get.dart';

class RouteGenerator {
  static const String splash = '/';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification = '/otp-verification';
  static const String resetPassword = '/reset-password';
  static const String home = '/home';
  static const String cashInTransactionAddUpdate =
      '/cash-in-transaction-add-update';
  static const String cashOutTransactionAddUpdate =
      '/cash-out-transaction-add-update';
  static const String memberListPage = '/member-list-page';
  static const String messageTemplate = '/message-template';
  static const String messageHistory = '/message-history';
  static const String selectableContactList = '/selectable-contact-list';
  static const String settings = '/settings';
  static const String changePassword = '/changePassword';

  static final routes = [
    GetPage(
      name: RouteGenerator.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: RouteGenerator.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: RouteGenerator.forgotPassword,
      page: () => const ForgotPasswordPage(),
    ),
    GetPage(
      name: RouteGenerator.otpVerification,
      page: () => VerifyOTPPage(phone: Get.arguments as String),
    ),
    GetPage(
      name: RouteGenerator.resetPassword,
      page: () => const ResetPasswordPage(),
    ),
    GetPage(
      name: RouteGenerator.home,
      page: () => const Homepage(),
    ),
    GetPage(
      name: RouteGenerator.cashInTransactionAddUpdate,
      page: () => CashInTransactionAddUpdatePage(
        arguments: Get.arguments as CashInTransactionAddUpdatePageArguments,
      ),
    ),
    GetPage(
      name: RouteGenerator.cashOutTransactionAddUpdate,
      page: () => CashOutTransactionAddUpdatePage(
        arguments: Get.arguments as CashOutTransactionAddUpdatePageArguments,
      ),
    ),
    GetPage(
      name: RouteGenerator.memberListPage,
      page: () => MemberListPage(
        argument: Get.arguments as MemberListPageArgument,
      ),
    ),
    GetPage(
      name: RouteGenerator.messageTemplate,
      page: () => MessageTemplatePage(
        argument: Get.arguments as MessageTemplateArgument,
      ),
    ),
    GetPage(
      name: RouteGenerator.messageHistory,
      page: () => const MessageHistoryPage(),
    ),
    GetPage(
      name: RouteGenerator.selectableContactList,
      page: () => const SelectableContactListPage(),
    ),
    GetPage(
      name: RouteGenerator.settings,
      page: () => const SettingsPage(),
    ),
    GetPage(
      name: RouteGenerator.changePassword,
      page: () => const ChangePasswordPage(),
    ),
  ];
}
