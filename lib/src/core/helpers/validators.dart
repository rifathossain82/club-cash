import 'package:club_cash/src/core/errors/messages.dart';
import 'package:club_cash/src/core/extensions/string_extension.dart';

class Validators {
  static String? emptyValidator(value) {
    if (value.toString().isEmpty) {
      return Message.emptyField;
    }
    return null;
  }

  static String? emailValidator(value) {
    if (value.toString().isEmpty) {
      return Message.emptyEmail;
    } else if (!value.toString().isValidEmail) {
      return Message.invalidEmail;
    }
    return null;
  }

  static String? dropDownValidator(value) {
    if (value == null) {
      return Message.emptyField;
    }
    return null;
  }

  static String? multiSelectDropDownValidator<T>(List<T>? items) {
    if (items!.isEmpty) {
      return Message.emptyField;
    }
    return null;
  }

  static String? phoneNumberValidator(value) {
    if (value.toString().isEmpty) {
      return Message.emptyPhone;
    }
    return null;
  }

  static String? passwordValidator(value) {
    if (value.toString().isEmpty) {
      return Message.emptyPassword;
    } else if (value.toString().length < 6) {
      return Message.invalidPassword;
    }
    return null;
  }

  static String? otpValidator(value) {
    if (value.toString().isEmpty) {
      return Message.emptyOTP;
    } else if (value.toString().length != 6) {
      return Message.invalidOTP;
    }
    return null;
  }
}
