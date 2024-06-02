import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_cash/src/core/helpers/logger.dart';
import 'package:club_cash/src/core/services/permission_manager.dart';
import 'package:club_cash/src/core/services/snack_bar_services.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/features/member/model/member_model.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';

class MemberController extends GetxController {
  var isLoadingMemberList = false.obs;
  var isLoadingContactList = false.obs;
  var isAddingMember = false.obs;
  var isUpdatingMember = false.obs;
  var isDeletingMember = false.obs;
  var memberList = <MemberModel>[].obs;
  var contactList = <MemberModel>[].obs;

  final _memberCollection = FirebaseFirestore.instance.collection('members');

  Future<void> getMemberList() async {
    try {
      isLoadingMemberList(true);
      memberList.value = [];

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _memberCollection.orderBy('timestamp', descending: false).get();

      if (querySnapshot.docs.isEmpty) {
        String msg = 'No Members Found!';
        throw msg;
      } else {
        memberList.value = querySnapshot.docs
            .map((doc) => MemberModel.fromJson(doc.id, doc.data()))
            .toList();
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isLoadingMemberList(false);
    }
  }

  Future<void> getContactList() async {
    try {
      isLoadingContactList(true);
      contactList.value = [];

      if (await PermissionManager.requestContactPermission()) {
        /// Get all contacts without thumbnail (faster)
        List<Contact> contacts = await ContactsService.getContacts(
          withThumbnails: false,
        );

        contactList.value = contacts
            .map((contact) => MemberModel(
                  name: contact.displayName ?? '',
                  phone: contact.phones?.isNotEmpty ?? false
                      ? contact.phones!.first.value
                      : '',
                ))
            .toList();
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

  Future<bool> isDuplicateMember(dynamic phone) async {
    try {
      final querySnapshot =
          await _memberCollection.where('phone', isEqualTo: phone).get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      Log.error('Error checking for duplicate member: $e');
      return false;
    }
  }

  Future<void> addMember({required MemberModel member}) async {
    try {
      isAddingMember(true);

      if (await isDuplicateMember(member.phone)) {
        SnackBarService.showSnackBar(
          message: "Phone number already exists!",
          bgColor: failedColor,
        );
      } else {
        await _memberCollection.add(member.toJson());
        getMemberList();
        SnackBarService.showSnackBar(
          message: "Member added successfully!",
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
      isAddingMember(false);
    }
  }

  Future<void> updateMember({
    required MemberModel member,
  }) async {
    try {
      isUpdatingMember(true);

      if (await isDuplicateMember(member.phone)) {
        SnackBarService.showSnackBar(
          message: "Phone number already exists!",
          bgColor: failedColor,
        );
      } else {
        await _memberCollection.doc(member.id).update(member.toJson());
        getMemberList();
        SnackBarService.showSnackBar(
          message: "Member updated successfully!",
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
      isUpdatingMember(false);
    }
  }

  Future<void> deleteMember(String memberId) async {
    try {
      isDeletingMember(true);

      await _memberCollection.doc(memberId).delete();

      getMemberList();
      SnackBarService.showSnackBar(
        message: "Member deleted successfully!",
        bgColor: successColor,
      );
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isDeletingMember(false);
    }
  }
}
