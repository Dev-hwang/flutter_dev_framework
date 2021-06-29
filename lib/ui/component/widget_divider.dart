import 'package:flutter/material.dart';

/// 위젯 구분선
class WidgetDivider extends StatelessWidget {
  final Axis direction;
  final bool drawDash;
  final double platLineWidth;
  final double platLineHeight;
  final double dashLineWidth;
  final double dashLineHeight;
  final double marginStart;
  final double marginEnd;
  final Color? color;

  const WidgetDivider({
    Key? key,
    required this.direction,
    this.drawDash = false,
    this.platLineWidth = 1.0,
    this.platLineHeight = 1.0,
    this.dashLineWidth = 1.0,
    this.dashLineHeight = 1.0,
    this.marginStart = 0.0,
    this.marginEnd = 0.0,
    this.color
  })  : assert(platLineWidth > 0.0),
        assert(platLineHeight > 0.0),
        assert(dashLineWidth > 0.0),
        assert(dashLineHeight > 0.0),
        assert(marginStart >= 0.0),
        assert(marginEnd >= 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return (this.drawDash)
            ? _buildDashLine(context, constraints)
            : _buildPlatLine(context, constraints);
      }
    );
  }

  Widget _buildPlatLine(BuildContext context, constraints) {
    return Container(
      color: color ?? Theme.of(context).dividerColor,
      width: (direction == Axis.vertical)
          ? platLineWidth
          : double.infinity,
      height: (direction == Axis.vertical)
          ? double.infinity 
          : platLineHeight,
      margin: (direction == Axis.vertical)
          ? EdgeInsets.only(top: marginStart, bottom: marginEnd)
          : EdgeInsets.only(left: marginStart, right: marginEnd)
    );
  }

  Widget _buildDashLine(BuildContext context, constraints) {
    final boxSize = (direction == Axis.vertical)
        ? constraints.constrainHeight()
        : constraints.constrainWidth();

    final dashCount = (direction == Axis.vertical)
        ? (boxSize / (2 * dashLineHeight)).floor()
        : (boxSize / (2 * dashLineWidth)).floor();

    return Container(
      margin: (direction == Axis.vertical)
          ? EdgeInsets.only(top: marginStart, bottom: marginEnd)
          : EdgeInsets.only(left: marginStart, right: marginEnd),
      child: Flex(
        direction: direction,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(dashCount, (_) {
          return SizedBox(
            width: dashLineWidth,
            height: dashLineHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color ?? Theme.of(context).dividerColor
              ),
            ),
          );
        })
      ),
    );
  }
}
