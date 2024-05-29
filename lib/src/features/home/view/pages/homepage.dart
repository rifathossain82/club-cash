import 'package:club_cash/src/core/routes/routes.dart';
import 'package:club_cash/src/core/utils/app_constants.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_box_shadow.dart';
import 'package:club_cash/src/core/widgets/k_icon_button.dart';
import 'package:club_cash/src/core/widgets/popup_menu_item_builder.dart';
import 'package:club_cash/src/features/home/view/pages/cash_in_transaction_add_update_page.dart';
import 'package:club_cash/src/features/home/view/pages/cash_out_transaction_add_update_page.dart';
import 'package:club_cash/src/features/home/view/widgets/homepage_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      appBar: _homepageAppBar(),
      body: const HomepageBody(),
      bottomNavigationBar: _BottomNavigationBar(
        onCashIn: _onCashIn,
        onCashOut: _onCashOut,
      ),
    );
  }

  AppBar _homepageAppBar() {
    return AppBar(
      title: const Text(AppConstants.appName),
      actions: [
        PopupMenuButton(
          color: kWhite,
          onSelected: (value) {
            if (value == 0) {
              _onPressedMember();
            } else if (value == 1) {
              _onPressedMessageTemplate();
            } else {
              _onPressedMessageHistory();
            }
          },
          icon: Icon(
            Icons.more_vert_outlined,
            color: kWhite,
          ),
          itemBuilder: (BuildContext context) => [
            popupMenuItemBuilder(
              value: 0,
              icon: Icons.people_outline,
              iconColor: kGrey,
              title: "Members",
            ),
            popupMenuItemBuilder(
              value: 1,
              icon: Icons.message_outlined,
              iconColor: kGrey,
              title: "Message Template",
            ),
            popupMenuItemBuilder(
              value: 2,
              icon: Icons.history,
              iconColor: kGrey,
              title: "Message History",
            ),
          ],
        )
      ],
    );
  }

  void _onPressedMember() {
    Get.toNamed(
      RouteGenerator.memberListPage,
      arguments: false,
    );
  }

  void _onPressedMessageTemplate() {
    Get.toNamed(
      RouteGenerator.messageTemplate,
    );
  }

  void _onPressedMessageHistory() {
    Get.toNamed(
      RouteGenerator.messageHistory,
    );
  }

  void _onCashIn() {
    Get.toNamed(RouteGenerator.cashInTransactionAddUpdate,
        arguments: CashInTransactionAddUpdatePageArguments());
  }

  void _onCashOut() {
    Get.toNamed(RouteGenerator.cashOutTransactionAddUpdate,
        arguments: CashOutTransactionAddUpdatePageArguments());
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final VoidCallback onCashIn;
  final VoidCallback onCashOut;

  const _BottomNavigationBar({
    required this.onCashIn,
    required this.onCashOut,
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
              onPressed: onCashIn,
              iconData: Icons.add,
              title: "cash in".toUpperCase(),
              bgColor: kGreen,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: KIconButton(
              onPressed: onCashOut,
              iconData: CupertinoIcons.minus,
              title: "cash out".toUpperCase(),
              bgColor: kRed,
            ),
          ),
        ],
      ),
    );
  }
}
