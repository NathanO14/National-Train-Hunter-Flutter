import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

Route createAnimatedRoute(Widget screen, {RouteSettings routeSettings}) {
  return PageRouteBuilder(
    settings: routeSettings,
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SharedAxisTransition(
      child: child,
      animation: CurvedAnimation(
        parent: animation,
        curve: Curves.linear,
      ),
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.horizontal,
    ),
  );
}
