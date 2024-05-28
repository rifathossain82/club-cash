import 'package:club_cash/src/features/home/view/widgets/net_balance_card_widget.dart';
import 'package:club_cash/src/features/home/view/widgets/transaction_list_title_text.dart';
import 'package:club_cash/src/features/home/view/widgets/transaction_list_widget.dart';
import 'package:flutter/material.dart';

class HomepageBody extends StatelessWidget {
  const HomepageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NetBalanceCardWidget(),
        const TransactionListTitleText(),
        Expanded(
          child: TransactionListWidget(),
        ),
      ],
    );
  }
}
