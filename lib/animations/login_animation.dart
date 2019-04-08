import 'package:flutter/material.dart';
import 'package:fuegosoft_mobile/blocs/login/login.dart';
import 'package:fuegosoft_mobile/models/models.dart';
import 'package:fuegosoft_mobile/utils/utils.dart';

class LoginAnimation extends StatefulWidget {
  final AnimationController buttonController;
  final Animation shrinkButtonAnimation;
  final Animation zoomOutAnimation;
  final Animation bounceAnimation;
  final BuildContext context;
  final String username;
  final String password;

  LoginAnimation(
      {Key key,
      this.buttonController,
      this.context,
      this.username,
      this.password})
      : shrinkButtonAnimation =
            new Tween(begin: MediaQuery.of(context).size.width, end: 60.0)
                .animate(
          CurvedAnimation(
            parent: buttonController,
            curve: Interval(0.0, 0.150),
          ),
        ),
        zoomOutAnimation = new Tween(begin: 60, end: 900.0).animate(
          CurvedAnimation(
              parent: buttonController,
              curve: Interval(0.555, 0.999, curve: Curves.bounceInOut)),
        ),
        bounceAnimation = Tween(begin: 0.0, end: 45.0).animate(
          CurvedAnimation(
              parent: buttonController,
              curve: Interval(0.5, 1.0, curve: Curves.bounceInOut)),
        ),
        super(key: key);

  _LoginAnimationState createState() => _LoginAnimationState();

  Widget _buildAnimation(BuildContext context, Widget child) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

    var login = Login(username, password);
    loginBloc.loginSink.add(login);

    return Container(
      child: zoomOutAnimation.value <= 300
          ? Container(
              alignment: Alignment.center,
              height: 60,
              width: shrinkButtonAnimation.value,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF458534),
                    Color(0xFF7BB35A),
                  ],
                ),
              ),
              child: shrinkButtonAnimation.value > 60
                  ? Text(
                      'sign in'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )
                  : CircularProgressIndicator(
                      strokeWidth: 1.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
            )
          : StreamBuilder<Token>(
              stream: loginBloc.tokenStream,
              initialData: Token.initial(),
              builder: (BuildContext context, AsyncSnapshot<Token> snapshot) {
                if (snapshot.data.token.isNotEmpty) {
                  return Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF458534),
                            Color(0xFF7BB35A),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(60)),
                    width: 60,
                    height: 60,
                    child: Icon(
                      Icons.check,
                      size: bounceAnimation.value,
                      color: Colors.white,
                    ),
                  );
                } else {
                  // reanimate reverse
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(60)),
                    width: 60,
                    height: 60,
                    child: Icon(
                      Icons.clear,
                      size: bounceAnimation.value,
                      color: Colors.white,
                    ),
                  );
                }
              },
            ),
    );
  }
}

class _LoginAnimationState extends State<LoginAnimation> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: LoginBloc(),
      child: AnimatedBuilder(
        builder: widget._buildAnimation,
        animation: widget.buttonController,
      ),
    );
  }
}
