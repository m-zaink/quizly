// **
// Created by Mohammed Sadiq on 25/05/20.
// **

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WebAwareBody extends StatelessWidget {
  final Widget child;

  const WebAwareBody({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget safeArea = SafeArea(
      child: child,
    );

    return kIsWeb
        ? Center(
            child: FractionallySizedBox(
              widthFactor: widthFactor(context),
              child: safeArea,
            ),
          )
        : safeArea;
  }

  double widthFactor(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1920)
      return 0.3;
    else if (screenWidth > 1024)
      return 0.6;
    else if (screenWidth > 720)
      return 0.7;
    else
      return 0.9;
  }
}
