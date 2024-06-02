import 'package:club_cash/src/core/widgets/failure_widget_builder.dart';
import 'package:club_cash/src/core/widgets/k_custom_loader.dart';
import 'package:club_cash/src/features/message_template/controller/message_template_controller.dart';
import 'package:club_cash/src/features/message_template/view/widgets/message_template_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageTemplateListWidget extends StatelessWidget {
  const MessageTemplateListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MessageTemplateController>();
    return Obx(
      () => controller.isLoadingTemplateList.value
          ? const KCustomLoader()
          : controller.templateList.isEmpty
              ? const FailureWidgetBuilder()
              : _TemplateList(controller: controller),
    );
  }
}

class _TemplateList extends StatelessWidget {
  final MessageTemplateController controller;

  const _TemplateList({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(15),
      itemCount: controller.templateList.length,
      itemBuilder: (context, index) => MessageTemplateItemWidget(
        template: controller.templateList[index],
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
