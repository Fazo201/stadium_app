import "package:flutter/material.dart";
import "package:stadium_project/src/core/style/text_style.dart";

extension CustomContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => const AppTextStyle();
}
