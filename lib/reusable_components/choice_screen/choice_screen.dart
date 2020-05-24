// **
// Created by Mohammed Sadiq on 25/05/20.
// **
import 'package:flutter/material.dart';
import 'package:quizly/reusable_components/web_aware_body/web_aware_body.dart';

class ChoiceScreen extends StatelessWidget {
  final String title;
  final WidgetBuilder bodyBuilder;

  const ChoiceScreen(
      {Key key, @required this.title, @required this.bodyBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0.0,
      ),
      body: WebAwareBody(child: bodyBuilder(context)),
    );
  }
}
