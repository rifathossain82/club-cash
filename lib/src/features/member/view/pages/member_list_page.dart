import 'package:club_cash/src/core/enums/app_enum.dart';
import 'package:club_cash/src/core/routes/routes.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_box_shadow.dart';
import 'package:club_cash/src/core/widgets/k_icon_button.dart';
import 'package:club_cash/src/core/widgets/k_search_field.dart';
import 'package:club_cash/src/features/member/controller/member_controller.dart';
import 'package:club_cash/src/features/member/model/member_model.dart';
import 'package:club_cash/src/features/member/view/widgets/member_add_update_bottom_sheet.dart';
import 'package:club_cash/src/features/member/view/widgets/member_list_widget.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberListPageArgument {
  final bool isSelectable;

  const MemberListPageArgument({
    required this.isSelectable,
  });
}

class MemberListPage extends StatefulWidget {
  final MemberListPageArgument argument;

  const MemberListPage({
    Key? key,
    required this.argument,
  }) : super(key: key);

  @override
  State<MemberListPage> createState() => _MemberPickerPageState();
}

class _MemberPickerPageState extends State<MemberListPage> {
  final searchTextController = TextEditingController();
  final memberController = Get.find<MemberController>();

  @override
  void initState() {
    super.initState();
    memberController.getMemberList();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.argument.isSelectable ? 'Select Member' : 'Members',
        ),
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onAddFromContact: _onAddFromContact,
        onAddManually: _onAddManually,
      ),
      body: Column(
        children: [
          KSearchField(
            controller: searchTextController,
            hintText: 'Search',
          ),
          Expanded(
            child: MemberListWidget(
              isSelectable: widget.argument.isSelectable,
            ),
          ),
        ],
      ),
    );
  }

  void _onAddFromContact() async {
    var result = await Get.toNamed(RouteGenerator.selectableContactList);

    if (result is Contact) {
      await memberAddUpdateBottomSheet(
          context: context,
          formStatus: FormStatus.add,
          existingMember: MemberModel(
              name: "${result.displayName}",
              phone: "${result.phones?.first.value}"));
    }
  }

  void _onAddManually() async {
    await memberAddUpdateBottomSheet(
      context: context,
      formStatus: FormStatus.add,
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final VoidCallback onAddFromContact;
  final VoidCallback onAddManually;

  const _BottomNavigationBar({
    required this.onAddFromContact,
    required this.onAddManually,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [
          KBoxShadow.top(),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: KIconButton(
              onPressed: onAddFromContact,
              iconData: Icons.contacts_outlined,
              title: "Add Contact".toUpperCase(),
              bgColor: kGreen,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: KIconButton(
              onPressed: onAddManually,
              iconData: Icons.add,
              title: "Add Manually".toUpperCase(),
              bgColor: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
