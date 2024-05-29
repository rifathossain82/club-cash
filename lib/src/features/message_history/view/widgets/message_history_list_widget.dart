import 'package:club_cash/src/features/message_history/view/widgets/message_history_item_widget.dart';
import 'package:flutter/material.dart';

class MessageHistoryListWidget extends StatelessWidget {
  const MessageHistoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(15),
      itemCount: 8,
      itemBuilder: (context, index) => const MessageHistoryItemWidget(),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
