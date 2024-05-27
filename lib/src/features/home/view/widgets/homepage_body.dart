import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/features/home/view/widgets/net_balance_card_widget.dart';
import 'package:club_cash/src/features/home/view/widgets/transaction_list_widget.dart';
import 'package:flutter/material.dart';

class HomepageBody extends StatelessWidget {
  const HomepageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NetBalanceCardWidget(),
        Padding(
          padding: const EdgeInsets.only(
            left: 18,
            right: 15,
            top: 8,
            bottom: 4,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Transaction List : ",
              textAlign: TextAlign.start,
              style: context.appTextTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: kBlackLight,
              ),
            ),
          ),
        ),
        Expanded(
          child: TransactionListWidget(),
        ),
      ],
    );
  }
}
