import 'package:club_cash/src/core/routes/routes.dart';
import 'package:club_cash/src/core/utils/app_constants.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_box_shadow.dart';
import 'package:club_cash/src/core/widgets/k_icon_button.dart';
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
      backgroundColor: kHomepageBackgroundColor,
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
        _AppBarIconButton(
          onPressed: _onPressedMember,
          iconData: Icons.person_add_alt,
        ),
        _AppBarIconButton(
          onPressed: _onPressedSettings,
          iconData: Icons.settings_outlined,
        ),
      ],
    );
  }

  void _onPressedMember() {
    Get.toNamed(
      RouteGenerator.memberListPage,
      arguments: false,
    );
  }

  void _onPressedSettings() {}

  void _onCashIn() {
    Get.toNamed(
      RouteGenerator.cashInTransactionAddUpdate,
      arguments: CashInTransactionAddUpdatePageArguments()
    );
  }

  void _onCashOut() {
    Get.toNamed(
      RouteGenerator.cashOutTransactionAddUpdate,
        arguments: CashOutTransactionAddUpdatePageArguments()
    );
  }
}

class _AppBarIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;

  const _AppBarIconButton({
    required this.onPressed,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        size: 20,
      ),
    );
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
