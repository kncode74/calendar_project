import 'package:flutter/material.dart';
import 'package:getx_mvvm_boilerplate/ui/_theme/color_theme/color_theme.dart';

class ColorThemeLight extends ColorTheme {
  @override
  Color get primaryColor => const Color(0xFFD1B2FF);

  @override
  Color get secondaryColor => const Color(0xFF508855);

  @override
  Color get primaryTextColor => const Color(0xFF565656);

  @override
  Color get secondaryTextColor => const Color(0xFFBDBDBD);
}
