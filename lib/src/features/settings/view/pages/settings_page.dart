import 'package:club_cash/src/core/extensions/build_context_extension.dart';
import 'package:club_cash/src/core/helpers/validators.dart';
import 'package:club_cash/src/core/routes/routes.dart';
import 'package:club_cash/src/core/widgets/k_text_form_field_builder_with_title.dart';
import 'package:club_cash/src/features/message_template/model/message_template_model.dart';
import 'package:club_cash/src/features/message_template/view/pages/message_template_page.dart';
import 'package:club_cash/src/features/settings/controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _SendSMSOption(),
            _MessageTemplate(),
            _ChangePasswordOption(),
          ],
        ),
      ),
    );
  }
}

class _SendSMSOption extends StatelessWidget {
  const _SendSMSOption();

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    return Obx(() {
      return SwitchListTile(
        value: settingsController.isEnableSendSMS,
        onChanged: settingsController.changeSendSMSStatus,
        title: Text(
          'Send SMS',
          style: context.appTextTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        contentPadding: const EdgeInsets.only(
          bottom: 15,
        ),
        dense: true,
        subtitle: Text(
          "SMS Send for every transactions.",
          style: context.appTextTheme.bodySmall?.copyWith(
            fontSize: 11,
          ),
        ),
      );
    });
  }
}

class _MessageTemplate extends StatelessWidget {
  const _MessageTemplate();

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KTextFormFieldBuilderWithTitle(
            controller: TextEditingController(
              text: settingsController.selectedMessageTemplate?.title ?? '',
            ),
            title: 'Message Template',
            hintText: 'Select',
            inputAction: TextInputAction.next,
            validator: Validators.emptyValidator,
            readOnly: true,
            onTap: () => _onTapMessageTemplateField(settingsController),
            bottomPadding: 4,
            suffixIcon: settingsController.selectedMessageTemplate != null
                ? const Icon(Icons.change_circle_outlined)
                : const SizedBox.shrink(),
          ),
          if (settingsController.selectedMessageTemplate != null)
            Text(
              " Message : ${settingsController.selectedMessageTemplate?.message ?? ''}",
              style: context.appTextTheme.bodySmall?.copyWith(
                fontSize: 11,
              ),
            ),
          const SizedBox(height: 15),
        ],
      );
    });
  }

  void _onTapMessageTemplateField(SettingsController controller) async {
    var result = await Get.toNamed(
      RouteGenerator.messageTemplate,
      arguments: const MessageTemplateArgument(
        isSelectable: true,
      ),
    );

    if (result is MessageTemplateModel) {
      controller.changeMessageTemplate(result);
    }
  }
}

class _ChangePasswordOption extends StatelessWidget {
  const _ChangePasswordOption();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _onTapChangePassword,
      title: Text(
        'Change Password',
        style: context.appTextTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      contentPadding: const EdgeInsets.only(
        bottom: 15,
      ),
      dense: true,
      subtitle: Text(
        "Update your account password to keep your information secure.",
        style: context.appTextTheme.bodySmall?.copyWith(
          fontSize: 11,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 20,
      ),
    );
  }

  void _onTapChangePassword(){
    Get.toNamed(RouteGenerator.changePassword);
  }
}
