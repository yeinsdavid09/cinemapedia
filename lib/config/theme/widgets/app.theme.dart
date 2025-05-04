import 'package:flutter/material.dart';
import 'package:cinemapedia/config/index.dart';

class AppTheme {
  //#region ----------------------------------- Variables ---------------------------------

  late int _color = 0;
  late Brightness _brightness = Brightness.light;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  AppTheme({required color, required brightness})
    : _color = color,
      _brightness = brightness;

  //#endregion

  //#region --------------------------------- Accessors ---------------------------------

  set color(int value) {
    if (value < 0 || value > appColors.length - 1) {
      throw ArgumentError(
        'The theme color must be a value between 0 and ${appColors.length - 1}',
      );
    }
    _color = value;
  }

  set brightness(Brightness value) {
    _brightness = value;
  }

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: appColors[_color],
      brightness: _brightness,
      appBarTheme: const AppBarTheme(centerTitle: false),
    );
  }

  AppTheme copyWith({int? color, Brightness? brightness}) {
    return AppTheme(
      color: color ?? _color,
      brightness: brightness ?? _brightness,
    );
  }

  //#endregion
}
