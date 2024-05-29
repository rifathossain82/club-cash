import 'package:club_cash/src/features/message_template/view/widgets/message_template_item_widget.dart';
import 'package:flutter/material.dart';

class MessageTemplateListWidget extends StatelessWidget {
  const MessageTemplateListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(15),
      itemCount: 8,
      itemBuilder: (context, index) => const MessageTemplateItemWidget(),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
