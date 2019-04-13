import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuegosoft_mobile/animations/splash_animation.dart';
import 'package:fuegosoft_mobile/utils/utils.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controler;

  @override
  void initState() {
    super.initState();
    _controler = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);

    _controler.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controler.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      home: SplashDetailsEnterAnimation(
        context: context,
        controller: _controler,
      ),
    );
  }
}
