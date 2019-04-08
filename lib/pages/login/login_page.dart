import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuegosoft_mobile/animations/login_animation.dart';
import 'package:flutter/animation.dart';

class LoginPage extends StatefulWidget {
  final Widget child;

  LoginPage({Key key, this.child}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  AnimationController _loginButtonController;
  var clickStatus = 0;
  bool hasError = false;
  var _formKey = GlobalKey<FormState>();
  var _usernameTextController = TextEditingController();
  var _passwordTextController = TextEditingController();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
    _loginButtonController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    await _loginButtonController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xFF458534),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ListView(
                physics: const ClampingScrollPhysics(),
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF458534),
                          Color(0xFF7BB35A),
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
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/log-ayuda-black.png',
                            height: 85,
                            width: 85,
                            color: Colors.white,
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 32,
                              bottom: 28,
                            ),
                            child: Text(
                              'Login'.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 32),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: !hasError
                                      ? Colors.black12
                                      : Colors.redAccent,
                                  blurRadius: 5,
                                )
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          width: MediaQuery.of(context).size.width / 1.1,
                          height: 50,
                          padding: EdgeInsets.only(
                              top: 4, left: 16, bottom: 4, right: 16),
                          child: TextFormField(
                            controller: _usernameTextController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email/Username',
                              icon: Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                            ),
                            validator: (String value) {
                              if (value.length < 5) {
                                return "Invalid email/username input";
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: !hasError
                                      ? Colors.black12
                                      : Colors.redAccent,
                                  blurRadius: 5,
                                )
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          width: MediaQuery.of(context).size.width / 1.1,
                          height: 50,
                          padding: EdgeInsets.only(
                              top: 4, left: 16, bottom: 4, right: 16),
                          child: TextFormField(
                            controller: _passwordTextController,
                            obscureText: true,
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
                                return "Invalid password input";
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    width: MediaQuery.of(context).size.width,
                    child: SafeArea(
                      child: Column(
                        children: <Widget>[
                          clickStatus == 0
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (_formKey.currentState.validate()) {
                                        clickStatus = 1;
                                        _playAnimation();
                                      } else {
                                        hasError = true;
                                      }
                                    });
                                    // when complete, if has error login
                                    // popup snackbar error
                                    // else popup to dashboard.
                                  },
                                  child: SignIn(),
                                )
                              : LoginAnimation(
                                  buttonController: _loginButtonController.view,
                                  context: context,
                                  username: _usernameTextController.text,
                                  password: _passwordTextController.text,
                                ),
                          SizedBox(height: 10),
                          SignUp()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            Color(0xFF458534),
            Color(0xFF7BB35A),
          ],
        ),
      ),
      child: Text(
        'sign in'.toUpperCase(),
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: () {},
        child: Text('Forgot your password?'),
      ),
    );
  }
}

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        child: Text("Forgot your password?"),
        onPressed: () {},
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );
  }
}
