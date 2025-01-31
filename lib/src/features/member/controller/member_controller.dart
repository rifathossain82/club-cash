import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_cash/src/core/helpers/logger.dart';
import 'package:club_cash/src/core/services/snack_bar_services.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/features/member/model/member_model.dart';
import 'package:get/get.dart';

class MemberController extends GetxController {
  var isLoadingMemberList = false.obs;
  var isAddingMember = false.obs;
  var isUpdatingMember = false.obs;
  var isDeletingMember = false.obs;
  var memberList = <MemberModel>[].obs;

  final _memberCollection = FirebaseFirestore.instance.collection('members');

  Future<void> getMemberList({String? text}) async {
    try {
      isLoadingMemberList(true);
      memberList.clear();

      Query<Map<String, dynamic>> query = _memberCollection;

      if (text != null && text.isNotEmpty) {
        query = query.where(
          "nameSubstrings",
          arrayContains: text.toLowerCase(),
        );
      } else {
        query = _memberCollection.orderBy(
          'timestamp',
          descending: false,
        );
      }

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();

      memberList.value = querySnapshot.docs
          .map((doc) => MemberModel.fromJson(doc.id, doc.data()))
          .toList();
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

  Future<List<String>> getMemberPhoneNumbers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _memberCollection.orderBy('timestamp', descending: false).get();

      return querySnapshot.docs
          .map((doc) => doc.data()['phone'].toString())
          .toList();
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);
      return [];
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
        throw "Phone number already exists!";
      }

      await _memberCollection.add(member.toJson());
      getMemberList();
      SnackBarService.showSnackBar(
        message: "Member added successfully!",
        bgColor: successColor,
      );
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
    required String? oldPhoneNumber,
    required MemberModel member,
  }) async {
    try {
      isUpdatingMember(true);

      if (oldPhoneNumber != member.phone) {
        if (await isDuplicateMember(member.phone)) {
          throw "Phone number already exists!";
        }
      }

      await _memberCollection.doc(member.id).update(member.toJson());
      getMemberList();
      SnackBarService.showSnackBar(
        message: "Member updated successfully!",
        bgColor: successColor,
      );
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
