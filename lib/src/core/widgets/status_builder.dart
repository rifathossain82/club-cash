import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class StatusBuilder extends StatelessWidget {
  final String status;
  final Color statusColor;

  const StatusBuilder({
    Key? key,
    required this.status,
    required this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: context.appTextTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: statusColor,
          fontSize: 10,
        ),
      ),
    );
  }
}
