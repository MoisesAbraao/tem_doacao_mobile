import 'package:flutter/material.dart';

class TappableWidget extends StatefulWidget {
  final Widget child;
  final void Function() onPressed;

  TappableWidget({
    Key key,
    @required this.child,
    @required this.onPressed,
  }) : super(key: key);

  @override
  _TappableWidgetState createState() => _TappableWidgetState();
}

class _TappableWidgetState extends State<TappableWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _tapped = false;
  bool _animated = false;
  bool _canceled = false;

  static Tween scale = Tween(begin: 1.0, end: 0.97);
  static Tween filterColorOpacity = Tween(begin: .0, end: .3);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    )
    ..addListener(() => setState(() {}))
    ..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _animated = true;
        if (!_tapped)
          _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        if (!_canceled)
          widget.onPressed();
      }
    });
  }

  @override
  void dispose() { 
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
    GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTapCancel: _tapCancel,
      child: Transform.scale(
        scale: scale.evaluate(_controller),
        child: widget.child,
      ),
    );

  void _tapDown(TapDownDetails details) {
    _tapped = true;
    _animated = false;
    _canceled = false;
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _tapped = false;
    if (_animated) {
      _controller.reverse();
    }
  }

  void _tapCancel() {
    _tapped = false;
    _canceled = true;
    _controller.reverse();
  }
}
