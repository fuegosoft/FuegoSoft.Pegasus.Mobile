bool isEmail(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(email);
}

bool isPHPhone(String phone) {
  String p = r'^(09|\+639)\d{9}$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(phone);
}

bool isAge18AndUp(DateTime birthDate) {
  return DateTime.now().difference(birthDate).inDays / 365.floor() >= 18;
}
