import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/failure_widget_builder.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class KDropDownSearchBuilderWithTitle<T> extends StatelessWidget {
  final String title;
  final String? hintText;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final Future<List<T>> Function(String? value)? onFind;
  final String Function(T?)? itemAsString;
  final List<T>? items;
  final bool Function(T?, T?)? compareFn;
  final bool showSelectedItem;
  final bool showSearchBox;
  final bool isFilteredOnline;
  final bool isBottomSheetMode;

  const KDropDownSearchBuilderWithTitle({
    Key? key,
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
    this.isBottomSheetMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context),
        const SizedBox(height: 5),
        _buildDropdownSearch(context),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return RichText(
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
              style: context.appTextTheme.titleSmall?.copyWith(
                color: kRed,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDropdownSearch(BuildContext context) {
    return DropdownSearch<T>(
      popupBarrierColor: isBottomSheetMode ? null : Colors.transparent,
      dropdownSearchDecoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
        isDense: true,
        hintText: hintText,
        hintStyle: context.appTextTheme.bodySmall,
        border: const OutlineInputBorder(),
      ),
      errorBuilder: (context, value, __) => const FailureWidgetBuilder(),
      emptyBuilder: (context, value) => const FailureWidgetBuilder(),
      popupShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isBottomSheetMode ? 8 : 0),
      ),
      popupTitle: isBottomSheetMode ? _buildPopupTitle(context) : null,
      showSearchBox: showSearchBox,
      mode: isBottomSheetMode ? Mode.BOTTOM_SHEET : Mode.MENU,
      maxHeight: context.screenHeight * 0.5,
      compareFn: compareFn ?? (t1, t2) => t1 == t2,
      showSelectedItems: showSelectedItem,
      onFind: onFind,
      itemAsString: itemAsString,
      onChanged: onChanged,
      isFilteredOnline: isFilteredOnline,
      items: items,
      selectedItem: value,
      validator: validator,
    );
  }

  Widget _buildPopupTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 15,
      ),
      child: Text(
        hintText ?? 'Select',
        maxLines: 1,
        style: context.appTextTheme.titleLarge?.copyWith(
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
