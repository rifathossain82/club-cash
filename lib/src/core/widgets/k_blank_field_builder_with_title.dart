import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:flutter/material.dart';

class KBlankFieldBuilderWithTitle extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback? onTap;
  final bool hasValidator;

  const KBlankFieldBuilderWithTitle({
    Key? key,
    required this.title,
    required this.content,
    this.onTap,
    this.hasValidator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.appTextTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (hasValidator)
              Text(
                ' *',
                style: context.appTextTheme.titleSmall?.copyWith(
                  color: kRed,
                ),
              ),
          ],
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            height: 48,
            width: double.maxFinite,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                width: 1,
                color: kGreyMedium,
              ),
            ),
            child: content,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
