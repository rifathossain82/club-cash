import 'package:club_cash/src/core/widgets/k_custom_loader.dart';
import 'package:club_cash/src/core/widgets/title_text_widget.dart';
import 'package:club_cash/src/features/member/controller/member_controller.dart';
import 'package:club_cash/src/features/member/view/widgets/member_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberListWidget extends StatelessWidget {
  final bool isSelectable;

  const MemberListWidget({
    super.key,
    required this.isSelectable,
  });

  @override
  Widget build(BuildContext context) {
    final memberController = Get.find<MemberController>();
    return Obx(() {
      return memberController.isLoadingMemberList.value ||
              memberController.isLoadingContactList.value
          ? const KCustomLoader()
          : _AddedMemberList(
              isSelectable: isSelectable,
            );
    });
  }
}

class _AddedMemberList extends StatelessWidget {
  final bool isSelectable;

  const _AddedMemberList({
    required this.isSelectable,
  });

  @override
  Widget build(BuildContext context) {
    final memberController = Get.find<MemberController>();
    return Obx(() {
      return memberController.memberList.isEmpty
          ? const SizedBox.shrink()
          : ListView(
              children: [
                const TitleTextWidget(title: "Added Members : "),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: memberController.memberList.length,
                  itemBuilder: (context, index) => MemberItemWidget(
                    data: memberController.memberList[index],
                    isSelectable: isSelectable,
                    isEditable: true,
                  ),
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0),
                ),
              ],
            );
    });
  }
}
