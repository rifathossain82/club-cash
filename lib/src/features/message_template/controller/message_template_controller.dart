import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_cash/src/core/enums/app_enum.dart';
import 'package:club_cash/src/core/helpers/logger.dart';
import 'package:club_cash/src/core/services/local_storage.dart';
import 'package:club_cash/src/core/services/snack_bar_services.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/features/message_template/model/message_template_model.dart';
import 'package:get/get.dart';

class MessageTemplateController extends GetxController {
  var isLoadingTemplateList = false.obs;
  var isAddingTemplate = false.obs;
  var isUpdatingTemplate = false.obs;
  var isDeletingTemplate = false.obs;
  var templateList = <MessageTemplateModel>[].obs;
  var selectedTemplateId = Rxn<String>();

  final _collection = FirebaseFirestore.instance.collection('templates');

  @override
  void onInit() {
    super.onInit();
    getSelectedTemplateId();
    getTemplateList();
  }

  void getSelectedTemplateId() {
    selectedTemplateId.value = LocalStorage.getData(
      key: LocalStorageKey.messageTemplateId,
    );
  }

  void updateSelectedTemplateId(MessageTemplateModel template) {
    selectedTemplateId.value = template.id!;

    LocalStorage.saveData(
      key: LocalStorageKey.messageTemplateId,
      data: selectedTemplateId.value,
    );
  }

  Future<void> getTemplateList() async {
    try {
      isLoadingTemplateList(true);
      templateList.value = [];

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _collection.orderBy('timestamp', descending: true).get();

      if (querySnapshot.docs.isEmpty) {
        String msg = 'No Templates Found!';
        throw msg;
      } else {
        templateList.value = querySnapshot.docs
            .map((doc) => MessageTemplateModel.fromJson(doc.id, doc.data()))
            .toList();
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isLoadingTemplateList(false);
    }
  }

  Future<void> addTemplate({required MessageTemplateModel template}) async {
    try {
      isAddingTemplate(true);

      await _collection.add(template.toJson());
      getTemplateList();
      SnackBarService.showSnackBar(
        message: "Template added successfully!",
        bgColor: successColor,
      );
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isAddingTemplate(false);
    }
  }

  Future<void> updateTemplate({
    required MessageTemplateModel template,
  }) async {
    try {
      isUpdatingTemplate(true);

      await _collection.doc(template.id).update(template.toJson());
      getTemplateList();
      SnackBarService.showSnackBar(
        message: "Template updated successfully!",
        bgColor: successColor,
      );
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isUpdatingTemplate(false);
    }
  }

  Future<void> deleteTemplate(String templateId) async {
    try {
      isDeletingTemplate(true);

      await _collection.doc(templateId).delete();

      getTemplateList();
      SnackBarService.showSnackBar(
        message: "Template deleted successfully!",
        bgColor: successColor,
      );
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isDeletingTemplate(false);
    }
  }
}
