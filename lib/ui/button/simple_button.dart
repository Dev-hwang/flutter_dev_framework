import 'package:flutter/material.dart';
import 'package:flutter_dev_framework/ui/button/model/button_size.dart';

/// ElevatedButton 기반 심플 버튼
class SimpleButton extends StatelessWidget {
  /// 버튼 텍스트
  final String text;

  /// 버튼 텍스트 스타일
  /// 기본값 `Theme.of(context).textTheme.button`
  final TextStyle? textStyle;

  /// 버튼 색상
  /// 기본값 `Theme.of(context).buttonColor`
  final Color? color;

  /// 버튼 색상(disabled)
  /// 기본값 `Theme.of(context).disabledColor`
  final Color? disabledColor;

  /// 버튼 색상(focus)
  final Color? focusColor;

  /// 버튼 색상(hover)
  final Color? hoverColor;

  /// 버튼 색상(pressed)
  final Color? pressedColor;

  /// 버튼 오버레이 색상
  final Color? overlayColor;

  /// 버튼 그림자 높이
  /// 기본값 `2.0`
  final double elevation;

  /// 버튼 그림자 높이(disabled)
  /// 기본값 `0.0`
  final double disabledElevation;

  /// 버튼 그림자 높이(focus)
  final double? focusElevation;

  /// 버튼 그림자 높이(hover)
  final double? hoverElevation;

  /// 버튼 그림자 높이(pressed)
  final double? pressedElevation;

  /// 버튼 사이즈
  /// 기본값 `ButtonSize.MATERIAL_MEDIUM`
  final ButtonSize buttonSize;

  /// 버튼 테두리
  final BorderSide borderSide;

  /// 버튼 모서리
  final BorderRadius borderRadius;

  /// 버튼 내부 여백
  final EdgeInsetsGeometry? padding;

  /// materialTapTargetSize
  final MaterialTapTargetSize? materialTapTargetSize;

  /// animationDuration
  final Duration? animationDuration;

  /// 버튼 누름 콜백
  final VoidCallback? onPressed;

  /// 버튼 길게 누름 콜백
  final VoidCallback? onLongPress;

  const SimpleButton({
    Key? key,
    required this.text,
    this.textStyle,
    this.color,
    this.disabledColor,
    this.focusColor,
    this.hoverColor,
    this.pressedColor,
    this.overlayColor,
    this.elevation = 2.0,
    this.disabledElevation = 0.0,
    this.focusElevation,
    this.hoverElevation,
    this.pressedElevation,
    this.buttonSize = ButtonSize.MATERIAL_MEDIUM,
    this.borderSide = BorderSide.none,
    this.borderRadius = BorderRadius.zero,
    this.padding,
    this.materialTapTargetSize,
    this.animationDuration,
    required this.onPressed,
    this.onLongPress
  })  : assert(elevation >= 0),
        assert(disabledElevation >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      side: borderSide,
      borderRadius: borderRadius
    );

    final style = ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled))
          return disabledColor ?? Theme.of(context).disabledColor;
        else if (states.contains(MaterialState.focused))
          return focusColor ?? color ?? Theme.of(context).buttonColor;
        else if (states.contains(MaterialState.hovered))
          return hoverColor ?? color ?? Theme.of(context).buttonColor;
        else if (states.contains(MaterialState.pressed))
          return pressedColor ?? color ?? Theme.of(context).buttonColor;

        return color ?? Theme.of(context).buttonColor;
      }),
      elevation: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled))
          return disabledElevation;
        else if (states.contains(MaterialState.focused))
          return focusElevation ?? elevation;
        else if (states.contains(MaterialState.hovered))
          return hoverElevation ?? elevation;
        else if (states.contains(MaterialState.pressed))
          return pressedElevation ?? elevation;

        return elevation;
      }),
      overlayColor: MaterialStateProperty
          .all(overlayColor ?? Theme.of(context).splashColor),
      padding: MaterialStateProperty.all(padding ?? buttonSize.padding),
      shape: MaterialStateProperty.all(shape),
      tapTargetSize: materialTapTargetSize,
      animationDuration: animationDuration,
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: buttonSize.minWidth,
        minHeight: buttonSize.minHeight
      ),
      child: ElevatedButton(
        child: Text(text, style: textStyle
            ?? Theme.of(context).textTheme.button),
        style: style,
        onPressed: onPressed,
        onLongPress: onLongPress
      ),
    );
  }
}
