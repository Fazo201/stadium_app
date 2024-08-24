import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:stadium_project/src/core/style/text_style.dart";

import "app_colors.dart";
import "color_schema.dart";

@immutable
final class AppThemes {
  final ThemeMode mode;
  final ThemeData darkTheme;
  final ThemeData lightTheme;

  AppThemes({required this.mode})
      : darkTheme = ThemeData(
          brightness: Brightness.dark,
          colorScheme: darkColorScheme,
          scaffoldBackgroundColor: AppColors.black,
          textTheme: const AppTextStyle(),
        ),
        lightTheme = ThemeData(
          brightness: Brightness.light,
          colorScheme: lightColorScheme,
          scaffoldBackgroundColor: AppColors.white,
          textTheme: const AppTextStyle(),
        );

  static ThemeData light() => ThemeData(
        brightness: Brightness.light,
        colorScheme: lightColorScheme,
        scaffoldBackgroundColor: lightColorScheme.surface,
        appBarTheme: AppBarTheme(
          backgroundColor: lightColorScheme.surface,
          shadowColor: lightColorScheme.shadow,
          surfaceTintColor: lightColorScheme.surface,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: lightColorScheme.surface,
          selectedLabelStyle: TextStyle(
            fontFamily: "Gilroy",
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: lightColorScheme.primary,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: "Gilroy",
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: lightColorScheme.onSurface,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(lightColorScheme.surface),
            shadowColor: WidgetStateProperty.all<Color>(lightColorScheme.shadow),
          ),
        ),
      );


  static ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        colorScheme: darkColorScheme,
        scaffoldBackgroundColor: darkColorScheme.surface,
        appBarTheme: AppBarTheme(
          backgroundColor: darkColorScheme.surface,
          shadowColor: darkColorScheme.shadow,
          surfaceTintColor: darkColorScheme.surface,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: darkColorScheme.surface,
          selectedLabelStyle: TextStyle(
            fontFamily: "Gilroy",
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: darkColorScheme.primary,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: "Gilroy",
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: darkColorScheme.onSurface,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(darkColorScheme.surface),
            shadowColor: WidgetStateProperty.all<Color>(darkColorScheme.shadow),
          ),
        ),
      );


  ThemeData computeTheme() {
    switch (mode) {
      case ThemeMode.light:
        return lightTheme;
      case ThemeMode.dark:
        return darkTheme;
      case ThemeMode.system:
        return PlatformDispatcher.instance.platformBrightness == Brightness.dark ? darkTheme : lightTheme;
    }
  }
}
