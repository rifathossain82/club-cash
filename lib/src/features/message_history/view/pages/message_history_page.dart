import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/features/message_history/view/widgets/message_history_list_widget.dart';
import 'package:flutter/material.dart';

class MessageHistoryPage extends StatelessWidget {
  const MessageHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      appBar: AppBar(
        title: const Text("Message History"),
      ),
      body: const MessageHistoryListWidget(),
    );
  }
}
