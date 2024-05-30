import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_search_field.dart';
import 'package:club_cash/src/features/member/controller/member_controller.dart';
import 'package:club_cash/src/features/member/view/widgets/member_add_update_bottom_sheet.dart';
import 'package:club_cash/src/features/member/view/widgets/member_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberListPage extends StatefulWidget {
  final bool isSelectable;

  const MemberListPage({
    Key? key,
    this.isSelectable = false,
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
        title: Text(widget.isSelectable ? 'Select Member' : 'Members'),
      ),
      floatingActionButton: _ManuallyAddButton(
        onPressed: _onManuallyAddMember,
      ),
      body: Column(
        children: [
          KSearchField(
            controller: searchTextController,
            hintText: 'Search',
          ),
          Expanded(
            child: MemberListWidget(
              isSelectable: widget.isSelectable,
            ),
          ),
        ],
      ),
    );
  }

  void _onManuallyAddMember() async {
    await memberAddUpdateBottomSheet(
      context: context,
    );
  }
}

class _ManuallyAddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ManuallyAddButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: kPrimaryColor,
      elevation: 0,
      icon: Icon(
        Icons.add,
        color: kWhite,
      ),
      label: Text(
        'add manually'.toUpperCase(),
        style: context.buttonTextStyle,
      ),
    );
  }
}
