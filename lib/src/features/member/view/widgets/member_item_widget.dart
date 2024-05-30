import 'dart:math';

import 'package:club_cash/src/core/enums/app_enum.dart';
import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/extensions/string_extension.dart';
import 'package:club_cash/src/core/services/dialog_service.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/popup_menu_item_builder.dart';
import 'package:club_cash/src/features/member/controller/member_controller.dart';
import 'package:club_cash/src/features/member/model/member_model.dart';
import 'package:club_cash/src/features/member/view/widgets/member_add_update_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberItemWidget extends StatelessWidget {
  final MemberModel data;
  final bool isSelectable;
  final bool isEditable;

  const MemberItemWidget({
    Key? key,
    required this.data,
    required this.isSelectable,
    required this.isEditable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = Random().nextInt(randomColors.length);
    return GestureDetector(
      onTap: () async {
        if (isSelectable && isEditable) {
          Navigator.pop(context, data);
        } if (isEditable == false) {
          await memberAddUpdateBottomSheet(
            formStatus: FormStatus.add,
            context: context,
            existingMember: data,
          );
        }
      },
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        leading: Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: randomColors[index],
          ),
          child: Text(
            (data.name ?? '').substring(0, 1).toUpperCase(),
            style: context.appTextTheme.titleMedium?.copyWith(
              color: kWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          data.name ?? '',
          style: context.appTextTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: kBlackLight,
          ),
        ),
        subtitle: Text(
          data.phone ?? '',
          style: context.appTextTheme.bodySmall?.copyWith(
            color: kGreyTextColor,
          ),
        ),
        trailing: isEditable
            ? PopupMenuButton(
                color: kWhite,
                onSelected: (value) {
                  if (value == PopupMenuItemOptions.edit) {
                    _onUpdateMember(context);
                  } else {
                    _onDeleteMember(context);
                  }
                },
                icon: Icon(
                  Icons.more_vert_outlined,
                  color: kGrey,
                  size: 20,
                ),
                itemBuilder: (BuildContext context) => [
                  popupMenuItemBuilder(
                    value: PopupMenuItemOptions.edit,
                    icon: Icons.edit_outlined,
                    iconColor: kGrey,
                    title: PopupMenuItemOptions.edit.name.capitalizedFirst,
                  ),
                  popupMenuItemBuilder(
                    value: PopupMenuItemOptions.delete,
                    icon: Icons.delete_outline,
                    iconColor: kGrey,
                    title: PopupMenuItemOptions.delete.name.capitalizedFirst,
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  void _onUpdateMember(BuildContext context) async {
    await memberAddUpdateBottomSheet(
      context: context,
      formStatus: FormStatus.update,
      existingMember: data,
    );
  }

  void _onDeleteMember(BuildContext context) async {
    bool? result = await DialogService.confirmationDialog(
      context: context,
      title: "Delete Member?",
      subtitle:
          "Are you sure you want to delete this member? This action cannot be undone.",
      negativeActionText: 'cancel'.toUpperCase(),
      positiveActionText: 'delete'.toUpperCase(),
    );

    if (result ?? false) {
      Get.find<MemberController>().deleteMember(data.id ?? '');
    }
  }
}
