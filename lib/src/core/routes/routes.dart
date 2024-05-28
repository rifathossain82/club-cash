import 'package:club_cash/src/features/home/view/pages/homepage.dart';
import 'package:club_cash/src/features/home/view/pages/transaction_add_update_page.dart';
import 'package:club_cash/src/features/member/view/pages/member_list_page.dart';
import 'package:club_cash/src/features/splash/view/pages/splash_page.dart';
import 'package:get/get.dart';

class RouteGenerator {
  static const String splash = '/';
  static const String home = '/home';
  static const String transactionAddUpdate = '/transaction-add-update';
  static const String memberListPage = '/member-list-page';

  // static const String locationList = '/location-list-page';
  // static const String networkInfo = '/network-info';
  // static const String speedTester = '/speed-tester';
  // static const String aboutUs = '/about-us';
  // static const String share = '/share';
  // static const String contactUs = '/contact-us';
  // static const String privacyPolicy = '/privacy-policy';
  // static const String termsAndConditions = '/terms-and-conditions';
  // static const String prayerTimes = '/prayer-times';
  // static const String noInternet = '/no-internet';

  static final routes = [
    GetPage(
      name: RouteGenerator.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: RouteGenerator.home,
      page: () => const Homepage(),
    ),
    GetPage(
      name: RouteGenerator.transactionAddUpdate,
      page: () => TransactionAddUpdatePage(
        arguments: Get.arguments as TransactionAddUpdatePageArguments,
      ),
    ),
    GetPage(
      name: RouteGenerator.memberListPage,
      page: () => MemberListPage(
        isSelectable: Get.arguments as bool,
      ),
    ),
    // GetPage(
    //   name: RouteGenerator.networkInfo,
    //   page: () => const NetworkInfoPage(),
    // ),
    // GetPage(
    //   name: RouteGenerator.speedTester,
    //   page: () => const SpeedTesterPage(),
    // ),
    // GetPage(
    //   name: RouteGenerator.aboutUs,
    //   page: () => const AboutPage(),
    // ),
    // GetPage(
    //   name: RouteGenerator.share,
    //   page: () => const SharePage(),
    // ),
    // GetPage(
    //   name: RouteGenerator.contactUs,
    //   page: () => const ContactUsPage(),
    // ),
    // GetPage(
    //   name: RouteGenerator.privacyPolicy,
    //   page: () => const PrivacyPolicyPage(),
    // ),
    // GetPage(
    //   name: RouteGenerator.termsAndConditions,
    //   page: () => const TermsAndConditionsPage(),
    // ),
    // GetPage(
    //   name: RouteGenerator.prayerTimes,
    //   page: () => const PrayerTimesPage(),
    // ),
    // GetPage(
    //   name: RouteGenerator.noInternet,
    //   page: () => const NoInternetPage(),
    // ),
  ];
}
