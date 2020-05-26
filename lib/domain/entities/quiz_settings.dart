// **
// Created by Mohammed Sadiq on 25/05/20.
// **

class QuizSettings {
  int numberOfQuestions = 10;
  Category category = Category.any;
  Difficulty difficulty = Difficulty.any;
  QuestionType questionType = QuestionType.any;

  static Map<Category, String> get categories => {
        Category.any: 'Any',
        Category.generalKnowledge: 'General Knowledge',
        Category.books: 'Books',
        Category.films: 'Films',
        Category.music: 'Music',
        Category.musicalsAndTheatre: 'Musicals & Theatre',
        Category.television: 'Television',
        Category.videoGames: 'Video Games',
        Category.boardGames: 'Board Games',
        Category.scienceAndNature: 'Science & Nature',
        Category.computers: 'Computers',
        Category.mathematics: 'Mathematics',
        Category.mythology: 'Mythology',
        Category.sports: 'Sports',
        Category.geography: 'Geography',
        Category.history: 'History',
        Category.politics: 'Politics',
        Category.art: 'Art',
        Category.celebs: 'Celebs',
        Category.animals: 'Animals',
        Category.vehicles: 'Vehicles',
        Category.comics: 'Comics',
        Category.gadgets: 'Gadgets',
        Category.anime: 'Anime',
        Category.cartoons: 'Cartoons'
      };

  static Map<Difficulty, String> get difficulties => {
        Difficulty.any: 'Any',
        Difficulty.easy: 'Easy',
        Difficulty.medium: 'Medium',
        Difficulty.hard: 'Hard',
      };

  static Map<QuestionType, String> get questionTypes => {
        QuestionType.any: 'Any',
        QuestionType.trueOfFalse: 'True / False',
        QuestionType.multipleChoice: 'Multiple Choice'
      };

  static int get defaultNumberOfQuestions => 10;

  static Category get defaultCategory => Category.any;

  static Difficulty get defaultDifficulty => Difficulty.any;

  static QuestionType get defaultType => QuestionType.any;
}

enum Difficulty { any, easy, medium, hard }

enum QuestionType { any, trueOfFalse, multipleChoice }

enum Category {
  any,
  generalKnowledge,
  books,
  films,
  music,
  musicalsAndTheatre,
  television,
  videoGames,
  boardGames,
  scienceAndNature,
  computers,
  mathematics,
  mythology,
  sports,
  geography,
  history,
  politics,
  art,
  celebs,
  animals,
  vehicles,
  comics,
  gadgets,
  anime,
  cartoons,
}
