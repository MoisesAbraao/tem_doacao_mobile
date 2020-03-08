import 'dart:math' show max;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../core/styles.dart';
import 'widgets.dart';

class SliverFeedAppBar extends StatelessWidget {
  final String searchBoxText;
  final void Function() onSearchBoxPressed;

  const SliverFeedAppBar({
    Key key,
    this.searchBoxText,
    @required this.onSearchBoxPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    SliverPersistentHeader(
      floating: false,
      pinned: true,
      delegate: _SliverFeedAppBarDelegate(
        statusBarHeight: MediaQuery.of(context).padding.top,
        searchBoxText: searchBoxText,
        onSearchBoxPressed: onSearchBoxPressed,
      ),
    );
}

class _SliverFeedAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double statusBarHeight;
  final String searchBoxText;
  final void Function() onSearchBoxPressed;

  _SliverFeedAppBarDelegate({
    @required this.statusBarHeight,
    this.searchBoxText,
    @required this.onSearchBoxPressed,
  });

  @override
  double get minExtent => statusBarHeight + 120;

  @override
  double get maxExtent => statusBarHeight + 256;

  @override
  bool shouldRebuild(covariant _SliverFeedAppBarDelegate oldDelegate) => true;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double searchBarHeight = 56.0;
    final double appBarTranslationSize = maxExtent - minExtent;
    final double appBarHeight = minExtent + max(0.0, appBarTranslationSize - shrinkOffset);
    final double titleBarHeight = appBarHeight - searchBarHeight;
    final double progress = (shrinkOffset / appBarTranslationSize).clamp(0.0, 1.0);

    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        boxShadow: shrinkOffset > (maxExtent - minExtent)
          ? [BoxShadow(color: Colors.black38, blurRadius: 4, offset: Offset(0, 2))]
          : null,
      ),
      child: Column(
        children: <Widget>[
          // title
          Container(
            alignment: Alignment.center,
            height: titleBarHeight,
            padding: EdgeInsets.only(top: statusBarHeight),
            child: Text(
              'Tem doação',
              style: TextStyle(
                color: kLightColor,
                fontSize: lerpDouble(kTextH3Size, kTextH5Size, progress),
              ),
            ),
          ),

          // searchbar
          Container(
            alignment: Alignment.topCenter,
            height: searchBarHeight,
            child: SearchBoxButton(
              text: searchBoxText,
              onPressed: onSearchBoxPressed,
            ),
          ),
        ],
      ),
    );
  }
}
