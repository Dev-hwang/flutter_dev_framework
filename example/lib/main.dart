import 'package:flutter/material.dart';
import 'package:flutter_dev_framework/ui/pages/with_theme_manager.dart';
import 'package:flutter_dev_framework_example/app_theme.dart';
import 'package:flutter_dev_framework_example/ui/splash_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WithThemeManager(
      themeData: AppTheme.light,
      builder: (context, themeData) {
        return MaterialApp(
          theme: themeData,
          localizationsDelegates: [
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('en'),
            const Locale('ko')
          ],
          home: SplashPage()
        );
      }
    );
  }
}
