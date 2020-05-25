// **
// Created by Mohammed Sadiq on 25/05/20.
// **

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quizly/models/quiz_settings.dart';
import 'package:quizly/models/session.dart';
import 'package:quizly/reusable_components/choice_screen/choice_screen.dart';
import 'package:quizly/reusable_components/web_aware_body/web_aware_body.dart';
import 'package:quizly/screens/quiz_screen/quiz_bloc/bloc.dart';
import 'package:quizly/screens/quiz_screen/quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  QuizSettings quizSettings;

  @override
  void initState() {
    quizSettings = QuizSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: WebAwareBody(
            child: quizSettingsForm,
          ),
        ),
      ),
    );
  }

  Widget get quizSettingsForm => Form(
        key: _formState,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              logo,
              SizedBox(
                height: 20.0,
              ),
              questionCountTextFormField,
              if (foundation.kIsWeb)
                SizedBox(
                  height: 10.0,
                ),
              categoryPicker,
              if (foundation.kIsWeb)
                SizedBox(
                  height: 10.0,
                ),
              difficultyPicker,
              if (foundation.kIsWeb)
                SizedBox(
                  height: 10.0,
                ),
              questionTypePicker,
              letsGoCTA,
            ],
          ),
        ),
      );

  Widget get logo => Center(
        child: Container(
          width: 240.0,
          child: Image.asset('images/quizly_logo.png'),
        ),
      );

  Widget get questionCountTextFormField => TextFormField(
        decoration: InputDecoration(
          labelText: 'Quiz for how many questions?',
          counterText: '1 - 50',
        ),
        onChanged: (value) {
          if (value.isValidNumberOfQuestions) {
            quizSettings.numberOfQuestions = int.parse(value);
          }
        },
        validator: (input) {
          if (input.isEmpty || input.isNotValidNumberOfQuestions)
            return 'Please enter a valid number of questions';
          return null;
        },
      );

  Widget get categoryPicker => foundation.kIsWeb
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Category',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<Category>(
                value: quizSettings.category,
                isExpanded: true,
                onChanged: (value) {
                  setState(() => quizSettings.category = value);
                },
                items: Category.values
                    .map(
                      (e) => DropdownMenuItem<Category>(
                        value: e,
                        child: Text(
                          QuizSettings.categories[e],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        )
      : GestureDetector(
          child: ListTile(
            contentPadding: EdgeInsets.all(0.0),
            title: Text(
              QuizSettings.categories[quizSettings.category],
            ),
            subtitle: Text('Select Category'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChoiceScreen(
                  title: 'Category',
                  bodyBuilder: (context) => ListView.builder(
                    itemCount: Category.values.length,
                    itemBuilder: (context, index) => ListTile(
                      trailing: Icon(Icons.category),
                      title: Text(
                        QuizSettings.categories[Category.values[index]],
                      ),
                      onTap: () {
                        setState(() =>
                            quizSettings.category = Category.values[index]);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );

  Widget get difficultyPicker => foundation.kIsWeb
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Difficulty',
              style: TextStyle(color: Colors.grey),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<Difficulty>(
                value: quizSettings.difficulty,
                isExpanded: true,
                onChanged: (value) {
                  setState(() => quizSettings.difficulty = value);
                },
                items: Difficulty.values
                    .map(
                      (e) => DropdownMenuItem<Difficulty>(
                        value: e,
                        child: Text(
                          QuizSettings.difficulties[e],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        )
      : GestureDetector(
          child: ListTile(
            contentPadding: EdgeInsets.all(0.0),
            title: Text(
              QuizSettings.difficulties[quizSettings.difficulty],
            ),
            subtitle: Text('Select Difficulty Level'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChoiceScreen(
                  title: 'Difficulty Level',
                  bodyBuilder: (context) => ListView.builder(
                    itemCount: Difficulty.values.length,
                    itemBuilder: (context, index) => ListTile(
                      trailing: Icon(Icons.extension),
                      title: Text(
                        QuizSettings.difficulties[Difficulty.values[index]],
                      ),
                      onTap: () {
                        setState(() =>
                            quizSettings.difficulty = Difficulty.values[index]);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );

  Widget get questionTypePicker => foundation.kIsWeb
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Question Type',
              style: TextStyle(color: Colors.grey),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<QuestionType>(
                value: quizSettings.questionType,
                isExpanded: true,
                onChanged: (value) {
                  setState(() => quizSettings.questionType = value);
                },
                items: QuestionType.values
                    .map(
                      (e) => DropdownMenuItem<QuestionType>(
                        value: e,
                        child: Text(
                          QuizSettings.questionTypes[e],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        )
      : GestureDetector(
          child: ListTile(
            contentPadding: EdgeInsets.all(0.0),
            title: Text(
              QuizSettings.questionTypes[quizSettings.questionType],
            ),
            subtitle: Text('Select Question Type'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChoiceScreen(
                  title: 'Question Type',
                  bodyBuilder: (context) => ListView.builder(
                    itemCount: QuestionType.values.length,
                    itemBuilder: (context, index) => ListTile(
                      trailing: Icon(Icons.bubble_chart),
                      title: Text(
                        QuizSettings.questionTypes[QuestionType.values[index]],
                      ),
                      onTap: () {
                        setState(() => quizSettings.questionType =
                            QuestionType.values[index]);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );

  Widget get letsGoCTA => Align(
        alignment: Alignment.centerRight,
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: RaisedButton(
            child: Text(
              'Let\'s go',
            ),
            onPressed: () {
              if (_formState.currentState.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(
                      quizSettings: quizSettings,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      );
}

extension on String {
  bool get isValidNumberOfQuestions =>
      RegExp(r'^(50|[1-4][0-9]|[1-9])$').hasMatch(this);

  bool get isNotValidNumberOfQuestions => !isValidNumberOfQuestions;
}
