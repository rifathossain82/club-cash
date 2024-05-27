import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/extensions/date_time_extension.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_divider.dart';
import 'package:flutter/material.dart';

class TransactionItemWidget extends StatelessWidget {

  const TransactionItemWidget({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(
              left: 15,
            ),
            leading: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kGreyLight.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.book,
                color: kPrimaryColor,
              ),
            ),
            title: Text(
              "Cash",
              style: context.appTextTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Created ${DateTime.now().formattedDateTime} ago',
              style: context.appTextTheme.bodySmall?.copyWith(
                color: kGreyTextColor,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '',
                  style: context.appTextTheme.bodySmall?.copyWith(
                    color: kGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
          const KDivider(),
        ],
      ),
    );
  }
}
