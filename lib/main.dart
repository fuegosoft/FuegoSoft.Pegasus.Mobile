import 'package:flutter/material.dart';
import 'package:fuegosoft_mobile/routes/route.dart';

void main() => runApp(AyudaApp());

class AyudaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Ayuda',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: routes,
    );
  }
}
