import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/extensions/date_time_extension.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_divider.dart';
import 'package:club_cash/src/core/widgets/status_builder.dart';
import 'package:flutter/material.dart';

class TransactionItemWidget extends StatelessWidget {
  const TransactionItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
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
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Jamal Uddin",
                        style: context.appTextTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      StatusBuilder(
                        status: 'Cash',
                        statusColor: kBlue,
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "500",
                        style: context.appTextTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: kGreen,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${'Balance'}: 500',
                        style: context.appTextTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: kGreyTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const KDivider(height: 0),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                DateTime.now().formattedDateTime,
                style: context.appTextTheme.bodySmall?.copyWith(
                  color: kGreyTextColor,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
