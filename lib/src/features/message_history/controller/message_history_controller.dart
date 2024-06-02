import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_cash/src/core/helpers/logger.dart';
import 'package:club_cash/src/core/services/snack_bar_services.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/features/message_history/model/message_history_model.dart';
import 'package:get/get.dart';

class MessageHistoryController extends GetxController {
  var isLoadingHistoryList = false.obs;
  var isAddingHistory = false.obs;
  var historyList = <MessageHistoryModel>[].obs;

  final _collection = FirebaseFirestore.instance.collection('histories');

  @override
  void onInit() {
    super.onInit();
    getHistoryList();
  }

  Future<void> getHistoryList() async {
    try {
      isLoadingHistoryList(true);
      historyList.value = [];

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _collection.orderBy('timestamp', descending: true).get();

      if (querySnapshot.docs.isEmpty) {
        String msg = 'No Histories Found!';
        throw msg;
      } else {
        historyList.value = querySnapshot.docs
            .map((doc) => MessageHistoryModel.fromJson(doc.id, doc.data()))
            .toList();
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isLoadingHistoryList(false);
    }
  }

  Future<void> addHistory({required MessageHistoryModel history}) async {
    try {
      isAddingHistory(true);

      await _collection.add(history.toJson());
      getHistoryList();
      SnackBarService.showSnackBar(
        message: "History added successfully!",
        bgColor: successColor,
      );
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isAddingHistory(false);
    }
  }
}
