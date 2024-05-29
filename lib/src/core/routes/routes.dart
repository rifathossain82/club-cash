import 'package:club_cash/src/features/auth/view/pages/login_page.dart';
import 'package:club_cash/src/features/auth/view/pages/register_page.dart';
import 'package:club_cash/src/features/home/view/pages/cash_in_transaction_add_update_page.dart';
import 'package:club_cash/src/features/home/view/pages/cash_out_transaction_add_update_page.dart';
import 'package:club_cash/src/features/home/view/pages/homepage.dart';
import 'package:club_cash/src/features/member/view/pages/member_list_page.dart';
import 'package:club_cash/src/features/message_history/view/pages/message_history_page.dart';
import 'package:club_cash/src/features/message_template/view/pages/message_template_page.dart';
import 'package:club_cash/src/features/splash/view/pages/splash_page.dart';
import 'package:get/get.dart';

class RouteGenerator {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String cashInTransactionAddUpdate = '/cash-in-transaction-add-update';
  static const String cashOutTransactionAddUpdate = '/cash-out-transaction-add-update';
  static const String memberListPage = '/member-list-page';
  static const String messageTemplate = '/message-template';
  static const String messageHistory = '/message-history';

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
      name: RouteGenerator.register,
      page: () => const RegisterPage(),
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
        isSelectable: Get.arguments as bool,
      ),
    ),
    GetPage(
      name: RouteGenerator.messageTemplate,
      page: () => const MessageTemplatePage(),
    ),
    GetPage(
      name: RouteGenerator.messageHistory,
      page: () => const MessageHistoryPage(),
    ),
  ];
}
