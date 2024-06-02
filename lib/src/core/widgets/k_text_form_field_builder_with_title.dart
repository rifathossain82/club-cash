import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:flutter/material.dart';

class KTextFormFieldBuilderWithTitle extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final FormFieldValidator? validator;
  final String? hintText;
  final FocusNode? focusNode;
  final IconData? prefixIconData;
  final Widget? suffixIcon;
  final int maxLine;
  final int minLine;
  final Function(String value)? onChanged;
  final VoidCallback? onTap;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool readOnly;
  final bool obscureText;
  final double bottomPadding;

  const KTextFormFieldBuilderWithTitle({
    Key? key,
    required this.title,
    this.controller,
    this.validator,
    this.hintText,
    this.focusNode,
    this.prefixIconData,
    this.suffixIcon,
    this.maxLine = 1,
    this.minLine = 1,
    this.onChanged,
    this.onTap,
    this.inputAction = TextInputAction.next,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.bottomPadding = 15,
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
            if (validator != null)
              Text(
                ' *',
                style: context.appTextTheme.titleSmall?.copyWith(
                  color: kRed,
                ),
              ),
          ],
        ),
        const SizedBox(height: 5),
        TextFormField(
          onTap: onTap,
          onChanged: onChanged,
          controller: controller,
          focusNode: focusNode,
          validator: validator,
          maxLines: maxLine,
          minLines: minLine,
          keyboardType: inputType,
          textInputAction: inputAction,
          textAlign: TextAlign.start,
          readOnly: readOnly,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: context.appTextTheme.bodySmall,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            prefixIcon: prefixIconData != null ? Icon(prefixIconData) : null,
            suffixIcon: suffixIcon,
          ),
        ),
        SizedBox(height: bottomPadding),
      ],
    );
  }
}
