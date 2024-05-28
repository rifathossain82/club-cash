import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:flutter/material.dart';

class KOutlinedButton extends StatelessWidget {
  const KOutlinedButton({
    Key? key,
    this.onPressed,
    required this.child,
    this.borderRadius,
    this.borderColor,
    this.bgColor,
    this.height,
    this.width,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final double? borderRadius;
  final Color? borderColor;
  final Color? bgColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor ?? kGrey),
        borderRadius: BorderRadius.circular(borderRadius ?? 5),
      ),
      color: bgColor ?? kWhite,
      height: height ?? 42,
      minWidth: width ?? context.screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      elevation: 0,
      child: child,
    );
  }
}
