import 'package:flutter/material.dart';
import 'package:flutter_dev_framework/ui/button/model/button_size.dart';

/// 날짜 선택 버튼
class DatePickerButton extends StatelessWidget {
  /// 버튼 색상
  /// 기본값 `Colors.transparent`
  final Color color;

  /// 버튼 테두리
  /// 기본값 `Border.all(color: Theme.of(context).buttonColor)`
  final Border? border;

  /// 버튼 모서리
  final BorderRadius? borderRadius;

  /// 버튼 사이즈
  /// 기본값 `ButtonSize.MATERIAL_LARGE`
  final ButtonSize buttonSize;

  /// 버튼 그림자 높이
  /// 기본값 `0.0`
  final double elevation;

  /// 너비 확장 여부
  /// 기본값 `false`
  final bool expanded;

  /// 텍스트 스타일
  /// 기본값 `Theme.of(context).textTheme.subtitle1 ??
  /// const TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w400)`
  final TextStyle? textStyle;

  /// 텍스트 여백
  /// 기본값 `const EdgeInsets.only(left: 10.0)`
  final EdgeInsetsGeometry textPadding;

  /// 아이콘
  /// 기본값 `const Icon(Icons.calendar_today_outlined, size: 18.0, color: const Color(0xFF666666))`
  final Icon? icon;

  /// 아이콘 숨김 여부
  /// 기본값 `false`
  final bool hideIcon;

  /// [showDatePicker] 초기 날짜
  /// 기본값 `DateTime.now()`
  final DateTime? initDate;

  /// [showDatePicker] 시작 날짜
  /// 기본값 `DateTime(2000)`
  final DateTime? firstDate;

  /// [showDatePicker] 끝 날짜
  /// 기본값 `DateTime(2100)`
  final DateTime? lastDate;

  /// [showDatePicker] locale
  /// 기본값 `const Locale('ko')`
  final Locale? pickerLocale;

  /// [showDatePicker] helpText
  final String? pickerHelpText;

  /// [showDatePicker] cancelText
  final String? pickerCancelText;

  /// [showDatePicker] confirmText
  final String? pickerConfirmText;

  /// [showDatePicker] error format text
  final String? pickerErrorFormatText;

  /// [showDatePicker] error invalid text
  final String? pickerErrorInvalidText;

  /// [showDatePicker] field hint text
  final String? pickerFieldHintText;

  /// [showDatePicker] field label text
  final String? pickerFieldLabelText;

  /// 날짜 선택 콜백 함수
  final ValueChanged<DateTime> onChanged;

  const DatePickerButton({
    Key? key,
    this.color = Colors.transparent,
    this.border,
    this.borderRadius,
    this.buttonSize = ButtonSize.MATERIAL_LARGE,
    this.elevation = 0.0,
    this.expanded = false,
    this.textStyle,
    this.textPadding = const EdgeInsets.only(left: 10.0),
    this.icon,
    this.hideIcon = false,
    this.initDate,
    this.firstDate,
    this.lastDate,
    this.pickerLocale,
    this.pickerHelpText,
    this.pickerCancelText,
    this.pickerConfirmText,
    this.pickerErrorFormatText,
    this.pickerErrorInvalidText,
    this.pickerFieldHintText,
    this.pickerFieldLabelText,
    required this.onChanged
  })  : assert(elevation >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateText = _buildDateText(context);
    final dateIcon = _buildDateIcon();

    return Material(
      elevation: elevation,
      borderRadius: borderRadius,
      color: color,
      child: InkWell(
        borderRadius: borderRadius,
        child: Container(
          height: buttonSize.minHeight,
          decoration: BoxDecoration(
            border: border ?? Border.all(color: Theme.of(context).buttonColor),
            borderRadius: borderRadius
          ),
          child: Row(
            mainAxisSize: expanded
                ? MainAxisSize.max
                : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              dateText,
              dateIcon
            ],
          ),
        ),
        onTap: () async {
          final selectedDate = await _showDatePicker(context);
          if (selectedDate != null)
            onChanged(selectedDate);
        }
      ),
    );
  }

  Widget _buildDateText(BuildContext context) {
    final dateTextData = initDate.toString().split(' ').first;
    final dateTextStyle = textStyle
        ?? Theme.of(context).textTheme.subtitle1
        ?? const TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w400);

    return Padding(
      padding: textPadding,
      child: Text(dateTextData, style: dateTextStyle)
    );
  }

  Widget _buildDateIcon() {
    if (hideIcon)
      return SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 15.0, end: 10.0),
      child: icon ?? const Icon(Icons.calendar_today_outlined,
          size: 18.0, color: const Color(0xFF666666))
    );
  }

  Future<DateTime?> _showDatePicker(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: initDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
      locale: pickerLocale ?? const Locale('ko'),
      helpText: pickerHelpText,
      cancelText: pickerCancelText,
      confirmText: pickerConfirmText,
      errorFormatText: pickerErrorFormatText,
      errorInvalidText: pickerErrorInvalidText,
      fieldHintText: pickerFieldHintText,
      fieldLabelText: pickerFieldLabelText
    );
  }
}
