import 'package:flutter/material.dart';

import '../core/styles.dart';
import 'tappable_widget.dart';

class CategoryChip extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const CategoryChip({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    TappableWidget(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(21),
        ),
        height: 42,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          widthFactor: 1,
          child: Text(
            text,
            style: TextStyle(
              color: kLightColor,
              fontSize: kTextH6Size,
            ),
          ),
        ),
      ),
    );
}
