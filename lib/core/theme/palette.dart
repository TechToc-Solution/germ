import 'package:flutter/material.dart';

const primaryColor = MaterialColor(
  0xff243253,
  <int, Color>{
    50: Color(0xffedf0f7), // You can define shades from 50 to 900
    100: Color(0xffcad3e8),
    200: Color(0xffa6b5d8),
    300: Color(0xff8398c9),
    400: Color(0xff5f7aba),
    500: Color(0xff243253), // The primary color
    600: Color(0xff364b7c),
    700: Color(0xff273659),
    800: Color(0xff172035),
    900: Color(0xff080b12),
  },
);
ThemeData theme = ThemeData(
  primaryColor: const Color(0xff243253),
  cardColor: const Color(0xff2e3192),
  primarySwatch: primaryColor,
);
//#a7947d
//#c0b6ab
//#d6cec0
//#ecdecc
//#cbc3b8
//#f1e7b9
//0xfff9e8b8