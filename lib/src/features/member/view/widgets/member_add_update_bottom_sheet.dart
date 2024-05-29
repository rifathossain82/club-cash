import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/helpers/validators.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_icon_button.dart';
import 'package:club_cash/src/core/widgets/k_text_form_field_builder_with_title.dart';
import 'package:flutter/material.dart';

Future<void> memberAddUpdateBottomSheet({
  required BuildContext context,
  String? existingMember,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    builder: (context) {
      return MemberAddUpdateForm(
        existingMember: existingMember,
      );
    },
  );
}

class MemberAddUpdateForm extends StatefulWidget {
  final String? existingMember;

  const MemberAddUpdateForm({Key? key, this.existingMember}) : super(key: key);

  @override
  State<MemberAddUpdateForm> createState() => _MemberAddUpdateFormState();
}

class _MemberAddUpdateFormState extends State<MemberAddUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _numberTextController = TextEditingController();
  final _nameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nameFocusNode.requestFocus();

      if(widget.existingMember != null){
        // _nameTextController.text = widget.existingMember!;
        // _numberTextController.text = widget.existingMember!;
      }
    });
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _numberTextController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading and close button
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: kBlackLight,
                    size: 20,
                  ),
                ),
                Text(
                  widget.existingMember != null
                      ? "Update Member"
                      : "Add Member",
                  style: context.appTextTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Divider(height: 0),

            /// Member name, mobile number
            Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    KTextFormFieldBuilderWithTitle(
                      title: "Name",
                      hintText: "Enter member name",
                      focusNode: _nameFocusNode,
                      controller: _nameTextController,
                      validator: Validators.emptyValidator,
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    KTextFormFieldBuilderWithTitle(
                      title: "Mobile Number",
                      hintText: "Enter mobile number",
                      controller: _numberTextController,
                      validator: Validators.phoneNumberValidator,
                      inputType: TextInputType.phone,
                      inputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 10),
                    KIconButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Add your member add/update logic here
                          Navigator.pop(context); // Close the bottom sheet
                        }
                      },
                      iconData: Icons.check,
                      title: "save".toUpperCase(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
