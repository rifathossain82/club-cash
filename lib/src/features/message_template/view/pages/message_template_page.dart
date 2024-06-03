import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/features/message_template/view/widgets/message_template_list_widget.dart';
import 'package:club_cash/src/features/message_template/view/widgets/template_add_update_bottom_sheet.dart';
import 'package:flutter/material.dart';

class MessageTemplateArgument {
  final bool isSelectable;

  const MessageTemplateArgument({
    required this.isSelectable,
  });
}

class MessageTemplatePage extends StatelessWidget {
  final MessageTemplateArgument argument;

  const MessageTemplatePage({
    super.key,
    required this.argument,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      appBar: AppBar(
        title: const Text("Message Template"),
      ),
      body: MessageTemplateListWidget(
        isSelectable: argument.isSelectable,
      ),
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
