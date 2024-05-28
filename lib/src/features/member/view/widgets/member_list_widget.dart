import 'package:club_cash/src/core/widgets/title_text_widget.dart';
import 'package:club_cash/src/features/member/view/widgets/member_item_widget.dart';
import 'package:flutter/material.dart';

class MemberListWidget extends StatelessWidget {
  final bool isSelectable;

  const MemberListWidget({
    super.key,
    required this.isSelectable,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _AddedMemberList(
            isSelectable: isSelectable,
          ),
          const SizedBox(height: 15),
          _ContactList(
            isSelectable: isSelectable,
          ),
        ],
      ),
    );
  }
}

class _AddedMemberList extends StatelessWidget {
  final bool isSelectable;

  const _AddedMemberList({
    required this.isSelectable,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const TitleTextWidget(title: "Added Members : "),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) => MemberItemWidget(
            data: '$index',
            isSelectable: isSelectable,
            isEditable: true,
          ),
          separatorBuilder: (context, index) => const Divider(height: 0),
        ),
      ],
    );
  }
}

class _ContactList extends StatelessWidget {
  final bool isSelectable;

  const _ContactList({
    required this.isSelectable,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const TitleTextWidget(title: "Member From Contacts : "),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 20,
          itemBuilder: (context, index) => MemberItemWidget(
            data: '$index',
            isSelectable: isSelectable,
            isEditable: false,
          ),
          separatorBuilder: (context, index) => const Divider(height: 0),
        ),
      ],
    );
  }
}
