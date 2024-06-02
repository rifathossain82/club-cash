import 'package:club_cash/src/core/helpers/debouncer.dart';
import 'package:club_cash/src/core/widgets/k_search_field.dart';
import 'package:club_cash/src/features/contact/controller/contact_controller.dart';
import 'package:club_cash/src/features/contact/view/widgets/contact_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectableContactListPage extends StatefulWidget {
  const SelectableContactListPage({Key? key}) : super(key: key);

  @override
  State<SelectableContactListPage> createState() => _MemberPickerPageState();
}

class _MemberPickerPageState extends State<SelectableContactListPage> {
  final searchTextController = TextEditingController();
  final contactController = Get.find<ContactController>();

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contact'),
      ),
      body: Column(
        children: [
          KSearchField(
            controller: searchTextController,
            hintText: 'Search',
            inputType: TextInputType.text,
            inputAction: TextInputAction.search,
            onChanged: onChangedSearchBox,
          ),
          Expanded(
            child: ContactListWidget(
              contactController: contactController,
            ),
          ),
        ],
      ),
    );
  }

  void onChangedSearchBox(dynamic value) {
    Debouncer.run(() {
      contactController.getContactList(text: value);
    });
  }
}
