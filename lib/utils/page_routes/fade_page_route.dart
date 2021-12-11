import 'package:flutter/material.dart';

class FadePageRoute<T> extends PageRoute<T> {
  final BuildContext context;

  FadePageRoute(this.child, {required this.context});

  @override
  Color get barrierColor => Theme.of(this.context).backgroundColor;

  @override
  String? get barrierLabel => null;

  final Widget child;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);
}
