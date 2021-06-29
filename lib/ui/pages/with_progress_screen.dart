import 'package:flutter/material.dart';

/// 프로그레스 화면 구현 페이지
class WithProgressScreen extends StatelessWidget {
  /// 프로그레스 화면 배경색
  /// 기본값 `Colors.black`
  final Color backgroundColor;

  /// 프로그레스 화면 투명도
  /// 기본값 `0.5`
  final double backgroundOpacity;

  /// 프로그레스 인디케이터
  /// 기본값 `const CircularProgressIndicator(
  /// valueColor: AlwaysStoppedAnimation<Color>(const Color(0xCCFFFFFF)))`
  final Widget indicator;

  /// 프로그레스 인디케이터 오프셋
  final Offset? indicatorOffset;

  /// 프로그레스 화면 보임 여부
  final bool showingProgress;

  /// 자식 위젯
  final Widget child;

  const WithProgressScreen({
    Key? key,
    this.backgroundColor = Colors.black,
    this.backgroundOpacity = 0.5,
    this.indicator = const CircularProgressIndicator(
        valueColor: const AlwaysStoppedAnimation<Color>(const Color(0xCCFFFFFF))),
    this.indicatorOffset,
    required this.showingProgress,
    required this.child,
  })  : assert(backgroundOpacity >= 0.0 && backgroundOpacity <= 1.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[child];

    if (showingProgress) {
      children.addAll([
        Opacity(
          opacity: backgroundOpacity,
          child: ModalBarrier(color: backgroundColor, dismissible: false)
        ),
        (indicatorOffset == null)
            ? Center(child: indicator)
            : Positioned(left: indicatorOffset!.dx, top: indicatorOffset!.dy, child: indicator)
      ]);
    }

    return Stack(children: children);
  }
}
