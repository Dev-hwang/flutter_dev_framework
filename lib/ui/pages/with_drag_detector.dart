import 'package:flutter/material.dart';

/// 드래그 탐지 기능이 구현된 페이지
class WithDragDetector extends StatelessWidget {
  /// 탐지할 드래그 방향
  final Axis direction;

  /// 자식 위젯
  final Widget child;

  /// 드래그 탐지 콜백
  final VoidCallback onPageDragged;

  const WithDragDetector({
    Key? key,
    required this.direction,
    required this.child,
    required this.onPageDragged
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (direction == Axis.vertical)
        ? _buildVerticalDragDetector()
        : _buildHorizontalDragDetector();
  }

  Widget _buildVerticalDragDetector() {
    DragStartDetails? dragStartDetails;
    DragUpdateDetails? dragUpdateDetails;

    return GestureDetector(
      child: child,
      behavior: HitTestBehavior.translucent,
      onVerticalDragStart: (dragDetails) => dragStartDetails = dragDetails,
      onVerticalDragUpdate: (dragDetails) => dragUpdateDetails = dragDetails,
      onVerticalDragEnd: (dragDetails) {
        if (dragStartDetails == null) return;
        if (dragUpdateDetails == null) return;

        double dx = dragUpdateDetails!.globalPosition.dx - dragStartDetails!.globalPosition.dx;
        double dy = dragUpdateDetails!.globalPosition.dy - dragStartDetails!.globalPosition.dy;
        double? velocity = dragDetails.primaryVelocity;
        if (velocity == null) return;

        if (dx < 0) dx = -dx;
        if (dy < 0) dy = -dy;
        if (dy > 150 && velocity > 300) onPageDragged();
      }
    );
  }

  Widget _buildHorizontalDragDetector() {
    DragStartDetails? dragStartDetails;
    DragUpdateDetails? dragUpdateDetails;

    return GestureDetector(
      child: child,
      behavior: HitTestBehavior.translucent,
      onHorizontalDragStart: (dragDetails) => dragStartDetails = dragDetails,
      onHorizontalDragUpdate: (dragDetails) => dragUpdateDetails = dragDetails,
      onHorizontalDragEnd: (dragDetails) {
        if (dragStartDetails == null) return;
        if (dragUpdateDetails == null) return;

        double dx = dragUpdateDetails!.globalPosition.dx - dragStartDetails!.globalPosition.dx;
        double dy = dragUpdateDetails!.globalPosition.dy - dragStartDetails!.globalPosition.dy;
        double? velocity = dragDetails.primaryVelocity;
        if (velocity == null) return;

        if (dx < 0) dx = -dx;
        if (dy < 0) dy = -dy;
        if (dx > 100 && velocity > 300) onPageDragged();
      }
    );
  }
}
