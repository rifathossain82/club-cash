class Message {

  /// validation message
  static const String emptyName = "Name is empty!";
  static const String emptyEmail = "Email Address is empty!";
  static const String invalidEmail = "Invalid Email Address!";
  static const String emptyPhone = "Phone Number is empty!";
  static const String invalidPhone = "Invalid Phone Number!";
  static const String emptyPassword = "Password is empty!";
  static const String invalidPassword = "Password must be at least 6 characters!";
  static const String emptyOldPassword = "Please enter your old password!";
  static const String emptyNewPassword = "Please enter your new password!";
  static const String emptyConfirmPassword = "Please enter your confirm password!";
  static const String emptyOTP = "Please enter OTP!";
  static const String invalidOTP = "OTP must be 6 characters!";
  static const String invalidCustomerGroupAmount = "The amount must be at least 1!";
  static const String emptyMessage = "Message is empty!";
  static const String emptyField = 'This field is required!';
  static const String exchangeQuantityAlert = "Quantity cannot be increased further.";


  /// network error message
  static const String noInternet = "Please check your connection!";
  static const String error401 = "Unauthorized!";
  static const String error404 = "Page Not Found!";
  static const String error500 = "Server Error!";
  static const String unknown = "Something went wrong!";
  static const String badResponse = "Bad response format!";
}