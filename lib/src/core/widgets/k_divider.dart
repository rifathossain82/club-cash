import 'package:club_cash/src/core/utils/color.dart';
import 'package:flutter/material.dart';

class KDivider extends StatelessWidget {
  final double? height;
  final Color? color;
  const KDivider({Key? key, this.height, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height ?? 10,
      color: color ?? kDividerColor,
    );
  }
}
