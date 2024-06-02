import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/routes/routes.dart';
import 'package:club_cash/src/core/utils/app_constants.dart';
import 'package:club_cash/src/core/utils/asset_path.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_box_shadow.dart';
import 'package:club_cash/src/core/widgets/k_button.dart';
import 'package:club_cash/src/core/widgets/k_button_progress_indicator.dart';
import 'package:club_cash/src/core/widgets/k_icon_button.dart';
import 'package:club_cash/src/core/widgets/popup_menu_item_builder.dart';
import 'package:club_cash/src/features/auth/controller/auth_controller.dart';
import 'package:club_cash/src/features/home/view/pages/cash_in_transaction_add_update_page.dart';
import 'package:club_cash/src/features/home/view/pages/cash_out_transaction_add_update_page.dart';
import 'package:club_cash/src/features/home/view/widgets/homepage_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      appBar: _homepageAppBar(context),
      body: const HomepageBody(),
      bottomNavigationBar: _BottomNavigationBar(
        onCashIn: _onCashIn,
        onCashOut: _onCashOut,
      ),
    );
  }

  AppBar _homepageAppBar(BuildContext context) {
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
            } else if (value == 2) {
              _onPressedMessageHistory();
            } else {
              _onPressedLogout(context);
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
            popupMenuItemBuilder(
              value: 3,
              icon: Icons.logout,
              iconColor: kGrey,
              title: "Logout",
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

  void _onPressedLogout(BuildContext context) async {
    final authController = Get.find<AuthController>();

    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 150,
                  width: context.screenWidth * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                    color: kPrimaryColor,
                  ),
                  child: Lottie.asset(
                    AssetPath.logoutLottie,
                    height: 120,
                    width: 120,
                  ),
                ),
                Container(
                  height: 150,
                  width: context.screenWidth * 0.8,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(15),
                    ),
                    color: kWhite,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'You are about to logout.\nAre you sure this is what you want?',
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleMedium,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Cancel',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          KButton(
                            width: context.screenWidth * 0.4,
                            bgColor: kPrimaryColor,
                            onPressed: () {
                              authController.logout();
                            },
                            child: Obx(() {
                              return authController.isLoginLoading.value
                                  ? const KButtonProgressIndicator()
                                  : Text(
                                      'Confirm Logout'.toUpperCase(),
                                      style: context.buttonTextStyle,
                                    );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _onCashIn() {
    Get.toNamed(
      RouteGenerator.cashInTransactionAddUpdate,
      arguments: CashInTransactionAddUpdatePageArguments(),
    );
  }

  void _onCashOut() {
    Get.toNamed(
      RouteGenerator.cashOutTransactionAddUpdate,
      arguments: CashOutTransactionAddUpdatePageArguments(),
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
