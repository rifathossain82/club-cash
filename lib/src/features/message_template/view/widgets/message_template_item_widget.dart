import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/services/dialog_service.dart';
import 'package:club_cash/src/core/utils/asset_path.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/svg_icon_button.dart';
import 'package:club_cash/src/features/message_template/controller/message_template_controller.dart';
import 'package:club_cash/src/features/message_template/model/message_template_model.dart';
import 'package:club_cash/src/features/message_template/view/widgets/template_add_update_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageTemplateItemWidget extends StatelessWidget {
  final MessageTemplateModel template;
  final bool isSelectable;

  const MessageTemplateItemWidget({
    Key? key,
    required this.template,
    required this.isSelectable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        if(isSelectable){
          Navigator.pop(context, template);
        }
      },
      child: Container(
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
                    template.title ?? '',
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
              template.message ?? '',
              textAlign: TextAlign.start,
              style: context.appTextTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  void onEditTemplate(BuildContext context) async {
    await templateAddUpdateBottomSheet(
      context: context,
      existingTemplate: template,
    );
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
      final contactController = Get.find<MessageTemplateController>();
      contactController.deleteTemplate(
        template.id ?? '',
      );
    }
  }
}

/*
import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/services/dialog_service.dart';
import 'package:club_cash/src/core/utils/asset_path.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/svg_icon_button.dart';
import 'package:club_cash/src/features/message_template/controller/message_history_controller.dart';
import 'package:club_cash/src/features/message_template/model/message_history_model.dart';
import 'package:club_cash/src/features/message_template/view/widgets/template_add_update_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageTemplateItemWidget extends StatelessWidget {
  final MessageTemplateModel template;

  const MessageTemplateItemWidget({
    super.key,
    required this.template,
  });

  @override
  Widget build(BuildContext context) {
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
                  template.title ?? '',
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
            template.message ?? '',
            textAlign: TextAlign.start,
            style: context.appTextTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  void onEditTemplate(BuildContext context) async {
    await templateAddUpdateBottomSheet(
      context: context,
      existingTemplate: template,
    );
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
      final contactController = Get.find<MessageTemplateController>();
      contactController.deleteTemplate(
        template.id ?? '',
      );
    }
  }
}


 */
