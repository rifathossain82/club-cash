import 'package:club_cash/src/core/widgets/failure_widget_builder.dart';
import 'package:club_cash/src/core/widgets/k_custom_loader.dart';
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
      return memberController.isLoadingMemberList.value
          ? const KCustomLoader()
          : memberController.memberList.isEmpty
              ? const FailureWidgetBuilder()
              : _MemberList(
                  isSelectable: isSelectable,
                  memberController: memberController,
                );
    });
  }
}

class _MemberList extends StatelessWidget {
  final bool isSelectable;
  final MemberController memberController;

  const _MemberList({
    required this.isSelectable,
    required this.memberController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: memberController.memberList.length,
      itemBuilder: (context, index) => MemberItemWidget(
        data: memberController.memberList[index],
        isSelectable: isSelectable,
      ),
      separatorBuilder: (context, index) => const Divider(height: 0),
    );
  }
}
