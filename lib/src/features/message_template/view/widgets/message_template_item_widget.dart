import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/services/dialog_service.dart';
import 'package:club_cash/src/core/utils/asset_path.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/svg_icon_button.dart';
import 'package:club_cash/src/features/message_template/view/widgets/template_add_update_bottom_sheet.dart';
import 'package:flutter/material.dart';

class MessageTemplateItemWidget extends StatelessWidget {
  const MessageTemplateItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String msg = 'Dear customer,\nYou have purchased %d TK products from %s. thanks for shopping with us!';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: kGreyLight,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Common SMS",
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: context.appTextTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SvgIconButton(
                onTap: () => onEditTemplate(context),
                svgIconPath: AssetPath.editIcon,
              ),
              const SizedBox(width: 30),
              SvgIconButton(
                onTap: () => onDeleteTemplate(context),
                svgIconPath: AssetPath.deleteIcon,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            msg,
            textAlign: TextAlign.start,
            style: context.appTextTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  void onEditTemplate(BuildContext context) async {
    await templateAddUpdateBottomSheet(context: context);
  }

  void onDeleteTemplate(BuildContext context) async {
    bool? result = await DialogService.confirmationDialog(
      context: context,
      title: "Delete Template?",
      subtitle:
          "Are you sure you want to delete this message template? This action cannot be undone.",
      negativeActionText: 'cancel'.toUpperCase(),
      positiveActionText: 'delete'.toUpperCase(),
    );

    if (result ?? false) {
      // final contactController = Get.find<ContactController>();
      // contactController.deleteContact(
      //   id: '${data.id}',
      // );
    }
  }
}
