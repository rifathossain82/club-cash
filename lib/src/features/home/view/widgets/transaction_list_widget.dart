import 'package:club_cash/src/features/home/view/widgets/transaction_item_widget.dart';
import 'package:flutter/material.dart';

class TransactionListWidget extends StatelessWidget {
  const TransactionListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(15),
      itemCount: 8,
      itemBuilder: (context, index) => const TransactionItemWidget(),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
