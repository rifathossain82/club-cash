import 'package:club_cash/src/core/enums/app_enum.dart';
import 'package:club_cash/src/core/extensions/string_extension.dart';
import 'package:club_cash/src/core/helpers/validators.dart';
import 'package:club_cash/src/core/routes/routes.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_blank_field_builder_with_title.dart';
import 'package:club_cash/src/core/widgets/k_box_shadow.dart';
import 'package:club_cash/src/core/widgets/k_drop_down_field_builder_with_title.dart';
import 'package:club_cash/src/core/widgets/k_icon_button.dart';
import 'package:club_cash/src/core/widgets/k_text_form_field_builder_with_title.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionAddUpdatePageArguments {
  final bool isCashIn;
  final String? existingTransaction;

  TransactionAddUpdatePageArguments({
    required this.isCashIn,
    this.existingTransaction,
  });
}

class TransactionAddUpdatePage extends StatefulWidget {
  final TransactionAddUpdatePageArguments arguments;

  const TransactionAddUpdatePage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<TransactionAddUpdatePage> createState() =>
      _TransactionAddUpdatePageState();
}

class _TransactionAddUpdatePageState extends State<TransactionAddUpdatePage> {
  final formKey = GlobalKey<FormState>();
  final amountTextController = TextEditingController();
  final remarkTextController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String? selectedMember;
  String? selectedPaymentMethod;

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
  }

  @override
  void dispose() {
    amountTextController.dispose();
    remarkTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String action =
        widget.arguments.existingTransaction != null ? "Update" : "Add";
    String transactionType = widget.arguments.isCashIn
        ? "Cash In Transaction"
        : "Cash Out Transaction";

    String title = "$action $transactionType";

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _transactionFormWidget(),
      bottomNavigationBar: _BottomNavigationBar(
        onSave: _onSave,
        isCashIn: widget.arguments.isCashIn,
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
              KBlankFieldBuilderWithTitle(
                title: "Member",
                content: Text("Rahim"),
                onTap: () async {
                  Get.toNamed(
                    RouteGenerator.memberListPage,
                    arguments: true,
                  );
                },
              ),
              KTextFormFieldBuilderWithTitle(
                controller: amountTextController,
                title: 'Amount',
                hintText: '0',
                inputAction: TextInputAction.next,
                inputType: TextInputType.number,
                validator: Validators.emptyValidator,
              ),
              KDropDownFieldBuilderWithTitle<String>(
                title: 'Payment Method',
                hintText: 'Select',
                validatorActive: true,
                isLoading: false,
                value: selectedPaymentMethod,
                items: PaymentMethod.values
                    .map((method) => method.name.capitalizedFirst)
                    .toList(),
                onChanged: (value) {
                  // setState(() {
                  //   selectedArea = value;
                  // });
                },
                itemBuilder: (item) => Text(item ?? ''),
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
  final bool isCashIn;

  const _BottomNavigationBar({
    required this.onSave,
    required this.isCashIn,
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
        bgColor: isCashIn ? kGreen : kRed,
      ),
    );
  }
}
