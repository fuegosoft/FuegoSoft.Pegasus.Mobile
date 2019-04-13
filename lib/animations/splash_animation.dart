import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:fuegosoft_mobile/pages/pages.dart';
import 'package:fuegosoft_mobile/pages/register/register_page.dart';
import 'package:fuegosoft_mobile/utils/utils.dart';

class SplashDetailsEnterAnimation extends StatefulWidget {
  final AnimationController controller;
  final BuildContext context;
  final Animation<double> backdropOpacity;
  final Animation<double> backdropBlur;
  final Animation<double> logoSize;
  final Animation<double> appNameOpacity;
  final Animation<double> sloganOpacity;
  final Animation<double> dividerWidth;
  final Animation<double> appInfoOpacity;
  final Animation<double> buttonScrollerXTranslation;
  final Animation<double> buttonScrollerOpacity;

  SplashDetailsEnterAnimation({Key key, this.controller, this.context})
      : backdropOpacity = Tween(begin: 0.5, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.000,
              0.500,
              curve: Curves.ease,
            ),
          ),
        ),
        backdropBlur = Tween(begin: 0.0, end: 5.0).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.000, 0.800, curve: Curves.ease),
        )),
        logoSize = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.100, 0.400, curve: Curves.elasticOut),
          ),
        ),
        appNameOpacity = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.350, 0.450, curve: Curves.easeIn),
          ),
        ),
        sloganOpacity = Tween(begin: 0.0, end: 0.85).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.500, 0.600, curve: Curves.easeIn),
          ),
        ),
        dividerWidth = Tween(begin: 0.0, end: 225.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.650, 0.750, curve: Curves.easeIn),
          ),
        ),
        appInfoOpacity = Tween(begin: 0.0, end: 0.85).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.750, 0.900, curve: Curves.easeIn),
          ),
        ),
        buttonScrollerXTranslation = Tween(begin: 60.0, end: 0.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.830, 1.000, curve: Curves.ease),
          ),
        ),
        buttonScrollerOpacity = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.830, 1.000, curve: Curves.fastOutSlowIn),
          ),
        );

  _SplashDetailsEnterAnimation createState() => _SplashDetailsEnterAnimation();

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Opacity(
          opacity: backdropOpacity.value,
          child: Image.asset(
            'assets/images/background/Background@3x.png',
            fit: BoxFit.cover,
          ),
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(
              sigmaX: backdropBlur.value, sigmaY: backdropBlur.value),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: _buildContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildLogo(),
            _buildAppInfo(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Align(
      child: Transform(
        transform: Matrix4.diagonal3Values(
          logoSize.value,
          logoSize.value,
          1.0,
        ),
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          width: 110,
          height: 110,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: getColor(ColorList.WhiteCream, 1.0), width: 2.0)),
          margin: const EdgeInsets.only(top: 32.0),
          padding: const EdgeInsets.all(3.0),
          child: Container(
            height: 80,
            width: 80,
            child: ClipOval(
              child: Image.asset(
                'assets/images/log-ayuda-black.png',
                color: getColor(ColorList.WhiteCream, 1.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              'Ayuda',
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  color: getColor(ColorList.WhiteCream, 1.0)
                      .withOpacity(appNameOpacity.value),
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Find professionals near you',
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  color: getColor(ColorList.WhiteCream, 1.0)
                      .withOpacity(sloganOpacity.value),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              color: getColor(ColorList.WhiteCream, 1.0).withOpacity(0.85),
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              width: dividerWidth.value,
              height: 2.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'This is your app info. please put a short detail on it.',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 12.0,
                color: getColor(ColorList.WhiteCream, 1.0)
                    .withOpacity(appInfoOpacity.value),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        alignment: Alignment.center,
        child: Transform(
          transform: Matrix4.translationValues(
            buttonScrollerXTranslation.value,
            0.0,
            0.0,
          ),
          child: Opacity(
            opacity: buttonScrollerOpacity.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: getColor(ColorList.WhiteCream, 1.0),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(60)),
                    child: Text(
                      'Login'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 18.0,
                        color: getColor(ColorList.WhiteCream, 1.0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: getColor(ColorList.DarkGreen, 1.0),
                    elevation: 15.0,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: FlatButton(
                    child: Text(
                      'Not yet a member? Sign up now!',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 18.0,
                        color: getColor(ColorList.WhiteCream, 1.0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    color: Colors.transparent,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SplashDetailsEnterAnimation extends State<SplashDetailsEnterAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        builder: widget._buildAnimation,
        animation: widget.controller,
      ),
    );
  }
}
