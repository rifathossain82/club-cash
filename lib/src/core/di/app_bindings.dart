import 'package:club_cash/src/features/auth/controller/auth_controller.dart';
import 'package:club_cash/src/features/member/controller/member_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => MemberController(), fenix: true);
  }
}
