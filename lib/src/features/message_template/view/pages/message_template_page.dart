import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/features/message_template/view/widgets/message_template_list_widget.dart';
import 'package:club_cash/src/features/message_template/view/widgets/template_add_update_bottom_sheet.dart';
import 'package:flutter/material.dart';

class MessageTemplatePage extends StatelessWidget {
  const MessageTemplatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      appBar: AppBar(
        title: const Text("Message Template"),
      ),
      body: const MessageTemplateListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddMessageTemplate(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onAddMessageTemplate(BuildContext context) async {
    await templateAddUpdateBottomSheet(context: context);
  }
}
