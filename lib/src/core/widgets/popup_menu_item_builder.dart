import 'package:club_cash/src/core/utils/color.dart';
import 'package:flutter/material.dart';

PopupMenuItem popupMenuItemBuilder({
  required dynamic value,
  required IconData icon,
  required Color iconColor,
  required String title,
}) {
  return PopupMenuItem(
    value: value,
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
      ),
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: kBlackLight,
        ),
      ),
    ),
  );
}
