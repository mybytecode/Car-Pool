
import 'package:flutter/material.dart';

class CustomTheme
{
  MaterialColor colorCustom = MaterialColor(0xFF880E4F, defaultColor);
  static Map<int, Color> defaultColor =
  {
    50:Color.fromRGBO(255,255,255, .1),
    100:Color.fromRGBO(255,255,255, .2),
    200:Color.fromRGBO(255,255,255, .3),
    300:Color.fromRGBO(255,255,255, .4),
    400:Color.fromRGBO(255,255,255, .5),
    500:Color.fromRGBO(255,255,255, .6),
    600:Color.fromRGBO(255,255,255, .7),
    700:Color.fromRGBO(255,255,255, .8),
    800:Color.fromRGBO(255,255,255, .9),
    900:Color.fromRGBO(255,255,255, 1),
  };
}