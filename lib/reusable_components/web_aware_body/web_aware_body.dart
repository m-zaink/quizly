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
    return Center(
      child: FractionallySizedBox(
        widthFactor: kIsWeb ? 0.6 : 1.0,
        child: child,
      ),
    );
  }
}