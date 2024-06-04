import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_cash/src/core/enums/app_enum.dart';
import 'package:club_cash/src/core/helpers/logger.dart';
import 'package:club_cash/src/core/routes/routes.dart';
import 'package:club_cash/src/core/services/local_storage.dart';
import 'package:club_cash/src/core/services/snack_bar_services.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/features/auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoadingUserPhoneNumber = false.obs;
  var isResetPasswordLoading = false.obs;
  var isChangePasswordLoading = false.obs;
  var isLoginLoading = false.obs;
  var isLogoutLoading = false.obs;
  var isVerificationLoading = false.obs;
  var verificationId = Rxn<String>();
  var user = Rxn<UserModel>();

  final _collection = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> getUserPhoneNumber() async {
    try {
      isLoadingUserPhoneNumber(true);
      user.value = null;

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _collection
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> userJson = querySnapshot.docs.first.data();
        String userId = querySnapshot.docs.first.id;
        user.value = UserModel.fromJson(userId, userJson);
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isLoadingUserPhoneNumber(false);
    }
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      isLoginLoading(true);

      /// Check if a user with the provided username exists
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _collection
          .where('username', isEqualTo: username)
          .where("password", isEqualTo: password)
          .limit(1)
          .get();

      /// If no user found with the provided username, return false
      if (querySnapshot.docs.isEmpty) {
        String msg = 'Log in Failed!';
        throw msg;
      } else {
        String userId = querySnapshot.docs.first.id;
        LocalStorage.saveData(key: LocalStorageKey.userId, data: userId);

        Get.offAllNamed(RouteGenerator.home);

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

  Future<void> logout() async {
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

  Future<void> verifyPhoneNumber({required String phoneNumber}) async {
    try {
      isVerificationLoading(true);

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          SnackBarService.showSnackBar(
            message: "Phone number automatically verified and user signed in!",
            bgColor: successColor,
          );

          isVerificationLoading(false);
        },
        verificationFailed: (FirebaseAuthException e) {
          Log.error('Verification failed: ${e.message}');
          SnackBarService.showSnackBar(
            message: "Verification failed. Please try again.",
            bgColor: failedColor,
          );
          isVerificationLoading(false);
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
          SnackBarService.showSnackBar(
            message: "OTP sent to your phone number.",
            bgColor: successColor,
          );
          Get.toNamed(
            RouteGenerator.otpVerification,
            arguments: phoneNumber,
          );

          isVerificationLoading(false);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
          Log.warning(
            "Code auto-retrieval timeout for verificationId: $verificationId",
          );
        },
      );
    } catch (e, stackTrace) {
      Log.error("Error during phone verification: $e", stackTrace: stackTrace);
      SnackBarService.showSnackBar(
        message: "An error occurred. Please try again.",
        bgColor: failedColor,
      );

      isVerificationLoading(false);
    }
  }

  Future<void> signInWithOTP({required String otp}) async {
    try {
      isVerificationLoading(true);

      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value!,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);

      SnackBarService.showSnackBar(
        message: "Phone number verified successfully!",
        bgColor: successColor,
      );

      Get.toNamed(RouteGenerator.resetPassword);
    } catch (e, stackTrace) {
      Log.error("Failed to sign in with OTP: $e", stackTrace: stackTrace);
      SnackBarService.showSnackBar(
        message: "Failed to verify OTP. Please try again.",
        bgColor: failedColor,
      );
    } finally {
      isVerificationLoading(false);
    }
  }

  Future<void> resetPassword({
    required String newPassword,
  }) async {
    try {
      isResetPasswordLoading(true);

      /// Since user fetch before password reset, so we have user id.
      await _collection.doc(user.value?.id).update({'password': newPassword});

      SnackBarService.showSnackBar(
        message: 'Password reset successfully!',
        bgColor: successColor,
      );

      Get.offAllNamed(RouteGenerator.login);
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: 'Failed to reset password. Please try again.',
        bgColor: failedColor,
      );
    } finally{
      isResetPasswordLoading(false);
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      isChangePasswordLoading(true);

      /// Since, user change his password from settings,
      /// so he/she has id in local (since we store it after login)
      String userId = LocalStorage.getData(key: LocalStorageKey.userId);

      DocumentSnapshot<Map<String, dynamic>> userDoc = await _collection.doc(userId).get();

      /// Check if the old password matches
      if (userDoc.exists && userDoc.data()!['password'] == oldPassword) {
        await _collection.doc(userId).update({'password': newPassword});

        SnackBarService.showSnackBar(
          message: 'Password changed successfully!',
          bgColor: successColor,
        );

        Get.offAllNamed(RouteGenerator.login);
      } else {
        throw 'Old password does not match.';
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isChangePasswordLoading(false);
    }
  }
}
