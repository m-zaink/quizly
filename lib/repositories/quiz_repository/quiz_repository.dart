// **
// Created by Mohammed Sadiq on 25/05/20.
// **

import 'dart:convert';

import 'package:html_unescape/html_unescape.dart';
import 'package:meta/meta.dart';

import 'package:quizly/models/quiz.dart';
import 'package:quizly/models/quiz_settings.dart';
import 'package:quizly/utils/url_constructor/url_constructor.dart';
import 'package:http/http.dart' as http;

abstract class QuizRepository {
  factory QuizRepository() {
    return QuizRepositoryImpl();
  }

  Future<List<Quiz>> fetchQuizzes({@required QuizSettings settings});
}

class QuizRepositoryImpl implements QuizRepository {
  @override
  Future<List<Quiz>> fetchQuizzes({QuizSettings settings, String token}) async {
    String url = URLConstructor.constructURL(
      settings: settings,
      token: token,
    );

    try {
      // TODO: Make HTTP calls here
      http.Response response = await http.get(url);
      Map<String, dynamic> body = json.decode(response.body);
      if (body['response_code'] == 0) {
        List results = body['results'] as List;
        List<Quiz> quizzes = [];
        HtmlUnescape unescape = HtmlUnescape();
        for (int i = 0; i < results.length; ++i) {
          quizzes.add(
            Quiz(
              index: i,
              category: unescape
                  .convert(results[i]['category'] as String)
                  .replaceFirst(
                    'Entertainment: ',
                    '',
                  ),
              difficulty: unescape.convert(results[i]['difficulty'] as String),
              question: unescape.convert(results[i]['question'] as String),
              rightAnswer:
                  unescape.convert(results[i]['correct_answer'] as String),
              wrongAnswers: (results[i]['incorrect_answers'] as List)
                  .map(
                    (e) => unescape.convert(
                      e.toString(),
                    ),
                  )
                  .toList(),
              questionType: unescape.convert(results[i]['type'] as String),
            ),
          );
        }

        return quizzes;
      }
    } catch (e) {
      print(e);
    }

    return [];
  }
}
