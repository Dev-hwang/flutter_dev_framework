import 'package:flutter/material.dart';
import 'package:flutter_dev_framework/ui/button/model/button_size.dart';

/// 타원형 고스트 버튼
class OvalGhostButton extends StatelessWidget {
  /// 버튼 텍스트
  final String text;

  /// 버튼 텍스트 스타일
  /// 기본값 `Theme.of(context).textTheme.button?.copyWith(color: Theme.of(context).buttonColor)`
  final TextStyle? textStyle;

  /// 아이콘 데이터
  final IconData? iconData;

  /// 아이콘 사이즈
  /// 기본값 `18.0`
  final double iconSize;

  /// 아이콘 색상
  /// 기본값 `Theme.of(context).buttonColor`
  final Color? iconColor;

  /// 아이콘 바깥 여백
  /// 기본값 `const EdgeInsets.only(right: 2.5)`
  final EdgeInsetsGeometry iconMargin;

  /// 버튼 테두리 색상
  /// 기본값 `Theme.of(context).buttonColor`
  final Color? borderColor;

  /// 버튼 배경색
  final Color? backgroundColor;

  /// 버튼 사이즈
  /// 기본값 `ButtonSize.MATERIAL_MEDIUM`
  final ButtonSize buttonSize;

  /// 버튼 내부 여백
  final EdgeInsetsGeometry? padding;

  /// 버튼 누름 콜백
  final VoidCallback? onPressed;

  /// 버튼 길게 누름 콜백
  final VoidCallback? onLongPress;

  const OvalGhostButton({
    Key? key,
    required this.text,
    this.textStyle,
    this.iconData,
    this.iconSize = 18.0,
    this.iconColor,
    this.iconMargin = const EdgeInsets.only(right: 2.5),
    this.borderColor,
    this.backgroundColor,
    this.buttonSize = ButtonSize.MATERIAL_MEDIUM,
    this.padding,
    this.onPressed,
    this.onLongPress
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(text, style: textStyle
        ?? Theme.of(context).textTheme.button
            ?.copyWith(color: Theme.of(context).buttonColor));

    final iconWidget = (iconData != null) ? Container(
      margin: iconMargin,
      child: Icon(iconData,
          size: iconSize, color: iconColor ?? Theme.of(context).buttonColor)
    ) : SizedBox.shrink();

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: buttonSize.minWidth,
        minHeight: buttonSize.minHeight
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(buttonSize.minHeight),
          onTap: onPressed,
          onLongPress: onLongPress,
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor ?? Theme.of(context).buttonColor),
              borderRadius: BorderRadius.circular(buttonSize.minHeight)
            ),
            padding: padding ?? buttonSize.padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                iconWidget,
                textWidget
              ],
            ),
          ),
        ),
      ),
    );
  }
}
