import 'package:flutter/material.dart';

import '../core/styles.dart';

class SearchBoxButton extends StatelessWidget {
  final String placeholder;
  final String text;
  final void Function() onPressed;

  const SearchBoxButton({
    Key key,
    this.placeholder: 'Buscar por...',
    this.text,
    @required this.onPressed,
  }) : assert(placeholder != null),
       assert(onPressed != null),
       super(key: key);

  @override
  Widget build(BuildContext context) =>
    Material(
      color: kPrimaryLightColor,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: onPressed,
        child: Container(
          height: 48,
          width: MediaQuery.of(context).size.width - 32,
          child: Row(
            children: <Widget>[
              const SizedBox(width: 16),

              const Icon(
                Icons.search,
                color: kLightColor,
                size: 24,
              ),

              const SizedBox(width: 8),

              text == null || text == ''
                ? Text(
                    placeholder,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: kLightColor.withOpacity(0.5),
                      fontSize: kTextH6Size,
                    ),
                  )
                : Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: kLightColor,
                      fontSize: kTextH6Size,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
}
