import 'package:flutter/material.dart';

import '../core/styles.dart';

class BottomBar extends StatelessWidget {
  final List<Widget> children;

  const BottomBar({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Container(
      height: 56,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 4, offset: Offset(0, -2))]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
}
