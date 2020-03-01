import 'package:flutter/material.dart';

import '../core/styles.dart';
import 'tappable_widget.dart';

class BottomBarItem extends StatelessWidget {
  final IconData icon;
  final bool active;
  final void Function() onPressed;

  const BottomBarItem({
    Key key,
    @required this.icon,
    this.active: true,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    TappableWidget(
      onPressed: onPressed,
      child: SizedBox(
        height: 48,
        width: 48,
        child: Icon(
          icon,
          color: active
            ? kLightColor
            : kLightColor.withOpacity(0.5),
          size: 32,
        ),
      ),
    );
}
