import 'package:club_cash/src/core/enums/app_enum.dart';
import 'package:club_cash/src/core/services/local_storage.dart';
import 'package:club_cash/src/features/message_template/model/message_template_model.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final _isEnableSendSMS = false.obs;
  final _selectedMessageTemplate = Rxn<MessageTemplateModel>();

  @override
  void onInit() {
    super.onInit();
    _retrieveSettingsFromLocal();
  }

  bool get isEnableSendSMS => _isEnableSendSMS.value;

  MessageTemplateModel? get selectedMessageTemplate =>
      _selectedMessageTemplate.value;

  void changeSendSMSStatus(bool status) {
    _isEnableSendSMS(status);
    _saveOnLocal();
  }

  void changeMessageTemplate(MessageTemplateModel template) {
    _selectedMessageTemplate.value = template;
    _saveOnLocal();
  }

  void _retrieveSettingsFromLocal() {
    var isEnableSendSMSValue =
        LocalStorage.getData(key: LocalStorageKey.isEnableSendSMS) as bool?;
    if (isEnableSendSMSValue != null) {
      _isEnableSendSMS(isEnableSendSMSValue);
    }

    var messageTemplateJson =
        LocalStorage.getData(key: LocalStorageKey.messageTemplate)
            as Map<String, dynamic>?;
    if (messageTemplateJson != null) {
      _selectedMessageTemplate.value = MessageTemplateModel.fromJson(
        null,
        messageTemplateJson,
      );
    }
  }

  void _saveOnLocal() {
    LocalStorage.saveData(
      key: LocalStorageKey.isEnableSendSMS,
      data: _isEnableSendSMS.value,
    );

    LocalStorage.saveData(
      key: LocalStorageKey.messageTemplate,
      data: _selectedMessageTemplate.value?.toJson(),
    );
  }
}
