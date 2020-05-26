// **
// Created by Mohammed Sadiq on 25/05/20.
// **

import 'package:flutter_test/flutter_test.dart';
import 'package:quizly/domain/entities/quiz_settings.dart';
import 'package:quizly/utils/url_constructor/url_constructor.dart';

void main() {
  QuizSettings quizSettings;

  group(
    'Tests for amount',
    () {
      setUp(() {
        quizSettings = QuizSettings();
      });

      test(
        'should create a URL with default amount = ${QuizSettings.defaultNumberOfQuestions}',
        () {
          // Arrange
          String expectedURL =
              'https://opentdb.com/api.php?amount=${QuizSettings.defaultNumberOfQuestions}';

          // Act
          String actualURL = URLConstructor.constructURL(settings: quizSettings);

          // Assert
          expect(actualURL, expectedURL);
        },
      );

      test(
        'should create a URL with default amount = 20',
        () {
          // Arrange
          String expectedURL = 'https://opentdb.com/api.php?amount=20';
          quizSettings.numberOfQuestions = 20;

          // Act
          String actualURL = URLConstructor.constructURL(settings: quizSettings);

          // Assert
          expect(actualURL, expectedURL);
        },
      );

      tearDown(() {
        quizSettings = null;
      });
    },
  );

  group('Tests for categories', () {
    setUp(() {
      quizSettings = QuizSettings();
    });

    test(
      'should create a URL with amount = ${QuizSettings.defaultNumberOfQuestions} and category = ${Category.anime.index + 8}',
      () {
        // Arrange
        String expectedURL =
            'https://opentdb.com/api.php?amount=${QuizSettings.defaultNumberOfQuestions}&category=${Category.anime.index + 8}';
        quizSettings.category = Category.anime;

        // Act
        String actualURL = URLConstructor.constructURL(settings: quizSettings);

        // Assert
        expect(actualURL, expectedURL);
      },
    );

    test(
      'should create URL which does not contain category query param in it when quizSettings.category = Category.any',
      () {
        // Arrange
        quizSettings.category = Category.any;

        // Act
        String actualURL = URLConstructor.constructURL(settings: quizSettings);

        // Assert
        expect(actualURL.contains('category'), false);
      },
    );

    tearDown(() {
      quizSettings = null;
    });
  });

  group('Tests for difficulties', () {
    setUp(() {
      quizSettings = QuizSettings();
    });

    test(
      'should create a URL with amount = ${QuizSettings.defaultNumberOfQuestions} and difficulty = medium',
      () {
        // Arrange
        String expectedURL =
            'https://opentdb.com/api.php?amount=${QuizSettings.defaultNumberOfQuestions}&difficulty=medium';
        quizSettings.difficulty = Difficulty.medium;

        // Act
        String actualURL = URLConstructor.constructURL(settings: quizSettings);

        // Assert
        expect(actualURL, expectedURL);
      },
    );

    test(
      'should create URL which does not contain difficulty query param in it when quizSettings.difficulty = Difficulty.any',
      () {
        // Arrange
        quizSettings.difficulty = Difficulty.any;

        // Act
        String actualURL = URLConstructor.constructURL(settings: quizSettings);

        // Assert
        expect(actualURL.contains('difficulty'), false);
      },
    );

    tearDown(() {
      quizSettings = null;
    });
  });

  group('Tests for question types', () {
    setUp(() {
      quizSettings = QuizSettings();
    });

    test(
      'should create a URL with amount = ${QuizSettings.defaultNumberOfQuestions} and type = boolean',
      () {
        // Arrange
        String expectedURL =
            'https://opentdb.com/api.php?amount=${QuizSettings.defaultNumberOfQuestions}&type=boolean';
        quizSettings.questionType = QuestionType.trueOfFalse;

        // Act
        String actualURL = URLConstructor.constructURL(settings: quizSettings);

        // Assert
        expect(actualURL, expectedURL);
      },
    );

    test(
      'should create URL which does not contain type query param in it when quizSettings.questionType = QuestionType.any',
      () {
        // Arrange
        quizSettings.difficulty = Difficulty.any;

        // Act
        String actualURL = URLConstructor.constructURL(settings: quizSettings);

        // Assert
        expect(actualURL.contains('type'), false);
      },
    );

    tearDown(() {
      quizSettings = null;
    });
  });

  group('Tests for a complete URl with all three options involved', () {
    setUp(() {
      quizSettings = QuizSettings();
    });

    test(
      'should create a URL with amount = ${QuizSettings.defaultNumberOfQuestions}, category = ${Category.anime.index + 8}, type = boolean, and difficulty = medium,',
      () {
        // Arrange
        String expectedURL =
            'https://opentdb.com/api.php?amount=${QuizSettings.defaultNumberOfQuestions}&category=${Category.anime.index + 8}&type=boolean&difficulty=medium';
        quizSettings.category = Category.anime;
        quizSettings.questionType = QuestionType.trueOfFalse;
        quizSettings.difficulty = Difficulty.medium;

        // Act
        String actualURL = URLConstructor.constructURL(settings: quizSettings);

        // Assert
        expect(actualURL, expectedURL);
      },
    );

    tearDown(() {
      quizSettings = null;
    });
  });
}
