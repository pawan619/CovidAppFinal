class FormValidation {
  // * Email Validation
  static String emailValidation(value) {
    if (value.isEmpty) {
      return "*Required";
    }

    String emailPattern = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(emailPattern);
    if (regExp.hasMatch(value)) {
      return null;
    } else {
      return 'Please enter a valid email ID';
    }
  }

// * Password Validation
  static String passwordValidation(value) {
    if (value.isEmpty) {
      return "*Required";
    }
    String passwordPattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,14}$';
    RegExp regExp = RegExp(passwordPattern);
    if (regExp.hasMatch(value)) {
      return null;
    } else {
      return "Password length must be between 8-14\nAtleast 1 uppercase\nAtleast 1 lowercase\nAtleast 1 number\nAtleast 1 special character : !@#\$&*~ ";
    }
  }

  //SignUp validation
  //* Name validation
  static String nameValidation(value) {
    if (value.isEmpty) {
      return "*Required";
    } else if (value.length <= 2) {
      return "Please enter a valid name";
    } else
      return null;
  }

  //* Phone Number Validation
  static String phoneNumberValidation(value) {
    if (value.isEmpty) {
      return "*Required";
    } else if (value.length < 10) {
      return "Please enter 10 digit phone number";
    } else
      return null;
  }
}
