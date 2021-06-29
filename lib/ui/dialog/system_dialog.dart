import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 플랫폼에서 제공하는 기본 다이얼로그
class SystemDialog {
  final String? title;
  final TextStyle? titleStyle;

  final String content;
  final TextStyle? contentStyle;

  final String positiveButtonText;
  final String negativeButtonText;
  final TextStyle? positiveButtonTextStyle;
  final TextStyle? negativeButtonTextStyle;

  final bool dismissible;
  final bool willCloseWhenPositiveButtonPressed;
  final bool willCloseWhenNegativeButtonPressed;

  final VoidCallback? onDismiss;
  final VoidCallback? onPositiveButtonPressed;
  final VoidCallback? onNegativeButtonPressed;

  const SystemDialog({
    this.title,
    this.titleStyle,
    required this.content,
    this.contentStyle,
    String? positiveButtonText,
    String? negativeButtonText,
    this.positiveButtonTextStyle,
    this.negativeButtonTextStyle,
    bool? dismissible,
    bool? willCloseWhenPositiveButtonPressed,
    bool? willCloseWhenNegativeButtonPressed,
    this.onDismiss,
    this.onPositiveButtonPressed,
    this.onNegativeButtonPressed
  })  : positiveButtonText = positiveButtonText ?? '확인',
        negativeButtonText = negativeButtonText ?? '취소',
        dismissible = dismissible ?? false,
        willCloseWhenPositiveButtonPressed = willCloseWhenPositiveButtonPressed ?? true,
        willCloseWhenNegativeButtonPressed = willCloseWhenNegativeButtonPressed ?? true;

  Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        final titleWidget = (title == null)
            ? SizedBox.shrink()
            : Text(title!, style: titleStyle ?? Theme.of(context).dialogTheme.titleTextStyle);
        final titlePadding = (title == null)
            ? const EdgeInsets.all(0.0)
            : null;

        final contentWidget = Text(content, style: contentStyle
            ?? Theme.of(context).dialogTheme.contentTextStyle);
        final contentPadding = (title == null)
            ? const EdgeInsets.all(24.0)
            : const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0);

        final actionButtons = <Widget>[];
        if (onNegativeButtonPressed != null)
          actionButtons.add(_buildActionButton(context, positive: false));
        actionButtons.add(_buildActionButton(context, positive: true));

        if (Platform.isAndroid)
          return AlertDialog(
            title: titleWidget,
            titlePadding: titlePadding,
            content: contentWidget,
            contentPadding: contentPadding,
            actions: actionButtons
          );
        else
          return CupertinoAlertDialog(
            title: titleWidget,
            content: contentWidget,
            actions: actionButtons
          );
      }
    ).then((_) {
      if (onDismiss != null)
        onDismiss!();
    });
  }

  Widget _buildActionButton(BuildContext context, {bool positive = true}) {
    final child = positive
        ? Text(positiveButtonText, style: positiveButtonTextStyle)
        : Text(negativeButtonText, style: negativeButtonTextStyle);

    final onPressed = positive ? () {
      if (willCloseWhenPositiveButtonPressed)
        Navigator.of(context).pop();
      if (onPositiveButtonPressed != null)
        onPositiveButtonPressed!();
    } : () {
      if (willCloseWhenNegativeButtonPressed)
        Navigator.of(context).pop();
      if (onNegativeButtonPressed != null)
        onNegativeButtonPressed!();
    };
    
    if (Platform.isAndroid)
      return TextButton(
        child: child,
        onPressed: onPressed
      );
    else
      return CupertinoDialogAction(
        isDefaultAction: positive,
        child: child, 
        onPressed: onPressed
      );
  }
}
