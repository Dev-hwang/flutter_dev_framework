import 'package:flutter/material.dart';

/// 앱 테마
class AppTheme {
  /// 밝은 색상의 테마 데이터를 생성한다.
  static ThemeData get light => buildThemeData(
    // App Theme
    brightness: Brightness.light,
    primaryColor: const Color(0xFF3D5AFE),
    primarySwatch: MaterialColor(0xFF3D5AFE, {
      50: const Color(0xFFE8E8FF),
      100: const Color(0xFFC4C5FE),
      200: const Color(0xFF9AA0FE),
      300: const Color(0xFF6A7AFF),
      400: const Color(0xFF3D5AFE),
      500: const Color(0xFF0038FA),
      600: const Color(0xFF002EEE),
      700: const Color(0xFF0021E1),
      800: const Color(0xFF000DD7),
      900: const Color(0xFF0000BD),
    }),
    accentColor: const Color(0xFF0091EA),
    canvasColor: const Color(0xFFFFFFFF),
    backgroundColor: const Color(0xFFFFFFFF),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    dividerColor: const Color(0xFFCCCCCC),
    disabledColor: const Color(0xFFB0B0B0),

    // AppBar Theme
    appBarPrimaryColor: const Color(0xFF3D5AFE),
    appBarIconColor: const Color(0xFFFFFFFF),
    appBarTextColor: const Color(0xFFFFFFFF),
    appBarElevation: 3.0,

    // Card Theme
    cardColor: const Color(0xFFFFFFFF),
    cardElevation: 2.0,

    // Dialog Theme
    dialogColor: const Color(0xFFFFFFFF),
    dialogTitleColor: const Color(0xFF000000),
    dialogContentColor: const Color(0xFF555555),

    // Button Theme
    buttonColor: const Color(0xFF0091EA),
    buttonTextColor: const Color(0xFFFFFFFF),

    // Text Theme
    fontFamily: 'NotoSansKR',
    headlineColor: const Color(0xFF000000),
    subtitleColor: const Color(0xFF000000),
    bodyTextColor: const Color(0xFF555555),
    captionColor: const Color(0xFF999999),
    overlineColor: const Color(0xFF999999),
  );

  /// 테마 데이터를 생성한다.
  static ThemeData buildThemeData({
    required Brightness brightness,
    required Color primaryColor,
    required MaterialColor primarySwatch,
    required Color accentColor,
    required Color canvasColor,
    required Color backgroundColor,
    required Color scaffoldBackgroundColor,
    required Color dividerColor,
    required Color disabledColor,
    required Color appBarPrimaryColor,
    required Color appBarIconColor,
    required Color appBarTextColor,
    required double appBarElevation,
    required Color cardColor,
    required double cardElevation,
    required Color dialogColor,
    required Color dialogTitleColor,
    required Color dialogContentColor,
    required Color buttonColor,
    required Color buttonTextColor,
    required String fontFamily,
    required Color headlineColor,
    required Color subtitleColor,
    required Color bodyTextColor,
    required Color captionColor,
    required Color overlineColor,
  }) {
    return ThemeData(
      // App Theme
      brightness: brightness,
      primaryColor: primaryColor,
      primarySwatch: primarySwatch,
      accentColor: accentColor,
      canvasColor: canvasColor,
      backgroundColor: backgroundColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      dividerColor: dividerColor,
      disabledColor: disabledColor,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        color: appBarPrimaryColor,
        elevation: appBarElevation,
        iconTheme: IconThemeData(color: appBarIconColor),
        textTheme: TextTheme(
          headline6: TextStyle(color: appBarTextColor, fontSize: 19.0),
          bodyText2: TextStyle(color: appBarTextColor, fontSize: 17.0),
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: cardColor,
        elevation: cardElevation,
      ),

      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: dialogColor,
        titleTextStyle: TextStyle(color: dialogTitleColor, fontSize: 19.0),
        contentTextStyle: TextStyle(color: dialogContentColor, fontSize: 17.0),
      ),

      // Button Theme
      buttonColor: buttonColor,
      buttonTheme: ButtonThemeData(),

      // Text Theme
      fontFamily: fontFamily,
      textTheme: TextTheme(
        headline1: TextStyle(color: headlineColor, fontSize: 96.0),
        headline2: TextStyle(color: headlineColor, fontSize: 60.0),
        headline3: TextStyle(color: headlineColor, fontSize: 48.0),
        headline4: TextStyle(color: headlineColor, fontSize: 34.0),
        headline5: TextStyle(color: headlineColor, fontSize: 24.0),
        headline6: TextStyle(color: headlineColor, fontSize: 21.0),
        subtitle1: TextStyle(color: subtitleColor, fontSize: 17.0),
        subtitle2: TextStyle(color: subtitleColor, fontSize: 15.0),
        bodyText1: TextStyle(color: bodyTextColor, fontSize: 17.0),
        bodyText2: TextStyle(color: bodyTextColor, fontSize: 15.0),
        button: TextStyle(color: buttonTextColor, fontSize: 15.0),
        caption: TextStyle(color: captionColor, fontSize: 13.0),
        overline: TextStyle(color: overlineColor, fontSize: 11.0),
      ),
    );
  }
}
