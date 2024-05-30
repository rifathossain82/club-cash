import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/helpers/validators.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_icon_button.dart';
import 'package:club_cash/src/core/widgets/k_text_form_field_builder_with_title.dart';
import 'package:club_cash/src/features/member/controller/member_controller.dart';
import 'package:club_cash/src/features/member/model/member_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> memberAddUpdateBottomSheet({
  required BuildContext context,
  MemberModel? existingMember,
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
  final MemberModel? existingMember;

  const MemberAddUpdateForm({Key? key, this.existingMember}) : super(key: key);

  @override
  State<MemberAddUpdateForm> createState() => _MemberAddUpdateFormState();
}

class _MemberAddUpdateFormState extends State<MemberAddUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _memberController = Get.find<MemberController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nameFocusNode.requestFocus();

      if (widget.existingMember != null) {
        _nameTextController.text = widget.existingMember?.name ?? '';
        _phoneTextController.text = widget.existingMember?.phone ?? '';
      }
    });
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _phoneTextController.dispose();
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
                      title: "Phone Number",
                      hintText: "Enter phone number",
                      controller: _phoneTextController,
                      validator: Validators.phoneNumberValidator,
                      inputType: TextInputType.phone,
                      inputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      return KIconButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (widget.existingMember != null) {
                              _memberController
                                  .updateMember(
                                member: MemberModel(
                                  id: widget.existingMember?.id,
                                  name: _nameTextController.text.trim(),
                                  phone: _phoneTextController.text.trim(),
                                ),
                              )
                                  .then((value) => Navigator.pop(context));
                            } else {
                              _memberController
                                  .addMember(
                                    member: MemberModel(
                                      name: _nameTextController.text.trim(),
                                      phone: _phoneTextController.text.trim(),
                                    ),
                                  )
                                  .then((value) => Navigator.pop(context));
                            }
                          }
                        },
                        iconData: Icons.check,
                        title: "save".toUpperCase(),
                        isLoading: _memberController.isAddingMember.value ||
                            _memberController.isUpdatingMember.value,
                      );
                    }),
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
