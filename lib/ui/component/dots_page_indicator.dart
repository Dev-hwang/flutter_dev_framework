import 'dart:math';
import 'package:flutter/material.dart';

/// 도트형 페이지 인디케이터
class DotsPageIndicator extends AnimatedWidget {
  final PageController pageController;
  final int pageCount;

  final Color? color;
  final double dotSize;
  final double spacing;
  final double zoomScale;

  const DotsPageIndicator({
    Key? key,
    required this.pageController,
    required this.pageCount,
    this.color,
    this.dotSize = 6.0,
    this.spacing = 20.0,
    this.zoomScale = 2.0
  })  : assert(dotSize >= 0),
        assert(spacing >= 0),
        assert(zoomScale >= 0),
        super(key: key, listenable: pageController);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(pageCount, (index) => _buildDot(context, index))
    );
  }

  Widget _buildDot(BuildContext context, int index) {
    final t = max(0.0, 1.0 - (_pageOffset - index).abs());
    final zoom = 1.0 + (zoomScale - 1.0) * Curves.easeOut.transform(t);

    return SizedBox(
      width: spacing,
      child: Center(
        child: Material(
          type: MaterialType.circle,
          color: color ?? Theme.of(context).accentColor,
          child: SizedBox(
            width: dotSize * zoom,
            height: dotSize * zoom
          ),
        ),
      ),
    );
  }

  double get _pageOffset =>
      pageController.page ?? pageController.initialPage.toDouble();
}
