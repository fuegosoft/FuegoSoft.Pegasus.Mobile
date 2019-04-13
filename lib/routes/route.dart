import 'package:flutter/material.dart';
import 'package:fuegosoft_mobile/pages/pages.dart';

final routes = {
  '/': (BuildContext context) => new SplashPage(),
  '/login': (BuildContext context) => new LoginPage(),
  '/register': (BuildContext context) => new RegisterPage()
};
