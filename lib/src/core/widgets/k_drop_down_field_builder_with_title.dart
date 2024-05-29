import 'package:club_cash/src/core/errors/messages.dart';
import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_button_progress_indicator.dart';
import 'package:flutter/material.dart';

class KDropDownFieldBuilderWithTitle<T> extends StatelessWidget {
  final bool isLoading;
  final String title;
  final List<T>? items;
  final T? value;
  final ValueChanged onChanged;
  final Widget Function(T?) itemBuilder;
  final bool validatorActive;
  final FocusNode? focusNode;
  final String hintText;
  final int? maxLines;
  final int? minLines;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Widget? suffix;
  final Widget? prefixIcon;
  final bool? obscureValue;
  final bool isBorder;
  final bool isEditable;

  const KDropDownFieldBuilderWithTitle({
    Key? key,
    this.isLoading = false,
    required this.title,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.itemBuilder,
    this.validatorActive = true,
    this.focusNode,
    this.hintText = 'Select One',
    this.maxLines,
    this.minLines,
    this.inputType,
    this.inputAction,
    this.suffix,
    this.prefixIcon,
    this.obscureValue,
    this.isBorder = true,
    this.isEditable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: context.appTextTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (validatorActive)
                TextSpan(
                  text: ' *',
                  style: context.appTextTheme.titleSmall?.copyWith(
                    color: kRed,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        isLoading
            ? Container(
                height: 56,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: kGrey,
                    width: 1,
                  ),
                ),
                child: KButtonProgressIndicator(
                  indicatorColor: kPrimaryColor,
                ),
              )
            : DropdownButtonFormField(
                validator: (value) {
                  if (validatorActive && items?.contains(value) == false) {
                    return Message.emptyField;
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
          isDense: true,
                hint: Text(
                  hintText,
                  style: context.appTextTheme.bodySmall,
                ),
                items: items
                    ?.map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: itemBuilder(item),
                      ),
                    )
                    .toList(),
                value: value,
                onChanged: isEditable ? onChanged : null,
              ),
        const SizedBox(height: 15),
      ],
    );
  }
}
