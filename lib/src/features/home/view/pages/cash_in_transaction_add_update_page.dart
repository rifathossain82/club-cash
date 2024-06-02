import 'package:club_cash/src/core/enums/app_enum.dart';
import 'package:club_cash/src/core/extensions/date_time_extension.dart';
import 'package:club_cash/src/core/extensions/string_extension.dart';
import 'package:club_cash/src/core/helpers/logger.dart';
import 'package:club_cash/src/core/helpers/validators.dart';
import 'package:club_cash/src/core/routes/routes.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_box_shadow.dart';
import 'package:club_cash/src/core/widgets/k_drop_down_field_builder_with_title.dart';
import 'package:club_cash/src/core/widgets/k_icon_button.dart';
import 'package:club_cash/src/core/widgets/k_text_form_field_builder_with_title.dart';
import 'package:club_cash/src/features/home/controller/transaction_controller.dart';
import 'package:club_cash/src/features/home/model/transaction_model.dart';
import 'package:club_cash/src/features/member/model/member_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashInTransactionAddUpdatePageArguments {
  final TransactionModel? existingTransaction;

  CashInTransactionAddUpdatePageArguments({
    this.existingTransaction,
  });
}

class CashInTransactionAddUpdatePage extends StatefulWidget {
  final CashInTransactionAddUpdatePageArguments arguments;

  const CashInTransactionAddUpdatePage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<CashInTransactionAddUpdatePage> createState() =>
      _TransactionAddUpdatePageState();
}

class _TransactionAddUpdatePageState
    extends State<CashInTransactionAddUpdatePage> {
  final transactionController = Get.find<TransactionController>();
  TransactionModel? existingTransaction;
  final formKey = GlobalKey<FormState>();
  final amountTextController = TextEditingController();
  final remarkTextController = TextEditingController();
  DateTime? selectedDateTime = DateTime.now();
  MemberModel? selectedMember;
  PaymentMethod? selectedPaymentMethod;

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime!,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.arguments.existingTransaction != null) {
        existingTransaction = widget.arguments.existingTransaction;

        selectedDateTime = existingTransaction?.datetime;
        selectedMember = MemberModel(
          id: existingTransaction?.member?.id,
          name: existingTransaction?.member?.name,
        );
        amountTextController.text = "${existingTransaction?.amount ?? 0}";
        selectedPaymentMethod = getSelectedPaymentMethod(existingTransaction);
        remarkTextController.text = existingTransaction?.remarks ?? '';
      }

      setState(() {});
    });
  }

  PaymentMethod getSelectedPaymentMethod(
      TransactionModel? existingTransaction) {
    if (existingTransaction?.paymentMethod == PaymentMethod.cash.name) {
      return PaymentMethod.cash;
    } else if (existingTransaction?.paymentMethod == PaymentMethod.bkash.name) {
      return PaymentMethod.bkash;
    } else {
      return PaymentMethod.cash;
    }
  }

  @override
  void dispose() {
    amountTextController.dispose();
    remarkTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.arguments.existingTransaction != null
        ? "Update Cash In Transaction"
        : "Add Cash In Transaction";

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _transactionFormWidget(),
      bottomNavigationBar: _BottomNavigationBar(
        onSave: _onSave,
        transactionController: transactionController,
      ),
    );
  }

  Widget _transactionFormWidget() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KTextFormFieldBuilderWithTitle(
                title: 'Date & Time',
                hintText: selectedDateTime?.formattedDateTime,
                inputAction: TextInputAction.next,
                readOnly: true,
                prefixIconData: Icons.date_range,
                onTap: () => _selectDateTime(context),
              ),
              KTextFormFieldBuilderWithTitle(
                controller: TextEditingController(
                  text: selectedMember?.name ?? '',
                ),
                title: 'Member',
                hintText: 'Select',
                inputAction: TextInputAction.next,
                validator: Validators.emptyValidator,
                readOnly: true,
                onTap: _onTapMemberField,
              ),
              KTextFormFieldBuilderWithTitle(
                controller: amountTextController,
                title: 'Amount',
                hintText: '0',
                inputAction: TextInputAction.next,
                inputType: TextInputType.number,
                validator: Validators.emptyValidator,
              ),
              KDropDownFieldBuilderWithTitle<PaymentMethod>(
                title: 'Payment Method',
                hintText: 'Select',
                validatorActive: true,
                isLoading: false,
                value: selectedPaymentMethod,
                items: PaymentMethod.values.map((method) => method).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value;
                  });
                },
                itemBuilder: (item) => Text(item?.name.capitalizedFirst ?? ''),
              ),
              KTextFormFieldBuilderWithTitle(
                controller: remarkTextController,
                title: 'Remarks',
                inputAction: TextInputAction.next,
                inputType: TextInputType.text,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapMemberField() async {
    var result = await Get.toNamed(
      RouteGenerator.memberListPage,
      arguments: true,
    );

    if (result is MemberModel) {
      setState(() {
        selectedMember = result;
        Log.info(selectedMember?.id ?? '');
      });
    }
  }

  void _onSave() {
    if (formKey.currentState!.validate()) {
      if (existingTransaction == null) {
        addNewTransaction();
      } else {
        updateTransaction();
      }
    }
  }

  void addNewTransaction() {
    final newTransaction = TransactionModel(
      datetime: selectedDateTime,
      member: Member(
        id: selectedMember?.id,
        name: selectedMember?.name,
      ),
      amount: num.parse(amountTextController.text),
      paymentMethod: selectedPaymentMethod?.name,
      remarks: remarkTextController.text.trim(),
      type: TransactionType.cashIn.name,
      timestamp: DateTime.now(),
    );

    transactionController
        .addTransaction(transaction: newTransaction)
        .then((value) => Navigator.pop(context));
  }

  void updateTransaction() {
    final newTransaction = TransactionModel(
      id: existingTransaction?.id,
      datetime: selectedDateTime,
      member: Member(
        id: selectedMember?.id,
        name: selectedMember?.name,
      ),
      amount: num.parse(amountTextController.text),
      paymentMethod: selectedPaymentMethod?.name,
      remarks: remarkTextController.text.trim(),
      type: TransactionType.cashIn.name,
      timestamp: DateTime.now(),
    );

    transactionController
        .updateTransaction(transaction: newTransaction)
        .then((value) => Navigator.pop(context));
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final VoidCallback onSave;
  final TransactionController transactionController;

  const _BottomNavigationBar({
    required this.onSave,
    required this.transactionController,
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
      child: Obx(() {
        return KIconButton(
          onPressed: onSave,
          iconData: Icons.check,
          title: "save".toUpperCase(),
          bgColor: kGreen,
          isLoading: transactionController.isAddingTransaction.value ||
              transactionController.isUpdatingTransaction.value,
        );
      }),
    );
  }
}
