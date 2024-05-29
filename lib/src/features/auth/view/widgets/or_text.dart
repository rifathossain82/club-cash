import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:flutter/material.dart';

class OrText extends StatelessWidget {
  const OrText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        "OR",
        style: context.appTextTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w400,
          color: kBlackLight,
          fontSize: 11,
        ),
      ),
    );
  }
}