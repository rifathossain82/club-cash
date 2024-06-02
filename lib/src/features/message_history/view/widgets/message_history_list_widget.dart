import 'package:club_cash/src/core/widgets/failure_widget_builder.dart';
import 'package:club_cash/src/core/widgets/k_custom_loader.dart';
import 'package:club_cash/src/features/message_history/controller/message_history_controller.dart';
import 'package:club_cash/src/features/message_history/view/widgets/message_history_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageHistoryListWidget extends StatelessWidget {
  const MessageHistoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MessageHistoryController>();
    return Obx(
      () => controller.isLoadingHistoryList.value
          ? const KCustomLoader()
          : controller.historyList.isEmpty
              ? const FailureWidgetBuilder()
              : _HistoryList(controller: controller),
    );
  }
}

class _HistoryList extends StatelessWidget {
  final MessageHistoryController controller;

  const _HistoryList({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(15),
      itemCount: controller.historyList.length,
      itemBuilder: (context, index) => MessageHistoryItemWidget(
        messageHistory: controller.historyList[index],
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
