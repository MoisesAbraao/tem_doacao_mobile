import 'package:flutter/material.dart';

import '../core/styles.dart';

class RecentlySearchedTile extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const RecentlySearchedTile({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    SizedBox(
      height: 48,
      child: Material(
        color: kPrimaryColor,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.update,
                  color: kLightColor,
                  size: 24,
                ),

                const SizedBox(width: 8),

                Text(
                  text,
                  style: TextStyle(
                    color: kLightColor,
                    fontSize: kTextH6Size,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
}
