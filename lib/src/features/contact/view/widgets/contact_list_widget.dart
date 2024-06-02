import 'package:club_cash/src/core/widgets/failure_widget_builder.dart';
import 'package:club_cash/src/core/widgets/k_custom_loader.dart';
import 'package:club_cash/src/features/contact/controller/contact_controller.dart';
import 'package:club_cash/src/features/contact/view/widgets/contact_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactListWidget extends StatelessWidget {
  final ContactController contactController;

  const ContactListWidget({
    super.key,
    required this.contactController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return contactController.isLoadingContactList.value
          ? const KCustomLoader()
          : contactController.contactList.isEmpty
              ? const FailureWidgetBuilder()
              : _ContactList(
                  contactController: contactController,
                );
    });
  }
}

class _ContactList extends StatelessWidget {
  final ContactController contactController;

  const _ContactList({
    required this.contactController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: contactController.contactList.length,
      itemBuilder: (context, index) => ContactItemWidget(
        contact: contactController.contactList[index],
      ),
      separatorBuilder: (context, index) => const Divider(height: 0),
    );
  }
}
