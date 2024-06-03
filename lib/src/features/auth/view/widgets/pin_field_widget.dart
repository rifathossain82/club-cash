import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:style_mart_brand/src/core/extensions/build_context_extension.dart';
import 'package:style_mart_brand/src/core/helpers/helper_methods.dart';
import 'package:style_mart_brand/src/core/utils/color.dart';

class PinFieldWidget extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? fieldController;
  final IconData? icon;
  final int? maxLines;
  final String? preText;
  final Color? fillColor;
  final bool? isProtected;
  final bool? isEditable;
  final bool? centerText;
  final FocusNode? focusNode;
  final TextInputType? keyType;
  final Function? validation;

  const PinFieldWidget({
    Key? key,
    this.preText,
    this.isEditable,
    this.maxLines,
    this.centerText = false,
    this.focusNode,
    this.labelText,
    this.fillColor,
    this.isProtected = false,
    this.hintText,
    this.icon = Icons.cancel,
    this.fieldController,
    this.keyType,
    this.validation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: context.screenWidth * 0.11,
        fieldWidth: context.screenWidth * 0.11,
        activeFillColor: Colors.white,
        activeColor: kPrimaryColor,
        inactiveColor: kGreyLight,
        inactiveFillColor: kGreyLight,
        selectedColor: kPrimaryColor,
        selectedFillColor: kPrimaryColor.withOpacity(0.15),
      ),
      animationDuration: const Duration(milliseconds: 300),
      //backgroundColor: Colors.blue.shade50,
      enableActiveFill: true,
      controller: fieldController,
      onCompleted: (v) {
        kPrint("Completed");
      },
      onChanged: (value) {
        kPrint(value);
      },
      beforeTextPaste: (text) {
        kPrint("Allowing to paste $text");

        /// if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        /// but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
      appContext: context,
    );
  }
}
