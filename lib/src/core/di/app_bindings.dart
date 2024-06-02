import 'package:club_cash/src/features/auth/controller/auth_controller.dart';
import 'package:club_cash/src/features/contact/controller/contact_controller.dart';
import 'package:club_cash/src/features/home/controller/home_controller.dart';
import 'package:club_cash/src/features/member/controller/member_controller.dart';
import 'package:club_cash/src/features/message_template/controller/message_template_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => MemberController(), fenix: true);
    Get.lazyPut(() => ContactController(), fenix: true);
    Get.lazyPut(() => TransactionController(), fenix: true);
    Get.lazyPut(() => MessageTemplateController(), fenix: true);
  }
}
