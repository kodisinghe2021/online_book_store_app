class ValidationHelper {
  int errorCode = 0;

  bool fieldsEmptyChecker(
    String email,
    String password,
    String name,
    String address,
    String nic,
    String contact01,
    String contact02,
  ) {
    bool isValid = false;
    errorCode = 3;
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        name.isNotEmpty &&
        nic.isNotEmpty &&
        address.isNotEmpty &&
        contact01.isNotEmpty &&
        contact02.isNotEmpty) {
      errorCode = 0;
      isValid = true;
    }
    return isValid;
  }

  bool emailValidation(
    String email,
    String password,
  ) {
    bool isValid = false;
    errorCode = 1;
    if (email.contains('@') && email.contains('.')) {
      errorCode = 0;
      isValid = true;
    }
    return isValid;
  }

  bool mobileNumerValidation(
    String contact01,
    String contact02,
  ) {
    bool isValid = false;
    errorCode = 2;
    if (contact01.length == 10 &&
        contact02.length == 10 &&
        int.tryParse(contact01) != null &&
        int.tryParse(contact02) != null) {
      errorCode = 0;
      isValid = true;
    }
    return isValid;
  }
}
