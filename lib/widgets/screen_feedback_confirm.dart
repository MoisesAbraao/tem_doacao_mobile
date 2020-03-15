import 'package:flutter/material.dart';

import '../core/styles.dart';
import 'screen_feedback_info.dart';

class ScreenFeedbackConfirm extends StatelessWidget {
  final String assetName;
  final String message;
  final String confirmText;
  final void Function() onConfirmPressed;

  const ScreenFeedbackConfirm({
    Key key,
    @required this.assetName,
    @required this.message,
    @required this.confirmText,
    @required this.onConfirmPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Column(
      children: <Widget>[
        ScreenFeedbackInfo(
          assetName: assetName,
          message: message,
        ),

        const SizedBox(height: 16),

        FlatButton(
          highlightColor: kPrimaryLightColor,
          splashColor: Colors.transparent,
          child: Text(
            confirmText,
            style: TextStyle(
              color: kAccentColor,
              fontSize: kTextH6Size,
            ),
          ),
          onPressed: onConfirmPressed,
        )
      ],
    );
}
