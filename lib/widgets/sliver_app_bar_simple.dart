import 'package:flutter/material.dart';

import '../core/styles.dart';

class SliverAppBarSimple extends StatelessWidget {
  final double contentHeight;
  final Widget content;

  const SliverAppBarSimple({
    Key key,
    this.contentHeight: 64,
    @required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    SliverPersistentHeader(
      floating: false,
      pinned: true,
      delegate: _SliverAppBarSimpleDelegate(
        height: MediaQuery.of(context).padding.top + contentHeight,
        child: content,
      ),
    );
}

class _SliverAppBarSimpleDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  _SliverAppBarSimpleDelegate({
    @required this.height,
    @required this.child,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  bool shouldRebuild(covariant _SliverAppBarSimpleDelegate oldDelegate) => true;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) =>
    Material(
      color: kPrimaryColor,
      child: Container(
        height: minExtent,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
          boxShadow: shrinkOffset > 0
            ? [BoxShadow(color: Colors.black38, blurRadius: 4, offset: Offset(0, 2))]
            : null,
        ),
        child: child,
      ),
    );
}
