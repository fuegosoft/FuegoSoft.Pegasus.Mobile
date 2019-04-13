class User {
  String username;
  String password;
  String emailAddress;
  String contactNumber;
  String firstName;
  String middleName;
  String lastName;
  String gender;
  String birthDate;

  User(
      {this.username,
      this.password,
      this.emailAddress,
      this.contactNumber,
      this.firstName,
      this.middleName,
      this.lastName,
      this.gender,
      this.birthDate});

  User.init() {
    this.username = "";
    this.password = "";
    this.emailAddress = "";
    this.contactNumber = "";
    this.firstName = "";
    this.middleName = "";
    this.lastName = "";
    this.gender = "";
    this.birthDate = "";
  }

  User.fromJsonBody(Map json)
      : username = json['username'],
        password = json['password'],
        emailAddress = json['emailAddress'],
        contactNumber = json['contactNumber'],
        firstName = json['firstName'],
        middleName = json['middleName'],
        lastName = json['lastName'],
        gender = json['gender'],
        birthDate = json['birthDate'];
}
