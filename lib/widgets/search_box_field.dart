import 'package:flutter/material.dart';

import '../core/styles.dart';

class SearchBoxField extends StatefulWidget {
  final bool autofocus;
  final String hintText;

  SearchBoxField({
    Key key,
    this.autofocus: true,
    this.hintText: 'Buscar por...',
  }) : super(key: key);

  @override
  _SearchBoxFieldState createState() => _SearchBoxFieldState();
}

class _SearchBoxFieldState extends State<SearchBoxField> {
  @override
  Widget build(BuildContext context) =>
    SizedBox(
      height: 48,
      child: TextFormField(
        autofocus: widget.autofocus,
        cursorColor: kPrimaryColor,
        textInputAction: TextInputAction.search,
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 16),
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: kLightColor.withOpacity(0.5),
          ),
          fillColor: kPrimaryLightColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: kLightColor,
          ),
        ),
        style: TextStyle(
          color: kLightColor,
        ),
      ),
    );
}
