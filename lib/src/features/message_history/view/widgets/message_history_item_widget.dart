import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/extensions/date_time_extension.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/features/message_history/model/message_history_model.dart';
import 'package:flutter/material.dart';

class MessageHistoryItemWidget extends StatelessWidget {
  final MessageHistoryModel messageHistory;

  const MessageHistoryItemWidget({
    super.key,
    required this.messageHistory,
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
          Text(
            messageHistory.timestamp?.formattedDateTime ?? '',
            maxLines: 1,
            textAlign: TextAlign.start,
            style: context.appTextTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            messageHistory.message ?? 'Empty Message',
            textAlign: TextAlign.start,
            style: context.appTextTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
