import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  final Widget child;

  SplashPage({Key key, this.child}) : super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}
