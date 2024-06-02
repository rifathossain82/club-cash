import 'package:club_cash/src/core/helpers/logger.dart';
import 'package:club_cash/src/core/services/permission_manager.dart';
import 'package:club_cash/src/core/services/snack_bar_services.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  var isLoadingContactList = false.obs;
  var contactList = <Contact>[].obs;

  @override
  void onInit(){
    super.onInit();
    getContactList();
  }

  Future<void> getContactList() async {
    try {
      isLoadingContactList(true);
      contactList.value = [];

      if (await PermissionManager.requestContactPermission()) {
        /// Get all contacts without thumbnail (faster)
        contactList.value = await ContactsService.getContacts(
          withThumbnails: false,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isLoadingContactList(false);
    }
  }
}
