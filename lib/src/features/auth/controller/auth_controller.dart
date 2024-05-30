import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_cash/src/core/enums/app_enum.dart';
import 'package:club_cash/src/core/helpers/logger.dart';
import 'package:club_cash/src/core/routes/routes.dart';
import 'package:club_cash/src/core/services/local_storage.dart';
import 'package:club_cash/src/core/services/snack_bar_services.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoginLoading = false.obs;
  var isVerifyOTPLoading = false.obs;
  var isLogoutLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      isLoginLoading(true);

      // Check if a user with the provided username exists
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .where("password", isEqualTo: password)
          .limit(1)
          .get();

      // If no user found with the provided username, return false
      if (querySnapshot.docs.isEmpty) {
        String msg = 'Log in Failed!';
        throw msg;
      } else {
        String userId = querySnapshot.docs.first.id;
        LocalStorage.saveData(key: LocalStorageKey.userId, data: userId);

        Get.offAllNamed(RouteGenerator.home);

        /// show success message
        SnackBarService.showSnackBar(
          message: "Logged in successfully!",
          bgColor: successColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isLoginLoading(false);
    }
  }

  Future logout() async {
    try {
      isLogoutLoading(true);

      /// clear all cache data from local storage
      LocalStorage.removeAllData();

      Get.offAllNamed(RouteGenerator.login);

      /// show success message
      SnackBarService.showSnackBar(
        message: 'Logout Successfully!',
        bgColor: successColor,
      );
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isLogoutLoading(false);
    }
  }
}
