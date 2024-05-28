import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:flutter/material.dart';

class DateTimeSelectorButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData leadingIcon;
  final String title;

  const DateTimeSelectorButton({
    Key? key,
    required this.onTap,
    required this.leadingIcon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            leadingIcon,
            color: kGrey,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: context.appTextTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.arrow_drop_down_outlined,
            color: kGrey,
          ),
        ],
      ),
    );
  }
}
