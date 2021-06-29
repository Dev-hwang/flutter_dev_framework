import 'package:flutter/material.dart';
import 'package:flutter_dev_framework/ui/component/android_toast.dart';
import 'package:flutter_dev_framework/utils/system_utils.dart';

/// 앱 종료 확인 기능이 구현된 페이지
class WithWillPopScope extends StatefulWidget {
  /// 백그라운드 이동 여부
  /// 기본값 `false`
  final bool moveBackground;

  /// 앱 종료 확인 메시지
  final String? message;

  /// 자식 위젯
  final Widget child;

  const WithWillPopScope({
    Key? key,
    this.moveBackground = false,
    this.message,
    required this.child
  })  : super(key: key);

  @override
  _WithWillPopScopeState createState() => _WithWillPopScopeState();
}

class _WithWillPopScopeState extends State<WithWillPopScope> {
  DateTime _backPressedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        final currDateTime = DateTime.now();
        if (currDateTime.difference(_backPressedDateTime) > const Duration(seconds: 2)) {
          _backPressedDateTime = currDateTime;

          if (widget.message == null)
            AndroidToast(message: widget.moveBackground
                ? '한 번 더 누르면 백그라운드로 전환됩니다.'
                : '한 번 더 누르면 종료됩니다.').show();
          else
            AndroidToast(message: widget.message!).show();

          return Future.value(false);
        }

        if (widget.moveBackground) {
          SystemUtils.instance.minimize();
          return Future.value(false);
        }

        return Future.value(true);
      },
      child: widget.child
    );
  }
}
