import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_cash/src/core/helpers/helper_methods.dart';
import 'package:club_cash/src/core/helpers/logger.dart';
import 'package:club_cash/src/core/services/permission_manager.dart';
import 'package:club_cash/src/core/services/snack_bar_services.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/features/home/model/transaction_model.dart';
import 'package:club_cash/src/features/member/controller/member_controller.dart';
import 'package:club_cash/src/features/settings/controller/settings_controller.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  var isLoadingSummary = false.obs;
  var isLoadingTransactionList = false.obs;
  var isAddingTransaction = false.obs;
  var isUpdatingTransaction = false.obs;
  var isDeletingTransaction = false.obs;
  var transactionList = <TransactionModel>[].obs;
  var netBalance = 0.0.obs;
  var totalCashIn = 0.0.obs;
  var totalCashOut = 0.0.obs;

  final _collection = FirebaseFirestore.instance.collection('transactions');

  @override
  void onInit() {
    super.onInit();
    reload();
  }

  Future<void> reload() async {
    await Future.wait([
      getTransactionSummary(),
      getTransactionList(),
    ]);
  }

  Future<void> _sendConfirmationSMS({required num transactionAmount}) async {
    final List<String> phoneNumbers =
        await Get.find<MemberController>().getMemberPhoneNumbers();
    final settingsController = Get.find<SettingsController>();

    if (settingsController.isEnableSendSMS) {
      /// Generate message:
      String message = generateMessage(
        message: settingsController.selectedMessageTemplate?.message ?? '',
        amount: transactionAmount,
        netBalance: netBalance.value,
      );

      /// To Send SMS:
      _send(
        message: message,
        phoneNumbers: phoneNumbers,
      );
    }
  }

  void _send({
    required String message,
    required List<String> phoneNumbers,
  }) async {
    /// To send sms.
    try {
      if (await PermissionManager.requestSmsPermission()) {
        await sendSMS(
          message: message,
          recipients: phoneNumbers,
          sendDirect: true,
        );

        Log.debug("Send Confirmation SMS Successfully!");
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);
    }
  }

  Future<void> getTransactionSummary() async {
    isLoadingSummary(true);
    try {
      /// Fetch cashIn transactions
      QuerySnapshot<Map<String, dynamic>> cashInSnapshot =
          await _collection.where("type", isEqualTo: "cashIn").get();

      double sumOfCashIn = cashInSnapshot.docs
          .map((doc) => doc.data()['amount'] as num)
          .fold(0, (prev, amount) => prev + amount);

      /// Fetch cashOut transactions
      QuerySnapshot<Map<String, dynamic>> cashOutSnapshot =
          await _collection.where("type", isEqualTo: "cashOut").get();

      double sumOfCashOut = cashOutSnapshot.docs
          .map((doc) => doc.data()['amount'] as num)
          .fold(0, (prev, amount) => prev + amount);

      netBalance.value = sumOfCashIn - sumOfCashOut;
      totalCashIn.value = sumOfCashIn;
      totalCashOut.value = sumOfCashOut;
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isLoadingSummary(false);
    }
  }

  Future<void> getTransactionList() async {
    try {
      isLoadingTransactionList(true);
      transactionList.value = [];

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _collection.orderBy('timestamp', descending: true).get();

      if (querySnapshot.docs.isEmpty) {
        String msg = 'No Transactions Found!';
        throw msg;
      } else {
        transactionList.value = querySnapshot.docs
            .map((doc) => TransactionModel.fromJson(doc.id, doc.data()))
            .toList();
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isLoadingTransactionList(false);
    }
  }

  Future<void> addTransaction({required TransactionModel transaction}) async {
    try {
      isAddingTransaction(true);

      await _collection.add(transaction.toJson());
      await reload();
      await _sendConfirmationSMS(transactionAmount: transaction.amount ?? 0);

      SnackBarService.showSnackBar(
        message: "Transaction added successfully!",
        bgColor: successColor,
      );
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isAddingTransaction(false);
    }
  }

  Future<void> updateTransaction({
    required TransactionModel transaction,
  }) async {
    try {
      isUpdatingTransaction(true);

      await _collection.doc(transaction.id).update(transaction.toJson());
      reload();

      SnackBarService.showSnackBar(
        message: "Transaction updated successfully!",
        bgColor: successColor,
      );
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isUpdatingTransaction(false);
    }
  }

  Future<void> deleteTransaction(String transactionId) async {
    try {
      isDeletingTransaction(true);

      await _collection.doc(transactionId).delete();

      reload();
      SnackBarService.showSnackBar(
        message: "Transaction deleted successfully!",
        bgColor: successColor,
      );
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isDeletingTransaction(false);
    }
  }
}
