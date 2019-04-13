// reference
// https://www.design-seeds.com/seasons/summer/color-nature-78/
// #316C31
// #458534
// #7BB35A
// #BBDB6A
// #E8EFA1
// #DFEAF0

import 'package:flutter/material.dart';

Color getColor(ColorList color, double opacity) {
  Color selectedColor;
  if (opacity <= 1.0) {
    switch (color) {
      case ColorList.BaseBlack:
        selectedColor = Color.fromRGBO(51, 57, 52, opacity);
        break;
      case ColorList.BaseGray:
        selectedColor = Color.fromRGBO(112, 112, 112, opacity);
        break;
      case ColorList.DarkGreen:
        selectedColor = Color.fromRGBO(106, 131, 71, opacity);
        break;
      case ColorList.Green:
        selectedColor = Color.fromRGBO(113, 178, 56, opacity);
        break;
      case ColorList.CreamGreen:
        selectedColor = Color.fromRGBO(141, 184, 124, opacity);
        break;
      case ColorList.LightGreen:
        selectedColor = Color.fromRGBO(166, 203, 69, opacity);
        break;
      case ColorList.WhiteCream:
        selectedColor = Color.fromRGBO(254, 252, 215, opacity);
        break;
      case ColorList.DarkBlue:
        selectedColor = Color.fromRGBO(42, 46, 67, opacity);
        break;
    }
  }
  return selectedColor;
}

enum ColorList {
  BaseBlack,
  BaseGray,
  DarkGreen,
  Green,
  CreamGreen,
  LightGreen,
  WhiteCream,
  DarkBlue,
}
