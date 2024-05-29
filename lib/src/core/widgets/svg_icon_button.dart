import 'package:club_cash/src/core/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final String svgIconPath;
  final double? size;
  final Color? color;

  const SvgIconButton({
    super.key,
    required this.onTap,
    required this.svgIconPath,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SvgPicture.asset(
        svgIconPath,
        alignment: Alignment.center,
        width: size ?? 20,
        height: size ?? 20,
        color: color ?? kPrimaryColor,
      ),
    );
  }
}
