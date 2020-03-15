import 'package:flutter/material.dart';

import '../core/styles.dart';

class ScreenFeedbackInfo extends StatelessWidget {
  final String assetName;
  final String message;

  const ScreenFeedbackInfo({
    Key key,
    @required this.assetName,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 144,
          width: 144,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kGreyColor[400],
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 8, offset: Offset(0, 4))],
          ),
          child: Center(
            child: Image.asset(
              assetName,
              height: 96,
              width: 96,
            ),
          ),
        ),

        const SizedBox(height: 32),

        SizedBox(
          width: 300,
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kGreyColor[50],
              fontSize: kTextH5Size,
            ),
          ),
        ),
      ],
    );
}
