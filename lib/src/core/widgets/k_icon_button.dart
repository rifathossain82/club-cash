import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_button_progress_indicator.dart';
import 'package:flutter/material.dart';

class KIconButton extends StatelessWidget {
  const KIconButton({
    Key? key,
    this.onPressed,
    required this.iconData,
    required this.title,
    this.borderRadius,
    this.bgColor,
    this.height,
    this.width,
    this.isLoading = false,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final IconData iconData;
  final String title;
  final double? borderRadius;
  final Color? bgColor;
  final double? height;
  final double? width;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 4),
      ),
      color: bgColor ?? kPrimaryColor,
      height: height ?? 42,
      minWidth: width ?? context.screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      elevation: 0,
      child: isLoading
          ? const KButtonProgressIndicator()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  size: 20,
                  color: kWhite,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    title,
                    style: context.buttonTextStyle,
                  ),
                ),
              ],
            ),
    );
  }
}
