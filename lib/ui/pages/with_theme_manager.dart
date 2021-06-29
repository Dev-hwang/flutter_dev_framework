import 'package:flutter/material.dart';

/// 앱 테마 데이터를 제공하는 자식 위젯 빌더
typedef WidgetBuilder = Widget Function(BuildContext context, ThemeData themeData);

/// 앱 테마 관리 기능이 구현된 페이지
class WithThemeManager extends StatefulWidget {
  /// 앱 테마 데이터
  final ThemeData themeData;

  /// 자식 위젯 빌더
  final WidgetBuilder builder;

  const WithThemeManager({
    Key? key,
    required this.themeData,
    required this.builder
  })  : super(key: key);

  @override
  _WithThemeManagerState createState() => _WithThemeManagerState();

  static _WithThemeManagerState? of(BuildContext context) =>
      context.findAncestorStateOfType<_WithThemeManagerState>();
}

class _WithThemeManagerState extends State<WithThemeManager> {
  late ThemeData _themeData;
  ThemeData get themeData => _themeData;

  void setThemeData(ThemeData themeData) {
    setState(() {
      _themeData = themeData;
    });
  }

  @override
  void initState() {
    super.initState();
    _themeData = widget.themeData;
  }

  @override
  void didUpdateWidget(covariant WithThemeManager oldWidget) {
    super.didUpdateWidget(oldWidget);
    _themeData = widget.themeData;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _themeData);
  }
}
