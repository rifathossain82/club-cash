import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/failure_widget_builder.dart';
import 'package:club_cash/src/core/widgets/k_custom_loader.dart';
import 'package:club_cash/src/features/home/controller/transaction_controller.dart';
import 'package:club_cash/src/features/home/view/widgets/transaction_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionListWidget extends StatelessWidget {
  const TransactionListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();
    return Obx(() {
      return transactionController.isLoadingTransactionList.value
          ? const KCustomLoader()
          : transactionController.transactionList.isEmpty
              ? const _TransactionFailureWidget()
              : _TransactionList(controller: transactionController);
    });
  }
}

class _TransactionFailureWidget extends StatelessWidget {
  const _TransactionFailureWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const FailureWidgetBuilder(),
    );
  }
}

class _TransactionList extends StatelessWidget {
  final TransactionController controller;

  const _TransactionList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15),
      itemCount: controller.transactionList.length,
      itemBuilder: (context, index) => TransactionItemWidget(
        transaction: controller.transactionList[index],
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
