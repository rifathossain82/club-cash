import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/services/snack_bar_services.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_divider.dart';
import 'package:club_cash/src/features/home/controller/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetBalanceCardWidget extends StatelessWidget {
  const NetBalanceCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();
    return Obx(() {
      return Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: kGreyLight,
            width: 0.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Net Balance',
                    style: context.appTextTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: kBlackLight,
                    ),
                  ),
                  Text(
                    transactionController.isLoadingSummary.value
                        ? "Loading..."
                        : "${transactionController.netBalance.value}",
                    style: context.appTextTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: kBlackLight,
                    ),
                  ),
                ],
              ),
            ),
            const KDivider(height: 0),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total In (+)',
                        textAlign: TextAlign.start,
                        style: context.appTextTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: kBlackLight,
                        ),
                      ),
                      Text(
                        transactionController.isLoadingSummary.value
                            ? "Loading..."
                            : "${transactionController.totalCashIn.value}",
                        textAlign: TextAlign.end,
                        style: context.appTextTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: kGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Out (-)',
                        textAlign: TextAlign.start,
                        style: context.appTextTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: kBlackLight,
                        ),
                      ),
                      Text(
                        transactionController.isLoadingSummary.value
                            ? "Loading..."
                            : "${transactionController.totalCashOut.value}",
                        textAlign: TextAlign.end,
                        style: context.appTextTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: kRed,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const KDivider(height: 0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onViewReports,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'view reports'.toUpperCase(),
                      style: context.appTextTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: kPrimaryColor,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  void onViewReports() {
    SnackBarService.showSnackBar(
      message: "Coming Soon...",
      bgColor: kPrimaryColor,
    );
  }
}
