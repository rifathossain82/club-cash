import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/extensions/date_time_extension.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:flutter/material.dart';

class MessageHistoryItemWidget extends StatelessWidget {
  const MessageHistoryItemWidget({super.key});

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
          Text(
            DateTime.now().formattedDateTime,
            maxLines: 1,
            textAlign: TextAlign.start,
            style: context.appTextTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
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
}
