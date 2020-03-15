import 'package:flutter/material.dart';

import 'styles.dart';

class ScreenRouteTransition extends PageRouteBuilder {
  final Widget widget;

  ScreenRouteTransition({this.widget})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, Widget child) =>
          FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0)
              .animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Interval(0, 0.5, curve: Curves.easeIn),
                ),
              ),
            child: Container(
              color: kPrimaryColor,
              child: FadeTransition(
                opacity: Tween<double>(begin: 0, end: 1.0)
                  .animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Interval(0.5, 1.0, curve: Curves.linear),
                    ),
                  ),
                child: child,
              ),
            ),
          )
      );
}
