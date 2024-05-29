import 'package:club_cash/src/core/helpers/validators.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_box_shadow.dart';
import 'package:club_cash/src/core/widgets/k_drop_down_search_builder_with_title.dart';
import 'package:club_cash/src/core/widgets/k_icon_button.dart';
import 'package:club_cash/src/core/widgets/k_text_form_field_builder_with_title.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CashOutTransactionAddUpdatePageArguments {
  final String? existingTransaction;

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
  final formKey = GlobalKey<FormState>();
  final amountTextController = TextEditingController();
  final remarkTextController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (time != null && time != selectedTime) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.arguments.existingTransaction != null) {
      amountTextController.text = "100";
      remarkTextController.text = "Sample remark";
      selectedReason = "Equipment Purchase";
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
              Row(
                children: [
                  Expanded(
                    child: KTextFormFieldBuilderWithTitle(
                      title: 'Date',
                      hintText: DateFormat('dd-MM-yyyy').format(selectedDate),
                      inputAction: TextInputAction.next,
                      validator: Validators.emptyValidator,
                      readOnly: true,
                      prefixIconData: Icons.date_range,
                      onTap: () => _selectDate(context),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: KTextFormFieldBuilderWithTitle(
                      title: 'Time',
                      hintText: selectedTime.format(context),
                      inputAction: TextInputAction.next,
                      validator: Validators.emptyValidator,
                      readOnly: true,
                      prefixIconData: Icons.access_time_outlined,
                      onTap: () => _selectTime(context),
                    ),
                  ),
                ],
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

  void _onSave() {}
}

class _BottomNavigationBar extends StatelessWidget {
  final VoidCallback onSave;

  const _BottomNavigationBar({
    required this.onSave,
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
      child: KIconButton(
        onPressed: onSave,
        iconData: Icons.check,
        title: "save".toUpperCase(),
        bgColor: kRed,
      ),
    );
  }
}
