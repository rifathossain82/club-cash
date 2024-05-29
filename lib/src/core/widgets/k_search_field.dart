import 'package:club_cash/src/core/utils/color.dart';
import 'package:flutter/material.dart';

class KSearchField extends StatelessWidget {
  const KSearchField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.hintText,
    this.labelText,
    this.onSubmitted,
    this.onChanged,
    this.inputType,
    this.inputAction,
    this.suffix,
    this.obscureValue,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? labelText;
  final Function(String value)? onSubmitted;
  final Function(String value)? onChanged;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Widget? suffix;
  final bool? obscureValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        maxLines: 1,
        keyboardType: inputType,
        textInputAction: inputAction,
        obscureText: obscureValue ?? false,
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          labelText: labelText,
          filled: true,
          fillColor: kWhite,
          contentPadding: EdgeInsets.zero,
          prefixIcon: Icon(
            Icons.search,
            size: 20,
            color: kGrey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: kGreyLight,
              width: 0.5,
            ),
          ),
          suffixIcon: suffix,
        ),
      ),
    );
  }
}
