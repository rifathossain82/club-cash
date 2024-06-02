import 'package:club_cash/src/features/home/controller/transaction_controller.dart';
import 'package:club_cash/src/features/home/view/widgets/net_balance_card_widget.dart';
import 'package:club_cash/src/core/widgets/title_text_widget.dart';
import 'package:club_cash/src/features/home/view/widgets/transaction_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomepageBody extends StatelessWidget {
  const HomepageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Get.find<TransactionController>().reload();
      },
      child: Stack(
        children: [
          ListView(),
          Column(
            children: const [
              NetBalanceCardWidget(),
              TitleTextWidget(title: "Transaction List : "),
              Expanded(
                child: TransactionListWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
