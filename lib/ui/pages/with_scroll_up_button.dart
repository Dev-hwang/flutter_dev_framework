import 'package:flutter/material.dart';

/// 스크롤업 버튼 구현 페이지
class WithScrollUpButton extends StatefulWidget {
  /// 스크롤업 버튼을 가질 리스트뷰로 컨트롤러를 포함해야 함
  final ListView listView;

  /// 버튼 색상
  /// 기본값 `Theme.of(context).accentColor`
  final Color? buttonColor;

  /// 버튼 투명도
  /// 기본값 `0.8`
  final double buttonOpacity;

  /// 버튼 아이콘
  /// 기본값 `Icons.keyboard_arrow_up`
  final IconData buttonIcon;

  /// 미니 버튼 사용 여부
  /// 기본값 `false`
  final bool buttonMini;

  /// 버튼 바깥 여백
  /// 기본값 `const EdgeInsets.all(12.0)`
  final EdgeInsetsGeometry buttonMargin;

  const WithScrollUpButton({
    Key? key,
    required this.listView,
    this.buttonColor,
    this.buttonOpacity = 0.8,
    this.buttonIcon = Icons.keyboard_arrow_up,
    this.buttonMini = false,
    this.buttonMargin = const EdgeInsets.all(12.0)
  })  : assert(buttonOpacity >= 0.0 && buttonOpacity <= 1.0),
        super(key: key);

  @override
  _WithScrollUpButtonState createState() => _WithScrollUpButtonState();
}

class _WithScrollUpButtonState extends State<WithScrollUpButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  bool _visibleScrollUpButton = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200)
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0)
    ).animate(_animationController);

    widget.listView.controller?.addListener(() {
      if (widget.listView.controller?.offset == 0.0) {
        if (_visibleScrollUpButton) {
          _animationController.reverse();
          _visibleScrollUpButton = false;
        }
      } else {
        if (!_visibleScrollUpButton) {
          _animationController.forward();
          _visibleScrollUpButton = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        widget.listView,
        _buildScrollUpButton()
      ],
    );
  }

  Widget _buildScrollUpButton() {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        margin: widget.buttonMargin,
        child: Opacity(
          opacity: widget.buttonOpacity,
          child: FloatingActionButton(
            backgroundColor: widget.buttonColor
                ?? Theme.of(context).accentColor,
            mini: widget.buttonMini,
            child: Icon(widget.buttonIcon),
            onPressed: () {
              widget.listView.controller?.animateTo(
                0.0,
                duration: const Duration(milliseconds: 250),
                curve: Curves.fastOutSlowIn
              );
            },
          ),
        ),
      ),
    );
  }
}
