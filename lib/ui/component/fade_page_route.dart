import 'package:flutter/material.dart';

/// FadeTransition PageRoute
class FadePageRoute extends MaterialPageRoute {
  FadePageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings
  })  : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child
  ) {
    // if (settings.isInitialRoute)
    //   return child;
    return FadeTransition(opacity: animation, child: child);
  }
}
