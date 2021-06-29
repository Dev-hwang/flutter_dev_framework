import 'package:flutter/material.dart';
import 'package:flutter_dev_framework/ui/button/model/button_size.dart';
import 'package:flutter_dev_framework/ui/button/simple_button.dart';

/// 다이얼로그 버튼 스타일
enum DialogButtonStyle {
  FLAT,
  ANDROID,
  iOS
}

/// 커스터마이징 가능한 다이얼로그
class CustomDialog {
  final String? title;
  final TextStyle? titleStyle;
  final TextAlign titleAlign;
  final Widget? titleWidget;
  final Color? titleBackgroundColor;
  final EdgeInsetsGeometry titlePadding;

  final String? content;
  final TextStyle? contentStyle;
  final TextAlign contentAlign;
  final Widget? contentWidget;
  final Color? contentBackgroundColor;
  final EdgeInsetsGeometry contentPadding;

  final Color? backgroundColor;
  final double borderRadius;

  final Color? dividerColor;
  final double dividerThickness;
  final EdgeInsetsGeometry dividerMargin;

  final DialogButtonStyle buttonStyle;
  final String positiveButtonText;
  final String negativeButtonText;
  final double? positiveButtonTextSize;
  final double? negativeButtonTextSize;
  final FontWeight? positiveButtonFontWeight;
  final FontWeight? negativeButtonFontWeight;
  final Color? positiveButtonTextColor;
  final Color? negativeButtonTextColor;
  final Color? positiveButtonColor;
  final Color? negativeButtonColor;

  final bool expandedWidth;
  final bool showingButton;
  final bool dismissible;
  final bool willCloseWhenPositiveButtonPressed;
  final bool willCloseWhenNegativeButtonPressed;
  
  final VoidCallback? onDismiss;
  final VoidCallback? onPositiveButtonPressed;
  final VoidCallback? onNegativeButtonPressed;

  const CustomDialog({
    String? title,
    this.titleStyle,
    TextAlign? titleAlign,
    this.titleWidget,
    this.titleBackgroundColor,
    EdgeInsetsGeometry? titlePadding,
    this.content,
    this.contentStyle,
    TextAlign? contentAlign,
    this.contentWidget,
    this.contentBackgroundColor,
    EdgeInsetsGeometry? contentPadding,
    this.backgroundColor,
    double? borderRadius,
    this.dividerColor,
    double? dividerThickness,
    EdgeInsetsGeometry? dividerMargin,
    DialogButtonStyle? buttonStyle,
    String? positiveButtonText,
    String? negativeButtonText,
    this.positiveButtonTextSize,
    this.negativeButtonTextSize,
    this.positiveButtonFontWeight,
    this.negativeButtonFontWeight,
    this.positiveButtonTextColor,
    this.negativeButtonTextColor,
    this.positiveButtonColor,
    this.negativeButtonColor,
    bool? expandedWidth,
    bool? showingButton,
    bool? dismissible,
    bool? willCloseWhenPositiveButtonPressed,
    bool? willCloseWhenNegativeButtonPressed,
    this.onDismiss,
    this.onPositiveButtonPressed,
    this.onNegativeButtonPressed
  })  : title = title,
        titleAlign = titleAlign ?? TextAlign.start,
        titlePadding = titlePadding ?? const EdgeInsets.fromLTRB(12.0, 14.0, 12.0, 14.0),
        contentAlign = contentAlign ?? TextAlign.start,
        contentPadding = (title == null)
            ? contentPadding ?? const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0)
            : contentPadding ?? const EdgeInsets.fromLTRB(12.0, 18.0, 12.0, 18.0),
        borderRadius = borderRadius ?? 4.0,
        dividerThickness = dividerThickness ?? 0.5,
        dividerMargin = dividerMargin ?? const EdgeInsets.only(),
        buttonStyle = buttonStyle ?? DialogButtonStyle.FLAT,
        positiveButtonText = positiveButtonText ?? '확인',
        negativeButtonText = negativeButtonText ?? '취소',
        expandedWidth = expandedWidth ?? true,
        showingButton = showingButton ?? true,
        dismissible = dismissible ?? false,
        willCloseWhenPositiveButtonPressed = willCloseWhenPositiveButtonPressed ?? true,
        willCloseWhenNegativeButtonPressed = willCloseWhenNegativeButtonPressed ?? true;

  Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          insetPadding: const EdgeInsets.all(20.0),
          titlePadding: const EdgeInsets.all(0.0),
          contentPadding: const EdgeInsets.all(0.0),
          backgroundColor: backgroundColor
              ?? Theme.of(context).dialogTheme.backgroundColor,
          content: SingleChildScrollView(
            child: SizedBox(
              width: expandedWidth
                  ? MediaQuery.of(context).size.width
                  : null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildDialogHeader(context),
                  _buildDialogBody(context),
                  _buildDialogFooter(context)
                ],
              ),
            ),
          ),
        );
      }
    ).then((_) {
      if (onDismiss != null)
        onDismiss!();
    });
  }

  Widget _buildDialogHeader(BuildContext context) {
    if (title == null && titleWidget == null)
      return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: titlePadding,
          decoration: BoxDecoration(
            color: titleBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius)
            ),
          ),
          child: titleWidget ?? Text(
            title ?? '',
            style: titleStyle ?? Theme.of(context).dialogTheme.titleTextStyle,
            textAlign: titleAlign
          )
        ),
        Container(
          margin: dividerMargin,
          height: dividerThickness,
          color: dividerColor ?? Theme.of(context).dividerColor
        ),
      ],
    );
  }

  Widget _buildDialogBody(BuildContext context) {
    return Container(
      padding: contentPadding,
      color: contentBackgroundColor,
      child: contentWidget ?? Text(
        content ?? '',
        style: contentStyle ?? Theme.of(context).dialogTheme.contentTextStyle,
        textAlign: contentAlign
      ),
    );
  }

  Widget _buildDialogFooter(BuildContext context) {
    if (!showingButton)
      return SizedBox.shrink();

    final buttonList = <Widget>[];
    if (onNegativeButtonPressed != null) {
      buttonList.add(_buildNegativeButton(context));
      if (buttonStyle == DialogButtonStyle.FLAT)
        buttonList.add(SizedBox(width: 4.0));
      else if (buttonStyle == DialogButtonStyle.ANDROID)
        buttonList.add(SizedBox(width: 6.0));
      else if (buttonStyle == DialogButtonStyle.iOS)
        buttonList.add(SizedBox(width: 0.5));
    }
    buttonList.add(_buildPositiveButton(context));

    switch (buttonStyle) {
      case DialogButtonStyle.FLAT:
        return Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: buttonList
          ),
        );
      case DialogButtonStyle.ANDROID:
        return Container(
          height: ButtonSize.MATERIAL_LARGE.minHeight,
          margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buttonList
          ),
        );
      default:
        return Container(
          height: ButtonSize.APPLE_LARGE.minHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(borderRadius),
              bottomRight: Radius.circular(borderRadius)
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 0.5),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buttonList
                ),
              ),
            ],
          )
        );
    }
  }

  Widget _buildPositiveButton(BuildContext context) {
    final buttonTextTheme = Theme.of(context).textTheme.button;
    final buttonTextStyle = TextStyle(
      color: (buttonStyle == DialogButtonStyle.ANDROID)
          ? positiveButtonTextColor ?? Colors.white
          : positiveButtonTextColor ?? Theme.of(context).primaryColor,
      fontSize: positiveButtonTextSize ?? buttonTextTheme?.fontSize,
      fontWeight: positiveButtonFontWeight ?? buttonTextTheme?.fontWeight
    );

    final buttonCallback = () {
      if (willCloseWhenPositiveButtonPressed)
        Navigator.of(context).pop();
      if (onPositiveButtonPressed != null)
        onPositiveButtonPressed!();
    };

    switch (buttonStyle) {
      case DialogButtonStyle.FLAT:
        return TextButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(positiveButtonText, style: buttonTextStyle)
          ),
          onPressed: buttonCallback
        );
      case DialogButtonStyle.ANDROID:
        return Expanded(
          child: SimpleButton(
            text: positiveButtonText,
            textStyle: buttonTextStyle,
            color: positiveButtonColor,
            borderRadius: BorderRadius.circular(2.0),
            onPressed: buttonCallback
          ),
        );
      default:
        final buttonColor = positiveButtonColor
            ?? backgroundColor
            ?? Theme.of(context).dialogTheme.backgroundColor
            ?? Colors.white;
        final buttonRadius = Radius.circular(borderRadius);

        return Expanded(
          child: SimpleButton(
            text: positiveButtonText,
            textStyle: buttonTextStyle,
            color: buttonColor,
            borderRadius: (onNegativeButtonPressed != null)
                ? BorderRadius.only(bottomRight: buttonRadius)
                : BorderRadius.only(bottomRight: buttonRadius, bottomLeft: buttonRadius),
            onPressed: buttonCallback
          ),
        );
    }
  }

  Widget _buildNegativeButton(BuildContext context) {
    final buttonTextTheme = Theme.of(context).textTheme.button;
    final buttonTextStyle = TextStyle(
      color: (buttonStyle == DialogButtonStyle.ANDROID)
          ? negativeButtonTextColor ?? Colors.white
          : negativeButtonTextColor ?? Theme.of(context).textTheme.bodyText2?.color,
      fontSize: negativeButtonTextSize ?? buttonTextTheme?.fontSize,
      fontWeight: negativeButtonFontWeight ?? buttonTextTheme?.fontWeight
    );

    final buttonCallback = () {
      if (willCloseWhenNegativeButtonPressed)
        Navigator.of(context).pop();
      if (onNegativeButtonPressed != null)
        onNegativeButtonPressed!();
    };

    switch (buttonStyle) {
      case DialogButtonStyle.FLAT:
        return TextButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(negativeButtonText, style: buttonTextStyle)
          ),
          onPressed: buttonCallback
        );
      case DialogButtonStyle.ANDROID:
        return Expanded(
          child: SimpleButton(
            text: negativeButtonText,
            textStyle: buttonTextStyle,
            color: negativeButtonColor,
            borderRadius: BorderRadius.circular(2.0),
            onPressed: buttonCallback
          ),
        );
      default:
        final buttonColor = negativeButtonColor
            ?? backgroundColor
            ?? Theme.of(context).dialogTheme.backgroundColor
            ?? Colors.white;
        final buttonRadius = Radius.circular(borderRadius);

        return Expanded(
          child: SimpleButton(
            text: negativeButtonText,
            textStyle: buttonTextStyle,
            color: buttonColor,
            borderRadius: BorderRadius.only(bottomLeft: buttonRadius),
            onPressed: buttonCallback
          ),
        );
    }
  }
}
