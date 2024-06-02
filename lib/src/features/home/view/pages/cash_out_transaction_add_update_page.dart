import 'package:club_cash/src/core/enums/app_enum.dart';
import 'package:club_cash/src/core/extensions/date_time_extension.dart';
import 'package:club_cash/src/core/helpers/validators.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_box_shadow.dart';
import 'package:club_cash/src/core/widgets/k_drop_down_search_builder_with_title.dart';
import 'package:club_cash/src/core/widgets/k_icon_button.dart';
import 'package:club_cash/src/core/widgets/k_text_form_field_builder_with_title.dart';
import 'package:club_cash/src/features/home/controller/transaction_controller.dart';
import 'package:club_cash/src/features/home/model/transaction_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashOutTransactionAddUpdatePageArguments {
  final TransactionModel? existingTransaction;

  CashOutTransactionAddUpdatePageArguments({
    this.existingTransaction,
  });
}

class CashOutTransactionAddUpdatePage extends StatefulWidget {
  final CashOutTransactionAddUpdatePageArguments arguments;

  const CashOutTransactionAddUpdatePage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<CashOutTransactionAddUpdatePage> createState() =>
      _TransactionAddUpdatePageState();
}

class _TransactionAddUpdatePageState
    extends State<CashOutTransactionAddUpdatePage> {
  final transactionController = Get.find<TransactionController>();
  TransactionModel? existingTransaction;
  final formKey = GlobalKey<FormState>();
  final amountTextController = TextEditingController();
  final remarkTextController = TextEditingController();
  DateTime? selectedDateTime = DateTime.now();
  String? selectedReason;

  final List<String> cashOutReasons = const [
    "Equipment Purchase",
    "Travel Expenses",
    "Match Day Expenses",
    "Stadium Maintenance",
    "Training Facilities",
    "Medical Expenses",
    "Marketing and Promotion",
    "Youth Development Programs",
    "Scouting Expenses",
    "Legal Fees",
    "Administrative Expenses",
    "Charity Donations",
    "Event Hosting",
    "Miscellaneous",
    "Others",
  ];

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
        amountTextController.text = "${existingTransaction?.amount ?? 0}";
        selectedReason = existingTransaction?.reason ?? '';
        remarkTextController.text = existingTransaction?.remarks ?? '';
      }

      setState(() {});
    });
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
        ? "Update Cash Out Transaction"
        : "Add Cash Out Transaction";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
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
                controller: amountTextController,
                title: 'Amount',
                hintText: '0',
                inputAction: TextInputAction.next,
                inputType: TextInputType.number,
                validator: Validators.emptyValidator,
              ),
              KDropDownSearchBuilderWithTitle<String>(
                title: 'Cash Out Reason',
                hintText: 'Select Reason',
                validator: Validators.dropDownValidator,
                value: selectedReason,
                items: cashOutReasons,
                onChanged: (value) {
                  setState(() {
                    selectedReason = value;
                  });
                },
                itemAsString: (item) => item ?? '',
                showSearchBox: false,
                isBottomSheetMode: true,
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

  void _onSave() {
    if (formKey.currentState!.validate()) {
      if (existingTransaction == null) {
        addCashOutTransaction();
      } else {
        updateCashOutTransaction();
      }
    }
  }

  void addCashOutTransaction() {
    final cashOutTransaction = TransactionModel(
      datetime: selectedDateTime,
      amount: num.parse(amountTextController.text),
      reason: selectedReason,
      remarks: remarkTextController.text.trim(),
      type: TransactionType.cashOut.name,
      timestamp: DateTime.now(),
    );

    transactionController
        .addTransaction(transaction: cashOutTransaction)
        .then((value) => Navigator.pop(context));
  }

  void updateCashOutTransaction() {
    final cashOutTransaction = TransactionModel(
      id: existingTransaction?.id,
      datetime: selectedDateTime,
      amount: num.parse(amountTextController.text),
      reason: selectedReason,
      remarks: remarkTextController.text.trim(),
      type: TransactionType.cashOut.name,
      timestamp: DateTime.now(),
    );

    transactionController
        .updateTransaction(transaction: cashOutTransaction)
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
