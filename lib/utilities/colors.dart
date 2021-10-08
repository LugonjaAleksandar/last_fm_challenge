import 'package:flutter/material.dart';

class ThemeColors {
  ThemeColors._();

  static final TextColor text = TextColor();
  static final ButtonColor button = ButtonColor();
  static final BorderColor border = BorderColor();
  static final IconColor icon = IconColor();
  static final ShadowColor shadow = ShadowColor();
  static final AppBarColor appBar = AppBarColor();
  static final BackgroundColor background = BackgroundColor();
}

class BackgroundColor {
  final Color primary = Color(0xFFFFFFFF); 
  final Color secondary = Color(0xFF44AACC);
  final Color modalBackground = Color(0xFF52616B); //
}

class TextColor {
  final Color primary = Color(0xFFFFFFFF);
  final Color primaryLight = Color(0xCCFFFFFF);
  final Color secondary = Color(0xFF11263C); // dark blue
  final Color secondaryLight = Color(0xCC11263C); // dark blue
}

class ButtonColor {
  final Color primary = Color(0xFFF6CA78);
  final Color primaryDisabled = Color(0x99F6CA78);
}

class BorderColor {
  final Color primary = Color(0xFFFFFFFF);
  final Color primaryLight = Color(0xCCFFFFFF);
  final Color secondary = Color(0x9911263C);
}

class IconColor {
  final Color primary = Color(0xFFFFFFFF);
  final Color secondary = Color(0xFF44AACC);
}

class ShadowColor {
  final Color primary = Color(0xFFD4DAE5); // cloudy blue
  final Color secondary = Color(0xFFD4F8E8); // light turquoise
  final Color dialog = Colors.black26;
}

class AppBarColor {
  final Color primary = Color(0xFF1EB2A6); // turquoise, like Light Sea Green
  final Color secondary = Color(0xFFF9F9F9); // very light gray
}
