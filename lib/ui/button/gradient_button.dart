import 'package:flutter/material.dart';
import 'package:flutter_dev_framework/ui/button/model/button_size.dart';

/// 그라데이션 버튼
class GradientButton extends StatelessWidget {
  /// 버튼 텍스트
  final String text;

  /// 버튼 텍스트 스타일
  /// 기본값 `Theme.of(context).textTheme.button`
  final TextStyle? textStyle;

  /// 그라데이션 방향
  final Axis direction;

  /// 그라데이션 색상 리스트
  final List<Color> colors;

  /// 그라데이션 색상 간격
  final List<double> stops;

  /// 버튼 색상(disabled)
  /// 기본값 `Theme.of(context).disabledColor`
  final Color? disabledColor;

  /// 버튼 스플레시 색상
  final Color? splashColor;

  /// 버튼 테두리
  final Border? border;

  /// 버튼 모서리
  final BorderRadius? borderRadius;

  /// 버튼 그림자 높이
  /// 기본값 `2.0`
  final double elevation;

  /// 버튼 그림자 높이(disabled)
  /// 기본값 `0.0`
  final double disabledElevation;

  /// 버튼 사이즈
  /// 기본값 `ButtonSize.MATERIAL_MEDIUM`
  final ButtonSize buttonSize;

  /// 버튼 내부 여백
  final EdgeInsetsGeometry? padding;

  /// 버튼 누름 콜백
  final VoidCallback? onPressed;

  /// 버튼 길게 누름 콜백
  final VoidCallback? onLongPress;

  const GradientButton({
    Key? key,
    required this.text,
    this.textStyle,
    required this.direction,
    required this.colors,
    required this.stops,
    this.disabledColor,
    this.splashColor,
    this.border,
    this.borderRadius,
    this.elevation = 2.0,
    this.disabledElevation = 0.0,
    this.buttonSize = ButtonSize.MATERIAL_MEDIUM,
    this.padding,
    this.onPressed,
    this.onLongPress
  })  : assert(elevation >= 0),
        assert(disabledElevation >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;

    if (onPressed != null) {
      decoration = BoxDecoration(
        gradient: LinearGradient(
          begin: (direction == Axis.vertical)
              ? FractionalOffset.topCenter
              : FractionalOffset.centerLeft,
          end: (direction == Axis.vertical)
              ? FractionalOffset.bottomCenter
              : FractionalOffset.centerRight,
          colors: colors,
          stops: stops
        ),
        border: border,
        borderRadius: borderRadius
      );
    } else {
      decoration = BoxDecoration(
        color: disabledColor ?? Theme.of(context).disabledColor,
        border: border,
        borderRadius: borderRadius
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: buttonSize.minWidth,
        minHeight: buttonSize.minHeight
      ),
      child: Material(
        elevation: (onPressed == null && onLongPress == null)
            ? disabledElevation
            : elevation,
        color: Colors.transparent,
        child: Ink(
          decoration: decoration,
          child: InkWell(
            borderRadius: borderRadius,
            splashColor: splashColor,
            child: Padding(
              padding: padding ?? buttonSize.padding,
              child: Align(
                alignment: Alignment.center,
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Text(text, style: textStyle
                    ?? Theme.of(context).textTheme.button)
              )
            ),
            onTap: onPressed,
            onLongPress: onLongPress
          ),
        ),
      ),
    );
  }
}
