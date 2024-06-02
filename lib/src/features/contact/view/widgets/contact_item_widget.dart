import 'dart:math';

import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactItemWidget extends StatelessWidget {
  final Contact contact;

  const ContactItemWidget({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = Random().nextInt(randomColors.length);
    return GestureDetector(
      onTap: () async {
        Navigator.pop(context, contact);
      },
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        leading: Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: randomColors[index],
          ),
          child: Text(
            (contact.displayName ?? '').substring(0, 1).toUpperCase(),
            style: context.appTextTheme.titleMedium?.copyWith(
              color: kWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          contact.displayName ?? '',
          style: context.appTextTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: kBlackLight,
          ),
        ),
        subtitle: Text(
          '${contact.phones?.isNotEmpty ?? false ? contact.phones!.first.value : ''}',
          style: context.appTextTheme.bodySmall?.copyWith(
            color: kGreyTextColor,
          ),
        ),
      ),
    );
  }
}
