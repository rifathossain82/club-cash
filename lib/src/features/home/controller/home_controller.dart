import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_cash/src/core/helpers/logger.dart';
import 'package:club_cash/src/core/services/snack_bar_services.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/features/home/model/transaction_model.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  var isLoadingTransactionList = false.obs;
  var isAddingTransaction = false.obs;
  var isUpdatingTransaction = false.obs;
  var isDeletingTransaction = false.obs;
  var transactionList = <TransactionModel>[].obs;

  final _collection = FirebaseFirestore.instance.collection('transactions');

  @override
  void onInit() {
    super.onInit();
    getTransactionList();
  }

  Future<void> getTransactionList() async {
    try {
      isLoadingTransactionList(true);
      transactionList.value = [];

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _collection
          .orderBy('timestamp', descending: true)
          .get();

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
      getTransactionList();
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
      getTransactionList();
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

      getTransactionList();
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
