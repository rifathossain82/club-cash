import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/helpers/validators.dart';
import 'package:club_cash/src/core/utils/app_constants.dart';
import 'package:club_cash/src/core/utils/color.dart';
import 'package:club_cash/src/core/widgets/k_icon_button.dart';
import 'package:club_cash/src/core/widgets/k_text_form_field_builder_with_title.dart';
import 'package:club_cash/src/features/message_template/controller/message_template_controller.dart';
import 'package:club_cash/src/features/message_template/model/message_template_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> templateAddUpdateBottomSheet({
  required BuildContext context,
  MessageTemplateModel? existingTemplate,
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
      return TemplateAddUpdateForm(
        existingTemplate: existingTemplate,
      );
    },
  );
}

class TemplateAddUpdateForm extends StatefulWidget {
  final MessageTemplateModel? existingTemplate;

  const TemplateAddUpdateForm({
    Key? key,
    this.existingTemplate,
  }) : super(key: key);

  @override
  State<TemplateAddUpdateForm> createState() => _MemberAddUpdateFormState();
}

class _MemberAddUpdateFormState extends State<TemplateAddUpdateForm> {
  final _controller = Get.find<MessageTemplateController>();
  final _formKey = GlobalKey<FormState>();
  final _titleTextController = TextEditingController();
  final _messageTextController = TextEditingController();
  final _titleFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _titleFocusNode.requestFocus();

      if (widget.existingTemplate != null) {
        _titleTextController.text = widget.existingTemplate?.title ?? '';
        _messageTextController.text = widget.existingTemplate?.message ?? '';
      }
    });
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _messageTextController.dispose();
    _titleFocusNode.dispose();
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
                  widget.existingTemplate != null
                      ? "Update Message Template"
                      : "Add Message Template",
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
                      title: "Title",
                      hintText: "Enter title",
                      focusNode: _titleFocusNode,
                      controller: _titleTextController,
                      validator: Validators.emptyValidator,
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                    ),
                    KTextFormFieldBuilderWithTitle(
                      title: "Message",
                      hintText: "Enter message",
                      controller: _messageTextController,
                      validator: Validators.emptyValidator,
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.done,
                      maxLine: 4,
                    ),
                    Text(
                      AppConstants.messageTemplateAlertText,
                      style: context.appTextTheme.bodySmall?.copyWith(
                        fontSize: 11,
                        color: kRedDeep,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      return KIconButton(
                        onPressed: _onSave,
                        iconData: Icons.check,
                        title: "save".toUpperCase(),
                        bgColor: kPrimaryColor,
                        isLoading: _controller.isAddingTemplate.value ||
                            _controller.isUpdatingTemplate.value,
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

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      if (widget.existingTemplate == null) {
        _addNewTemplate();
      } else {
        _updateTemplate();
      }
    }
  }

  void _addNewTemplate() {
    final newTemplate = MessageTemplateModel(
      title: _titleTextController.text.trim(),
      message: _messageTextController.text.trim(),
      timestamp: DateTime.now(),
    );

    _controller
        .addTemplate(template: newTemplate)
        .then((value) => Navigator.pop(context));
  }

  void _updateTemplate() {
    final newTemplate = MessageTemplateModel(
      id: widget.existingTemplate?.id,
      title: _titleTextController.text.trim(),
      message: _messageTextController.text.trim(),
      timestamp: DateTime.now(),
    );

    _controller
        .updateTemplate(template: newTemplate)
        .then((value) => Navigator.pop(context));
  }
}
