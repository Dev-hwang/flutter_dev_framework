import 'package:flutter/material.dart';
import 'package:flutter_dev_framework/ui/button/model/button_size.dart';

/// 메뉴 선택 버튼
class DropDownButton extends StatelessWidget {
  /// 버튼 색상
  /// 기본값 `Colors.transparent`
  final Color color;

  /// 버튼 테두리
  /// 기본값 `Border.all(color: Theme.of(context).buttonColor)`
  final Border? border;

  /// 버튼 테두리(disabled)
  /// 기본값 `Border.all(color: Theme.of(context).disabledColor)`
  final Border? disabledBorder;

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

  /// 드롭다운 버튼 색상
  final Color? dropdownColor;

  /// 드롭다운 버튼 그림자 높이
  /// 기본값 `8`
  final int dropdownElevation;

  /// 메뉴 리스트
  final List<String> menuList;

  /// 선택된 메뉴, 메뉴 리스트에 포함되어 있어야 함
  final String? menu;

  /// 메뉴 텍스트 스타일
  /// 기본값 `Theme.of(context).textTheme.subtitle1 ??
  /// const TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w400)`
  final TextStyle? menuStyle;

  /// 메뉴 내부 여백
  /// 기본값 `const EdgeInsets.only(left: 10.0)`
  final EdgeInsetsGeometry menuPadding;

  /// 힌트 텍스트
  final String? hint;

  /// 힌트 텍스트 스타일
  /// 기본값 `Theme.of(context).textTheme.subtitle1?.copyWith(color: Theme.of(context).hintColor) ??
  /// TextStyle(color: Theme.of(context).hintColor, fontSize: 17.0, fontWeight: FontWeight.w400)`
  final TextStyle? hintStyle;

  /// 힌트 텍스트(disabled)
  final String? disabledHint;

  /// 힌트 텍스트 스타일(disabled)
  /// 기본값 `Theme.of(context).textTheme.subtitle1?.copyWith(color: Theme.of(context).disabledColor) ??
  /// TextStyle(color: Theme.of(context).disabledColor, fontSize: 17.0, fontWeight: FontWeight.w400)`
  final TextStyle? disabledHintStyle;

  /// 아이콘
  final Icon? icon;

  /// 아이콘 숨김 여부
  /// 기본값 `false`
  final bool hideIcon;

  /// 메뉴 선택 콜백 함수
  final ValueChanged<String?>? onChanged;

  const DropDownButton({
    Key? key,
    this.color = Colors.transparent,
    this.border,
    this.disabledBorder,
    this.borderRadius,
    this.buttonSize = ButtonSize.MATERIAL_LARGE,
    this.elevation = 0.0,
    this.expanded = false,
    this.dropdownColor,
    this.dropdownElevation = 8,
    required this.menuList,
    this.menu,
    this.menuStyle,
    this.menuPadding = const EdgeInsets.only(left: 10.0),
    this.hint,
    this.hintStyle,
    this.disabledHint,
    this.disabledHintStyle,
    this.icon,
    this.hideIcon = false,
    this.onChanged
  })  : assert(elevation >= 0),
        assert(dropdownElevation >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Border determinedBorder;
    if (onChanged != null)
      determinedBorder = border
          ?? Border.all(color: Theme.of(context).buttonColor);
    else
      determinedBorder = disabledBorder
          ?? Border.all(color: Theme.of(context).disabledColor);

    final determinedMenuStyle = menuStyle
        ?? Theme.of(context).textTheme.subtitle1
        ?? const TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w400);

    return Material(
      elevation: elevation,
      borderRadius: borderRadius,
      color: color,
      child: Container(
        height: buttonSize.minHeight,
        decoration: BoxDecoration(
          border: determinedBorder,
          borderRadius: borderRadius
        ),
        child: DropdownButton<String>(
          items: _buildDropdownMenuItems(),
          value: menu,
          style: determinedMenuStyle,
          hint: _buildHintText(context),
          disabledHint: _buildHintText(context, disabled: true),
          isExpanded: expanded,
          icon: hideIcon
              ? const SizedBox.shrink()
              : icon,
          underline: const SizedBox.shrink(),
          elevation: dropdownElevation,
          dropdownColor: dropdownColor,
          onChanged: onChanged
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownMenuItems() {
    return List.generate(menuList.length, (index) {
      return DropdownMenuItem<String>(
        value: menuList[index],
        child: Padding(
          padding: menuPadding,
          child: Text(menuList[index])
        ),
      );
    });
  }

  Widget _buildHintText(BuildContext context, {bool disabled = false}) {
    String? determinedHint;
    TextStyle? determinedHintStyle;

    if (hint != null && !disabled) {
      determinedHint = hint!;
      determinedHintStyle = hintStyle
          ?? Theme.of(context).textTheme.subtitle1?.copyWith(color: Theme.of(context).hintColor)
          ?? TextStyle(color: Theme.of(context).hintColor, fontSize: 17.0, fontWeight: FontWeight.w400);
    } else if (disabledHint != null && disabled) {
      determinedHint = disabledHint!;
      determinedHintStyle = disabledHintStyle
          ?? Theme.of(context).textTheme.subtitle1?.copyWith(color: Theme.of(context).disabledColor)
          ?? TextStyle(color: Theme.of(context).disabledColor, fontSize: 17.0, fontWeight: FontWeight.w400);
    }

    if (determinedHint == null)
      return SizedBox.shrink();

    return Padding(
      padding: menuPadding,
      child: Text(determinedHint, style: determinedHintStyle)
    );
  }
}
