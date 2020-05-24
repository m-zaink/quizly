// **
// Created by Mohammed Sadiq on 25/05/20.
// **

import 'package:flutter/material.dart';
import 'package:quizly/models/quiz_settings.dart';
import 'package:quizly/reusable_components/choice_screen/choice_screen.dart';
import 'package:quizly/reusable_components/web_aware_body/web_aware_body.dart';

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
            child: Form(
              key: _formState,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 240.0,
                        child: Image.asset('images/quizly_logo.png'),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Quiz for how many questions?',
                        counterText: '1 - 50',
                      ),
                      validator: (input) {
                        if (input.isEmpty || input.isNotValidNumberOfQuestions)
                          return 'Please enter a valid number of questions';
                        return null;
                      },
                    ),
                    categoryPicker,
                    difficultyPicker,
                    questionTypePicker,
                    Align(
                      alignment: Alignment.centerRight,
                      child: FractionallySizedBox(
                        widthFactor: 0.5,
                        child: RaisedButton(
                          child: Text(
                            'Let\'s go',
                          ),
                          onPressed: () {
                            if (_formState.currentState.validate()) {
                              // TODO: Do something
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get categoryPicker => GestureDetector(
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
                      setState(
                          () => quizSettings.category = Category.values[index]);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          );
        },
      );

  Widget get difficultyPicker => GestureDetector(
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

  Widget get questionTypePicker => GestureDetector(
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
}

extension on String {
  bool get isValidNumberOfQuestions =>
      RegExp(r'^(50|[1-4][0-9]|[1-9])$').hasMatch(this);

  bool get isNotValidNumberOfQuestions => !isValidNumberOfQuestions;
}
