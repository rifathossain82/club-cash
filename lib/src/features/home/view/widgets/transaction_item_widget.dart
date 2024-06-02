import 'package:club_cash/src/core/enums/app_enum.dart';
import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/extensions/date_time_extension.dart';
import 'package:club_cash/src/core/routes/routes.dart';
import 'package:club_cash/src/core/services/dialog_service.dart';
import 'package:club_cash/src/core/utils/asset_path.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_divider.dart';
import 'package:club_cash/src/core/widgets/status_builder.dart';
import 'package:club_cash/src/core/widgets/svg_icon_button.dart';
import 'package:club_cash/src/features/home/controller/home_controller.dart';
import 'package:club_cash/src/features/home/model/transaction_model.dart';
import 'package:club_cash/src/features/home/view/pages/cash_in_transaction_add_update_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionItemWidget extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItemWidget({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: kGreyLight,
            width: 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        transaction.member?.name ?? "",
                        style: context.appTextTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      StatusBuilder(
                        status: transaction.paymentMethod ?? "",
                        statusColor: kBlue,
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${transaction.amount ?? 0}",
                        style: context.appTextTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: transaction.type == TransactionType.cashIn.name
                              ? kGreen
                              : kRed,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${transaction.datetime?.formattedDateTime}",
                        textAlign: TextAlign.start,
                        style: context.appTextTheme.bodySmall?.copyWith(
                          color: kGreyTextColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const KDivider(height: 0),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Text(
                    'Remarks: ${transaction.remarks ?? ''}',
                    style: context.appTextTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: kGreyTextColor,
                      fontSize: 11,
                    ),
                  ),
                  const Spacer(),
                  SvgIconButton(
                    onTap: onEditTransaction,
                    svgIconPath: AssetPath.editIcon,
                  ),
                  const SizedBox(width: 30),
                  SvgIconButton(
                    onTap: () => onDeleteTransaction(context),
                    svgIconPath: AssetPath.deleteIcon,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onEditTransaction() {
    Get.toNamed(
      RouteGenerator.cashInTransactionAddUpdate,
      arguments: CashInTransactionAddUpdatePageArguments(
        existingTransaction: transaction,
      ),
    );
  }

  void onDeleteTransaction(BuildContext context) async {
    bool? result = await DialogService.confirmationDialog(
      context: context,
      title: "Delete Transaction?",
      subtitle:
          "Are you sure you want to delete this transaction? This action cannot be undone.",
      negativeActionText: 'cancel'.toUpperCase(),
      positiveActionText: 'delete'.toUpperCase(),
    );

    if (result ?? false) {
      final transactionController = Get.find<TransactionController>();
      transactionController.deleteTransaction(
        transaction.id ?? '',
      );
    }
  }
}
