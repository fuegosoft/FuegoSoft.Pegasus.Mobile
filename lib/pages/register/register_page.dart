import 'package:flutter/material.dart';
import 'package:fuegosoft_mobile/blocs/register/register_bloc.dart';
import 'package:fuegosoft_mobile/models/models.dart';
import 'package:fuegosoft_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:date_format/date_format.dart';
import 'dart:io' show Platform;

var _userRegisterFormKey = GlobalKey<FormState>();

var usernameController = TextEditingController();
var passwordController = TextEditingController();
var emailController = TextEditingController();
var contactController = TextEditingController();
var firstNameController = TextEditingController();
var middleNameController = TextEditingController();
var lastNameController = TextEditingController();
int _radioValue = 0;

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool test = false;
  bool notNull(Object o) => o != null;
  bool notNullGenderRadio(Object o) => o != null;
  bool usernameHasError = false;
  bool passwordHasError = false;
  bool emailAddressHasError = false;
  bool contactNumberHasError = false;
  bool firstNameHasError = false;
  bool middleNameHasError = false;
  bool lastNameHasError = false;
  bool selectGenderHasError = false;
  bool selectBirthDateHasError = false;
  bool hasNotSelectedGender = false;
  bool hasNotSelectedAge = false;
  String _radioResult = '';
  DateTime _datePicked = DateTime.now();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    contactController.dispose();
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: UserBloc(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: getColor(ColorList.DarkGreen, 1.0),
          ),
        ),
        body: Form(
          autovalidate: true,
          key: _userRegisterFormKey,
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      getColor(ColorList.DarkGreen, 1.0),
                      getColor(ColorList.LightGreen, 1.0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 40.0, bottom: 15.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: getColor(ColorList.WhiteCream, 1.0),
                                width: 2.0)),
                        margin: const EdgeInsets.only(top: 32.0),
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          height: 70,
                          width: 70,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/log-ayuda-black.png',
                              color: getColor(ColorList.WhiteCream, 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: FractionalOffset.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 32,
                          bottom: 15.0,
                        ),
                        child: Text(
                          'Register'.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              color: getColor(ColorList.WhiteCream, 1.0),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.41,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 20.0),
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // username
                      _usernameTextField(context),
                      SizedBox(
                        height: 30,
                      ),
                      // password
                      _passwordTextField(context),
                      SizedBox(
                        height: 30,
                      ),
                      // email address
                      _emailAddressTextField(context),
                      SizedBox(
                        height: 30,
                      ),
                      // Contact Number
                      _contactNumberTextField(context),
                      SizedBox(
                        height: 30,
                      ),
                      // First name
                      _firstNameTextField(context),
                      SizedBox(
                        height: 30,
                      ),
                      // middle name
                      _middleNameTextField(context),
                      SizedBox(
                        height: 30,
                      ),
                      // last name
                      _lastNameTextField(context),
                      SizedBox(
                        height: 30,
                      ),
                      // gender
                      _buildGenderRadioButton(context),
                      hasNotSelectedGender
                          ? Text(
                              'Please select a gender',
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 12.5),
                            )
                          : null,
                      SizedBox(
                        height: hasNotSelectedGender ? 15 : 0,
                      ),
                      // birthdate
                      _buildDateTimePicker(context),
                      SizedBox(
                        height: selectBirthDateHasError ? 15 : 10,
                      ),
                      selectBirthDateHasError
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                hasNotSelectedAge
                                    ? 'Please select your birthdate'
                                    : 'You must be 18 years old and above',
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 12.5),
                              ),
                            )
                          : null,
                      // register button
                      RegisterButton(
                        context: context,
                        username: usernameController.text,
                        password: passwordController.text,
                        emailAddress: emailController.text,
                        contactNumber: contactController.text,
                        firstName: firstNameController.text,
                        middleName: middleNameController.text,
                        lastName: lastNameController.text,
                        gender: _radioResult,
                        birthDate: _datePicked,
                        callBackGender: isGenderSelected,
                        callBackAge: isAgedNotSelected,
                      ),
                      _paddingSpace(false),
                    ].where(notNull).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _usernameTextField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: !usernameHasError ? Colors.black12 : Colors.redAccent,
              blurRadius: 5,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(50))),
      width: MediaQuery.of(context).size.width / 1.1,
      height: 50,
      padding: EdgeInsets.only(top: 4, left: 16, bottom: 4, right: 16),
      child: TextFormField(
        controller: usernameController,
        style: TextStyle(
          color: getColor(ColorList.DarkGreen, 1.0),
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Username',
          icon: Icon(
            Icons.person,
            color: Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.length < 5) {
            return "Username must have at least 6 characters";
          }
        },
      ),
    );
  }

  Widget _passwordTextField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: !passwordHasError ? Colors.black12 : Colors.redAccent,
              blurRadius: 5,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(50))),
      width: MediaQuery.of(context).size.width / 1.1,
      height: 50,
      padding: EdgeInsets.only(top: 4, left: 16, bottom: 4, right: 16),
      child: TextFormField(
        controller: passwordController,
        obscureText: true,
        style: TextStyle(
          color: getColor(ColorList.DarkGreen, 1.0),
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Password',
          icon: Icon(
            Icons.vpn_key,
            color: Colors.grey,
          ),
        ),
        validator: (String value) {
          if (value.length < 7) {
            return "Password must have at least 8 characters.";
          }
        },
      ),
    );
  }

  Widget _emailAddressTextField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: !emailAddressHasError ? Colors.black12 : Colors.redAccent,
              blurRadius: 5,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(50))),
      width: MediaQuery.of(context).size.width / 1.1,
      height: 50,
      padding: EdgeInsets.only(top: 4, left: 16, bottom: 4, right: 16),
      child: TextFormField(
        controller: emailController,
        style: TextStyle(
          color: getColor(ColorList.DarkGreen, 1.0),
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Email Address (user@domain.com)',
          icon: Icon(
            Icons.email,
            color: Colors.grey,
          ),
        ),
        validator: (String value) {
          if (isEmail(value) || value.isEmpty) {
            return "Invalid email address";
          }
        },
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _contactNumberTextField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: !contactNumberHasError ? Colors.black12 : Colors.redAccent,
              blurRadius: 5,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(50))),
      width: MediaQuery.of(context).size.width / 1.1,
      height: 50,
      padding: EdgeInsets.only(top: 4, left: 16, bottom: 4, right: 16),
      child: TextFormField(
        controller: contactController,
        style: TextStyle(
          color: getColor(ColorList.DarkGreen, 1.0),
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Contact Number (09XXXXXXXXX)',
          icon: Icon(
            Icons.phone,
            color: Colors.grey,
          ),
        ),
        validator: (String value) {
          if (isPHPhone(value) || value.isEmpty) {
            return "Invalid Philippines phone number";
          } else if (value.length < 10) {
            return "Phone number has 11 numbers";
          }
        },
        keyboardType: TextInputType.phone,
      ),
    );
  }

  Widget _firstNameTextField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: !firstNameHasError ? Colors.black12 : Colors.redAccent,
              blurRadius: 5,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(50))),
      width: MediaQuery.of(context).size.width / 1.1,
      height: 50,
      padding: EdgeInsets.only(top: 4, left: 16, bottom: 4, right: 16),
      child: TextFormField(
        controller: firstNameController,
        style: TextStyle(
          color: getColor(ColorList.DarkGreen, 1.0),
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 12.5),
          border: InputBorder.none,
          hintText: 'First Name',
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return "Input required";
          }
        },
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _middleNameTextField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(50))),
      width: MediaQuery.of(context).size.width / 1.1,
      height: 50,
      padding: EdgeInsets.only(top: 4, left: 16, bottom: 4, right: 16),
      child: TextFormField(
        controller: middleNameController,
        style: TextStyle(
          color: getColor(ColorList.DarkGreen, 1.0),
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 12.5),
          border: InputBorder.none,
          hintText: 'Middle Name (Optional)',
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _lastNameTextField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: !lastNameHasError ? Colors.black12 : Colors.redAccent,
              blurRadius: 5,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(50))),
      width: MediaQuery.of(context).size.width / 1.1,
      height: 50,
      padding: EdgeInsets.only(top: 4, left: 16, bottom: 4, right: 16),
      child: TextFormField(
        controller: lastNameController,
        style: TextStyle(
          color: getColor(ColorList.DarkGreen, 1.0),
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 12.5),
          border: InputBorder.none,
          hintText: 'Last Name',
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return "Input required";
          }
        },
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _buildDateTimePicker(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(50))),
      width: MediaQuery.of(context).size.width / 1.1,
      height: 50,
      padding: EdgeInsets.only(top: 4, left: 16, bottom: 4, right: 16),
      child: FlatButton(
        color: CupertinoColors.white,
        child: Text(
          formatDate(_datePicked, [MM, ' ', dd, ', ', 'yyyy']),
          style: TextStyle(
              color: !selectBirthDateHasError
                  ? getColor(ColorList.DarkGreen, 1.0)
                  : Colors.redAccent),
        ),
        onPressed: () {
          //selectBirthDate(context);
          //selectBirthDateCupertino(context);
          if (Platform.isIOS) {
            return showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return _buildCupertinoDateTime(context);
              },
            );
          } else if (Platform.isAndroid) {
            selectBirthDate(context);
          }
        },
      ),
    );
  }

  Widget _paddingSpace(bool hasError) {
    return Padding(
      padding: EdgeInsets.only(top: hasError ? 30 : 10),
    );
  }

  // cupertino datetime for iOS
  Widget _buildCupertinoDateTime(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      child: CupertinoDatePicker(
        onDateTimeChanged: (_dateTime) {
          if (_dateTime != null && isAge18AndUp(_dateTime)) {
            setState(() {
              selectBirthDateHasError = false;
              _datePicked = _dateTime;
            });
          } else {
            setState(() {
              selectBirthDateHasError = true;
              _datePicked = _dateTime;
            });
          }
        },
        mode: CupertinoDatePickerMode.date,
        initialDateTime: _datePicked,
        maximumDate: DateTime.now().add(Duration(days: 730)),
        maximumYear: DateTime.now().add(Duration(days: 730)).year,
        minimumDate: DateTime(1950),
        minimumYear: DateTime(1950).year,
      ),
    );
  }

  // material datetime for Android
  Future<Null> selectBirthDate(BuildContext context) async {
    DateTime picker = await showDatePicker(
      context: context,
      initialDate: _datePicked,
      firstDate: DateTime(1950),
      lastDate: _datePicked.add(Duration(days: 730)),
    );
    if (picker != null) {
      setState(() {
        picker = _datePicked;
      });
    }
  }

  Widget _buildGenderRadioButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      height: 75,
      child: Column(
        children: <Widget>[
          Text(
            'Select Gender',
            style: TextStyle(
                color: !selectGenderHasError
                    ? getColor(ColorList.DarkGreen, 1.0)
                    : Colors.redAccent),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Male',
                style: TextStyle(
                    color: !selectGenderHasError
                        ? getColor(ColorList.DarkGreen, 1.0)
                        : Colors.redAccent),
              ),
              Radio(
                activeColor: getColor(ColorList.DarkGreen, 1.0),
                onChanged: _handleGenderRadioValueChange,
                value: 1,
                groupValue: _radioValue,
              ),
              Text(
                'Female',
                style: TextStyle(
                    color: !selectGenderHasError
                        ? getColor(ColorList.DarkGreen, 1.0)
                        : Colors.redAccent),
              ),
              Radio(
                activeColor: getColor(ColorList.DarkGreen, 1.0),
                onChanged: _handleGenderRadioValueChange,
                value: 2,
                groupValue: _radioValue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void isAgedNotSelected() {
    setState(() {
      if (_datePicked.year == DateTime.now().year) {
        hasNotSelectedAge = true;
        selectBirthDateHasError = true;
      } else {
        selectBirthDateHasError = false;
        hasNotSelectedAge = false;
      }
    });
  }

  void isGenderSelected() {
    setState(() {
      if (_radioValue == 0)
        hasNotSelectedGender = true;
      else
        hasNotSelectedGender = false;
    });
  }

  void _handleGenderRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      if (value > 0) {
        switch (_radioValue) {
          case 1:
            _radioResult = 'Male';
            break;
          case 2:
            _radioResult = 'Female';
            break;
        }
        selectGenderHasError = false;
        hasNotSelectedGender = false;
      } else {
        selectGenderHasError = true;
        hasNotSelectedGender = true;
      }
    });
  }
}

class RegisterButton extends StatelessWidget {
  final BuildContext context;
  final String username;
  final String password;
  final String emailAddress;
  final String contactNumber;
  final String firstName;
  final String middleName;
  final String lastName;
  final String gender;
  final DateTime birthDate;
  final Function callBackGender;
  final Function callBackAge;

  RegisterButton(
      {Key key,
      this.context,
      this.username,
      this.password,
      this.emailAddress,
      this.contactNumber,
      this.firstName,
      this.middleName,
      this.lastName,
      this.gender,
      this.birthDate,
      this.callBackGender,
      this.callBackAge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width / 1.1,
      child: BlocProvider(
        bloc: UserBloc(),
        child: RaisedButton(
          child: Container(
            alignment: Alignment.center,
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Text(
              'register'.toUpperCase(),
              style: TextStyle(
                color: getColor(ColorList.WhiteCream, 1.0),
                fontSize: 20,
              ),
            ),
          ),
          onPressed: () {
            callBackGender();
            callBackAge();
            if (_userRegisterFormKey.currentState.validate()) {
              var user = User(
                  username,
                  password,
                  emailAddress,
                  contactNumber,
                  firstName,
                  middleName,
                  lastName,
                  gender,
                  birthDate.toString());

              userBloc.userSink.add(user);
              StreamBuilder<bool>(
                stream: userBloc.successStream,
                initialData: false,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.data) {
                    // implement loading while in creation process
                    // use username and password to login
                    // get token and save into common storage
                    // navigate to dashboard
                    User.init();
                  } else {
                    // return some data here
                  }
                },
              );
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
            side: BorderSide(
              color: getColor(ColorList.WhiteCream, 1.0),
              width: 2.0,
            ),
          ),
          color: getColor(ColorList.DarkGreen, 1.0),
        ),
      ),
    );
  }
}
