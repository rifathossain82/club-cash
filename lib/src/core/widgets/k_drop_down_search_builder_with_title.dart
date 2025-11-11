import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/failure_widget_builder.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class KDropDownSearchBuilderWithTitle<T> extends StatelessWidget {
  final String title;
  final String? hintText;
  final dynamic value;
  final ValueChanged onChanged;
  final String? Function(T?)? validator;
  final Future<List<T>> Function(String? value)? onFind;
  final String Function(T?)? itemAsString;
  final List<T>? items;
  final bool Function(T?, T?)? compareFn;
  final bool showSelectedItem;
  final bool showSearchBox;
  final bool isFilteredOnline;

  const KDropDownSearchBuilderWithTitle({
    super.key,
    required this.title,
    this.hintText,
    required this.value,
    required this.onChanged,
    this.validator,
    this.onFind,
    this.itemAsString,
    this.items,
    this.compareFn,
    this.showSelectedItem = true,
    this.showSearchBox = true,
    this.isFilteredOnline = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
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
              if (validator != null)
                TextSpan(
                  text: ' *',
                  style: context.appTextTheme.titleSmall?.copyWith(color: kRed),
                ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        DropdownSearch<T>(
          items: (filter, infiniteScrollProps) =>
          isFilteredOnline ? onFind!(filter) : Future.value(items!),
          itemAsString: itemAsString,
          selectedItem: value,
          onChanged: onChanged,
          compareFn: compareFn ?? (a, b) => a == b,
          popupProps: PopupProps.menu(
            showSearchBox: true,
            disableFilter: isFilteredOnline,
            fit: FlexFit.loose,
            constraints: BoxConstraints(maxHeight: context.screenHeight * 0.5),
            errorBuilder: (context, searchEntry, exception) {
              return const FailureWidgetBuilder();
            },
            emptyBuilder: (context, searchEntry) {
              return const FailureWidgetBuilder();
            },
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                hintText: "Search...",
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
          ),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
              isDense: true,
              hintText: hintText,
              hintStyle: context.appTextTheme.bodySmall,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}