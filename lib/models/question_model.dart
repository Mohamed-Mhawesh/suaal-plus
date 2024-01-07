class QuestionsModel {
  final int? id, subject_id;
  final String title;
  final String type;
  final String learning_type;
  final String? year_time;
  //final List<String> options;
  bool isAnswered = false;
  int selectedAnswer = -1;

  QuestionsModel({
   required this.learning_type,
    required this.id,
    required this.title,
    required this.subject_id,
    required this.type,
    required this.year_time,
    // required this.options,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> jsonData) {
    return QuestionsModel(
      id: jsonData['id'],
      title: jsonData['title'],
      subject_id: jsonData['subject_id'],
      type: jsonData['type'],
      year_time: jsonData['year_time'],
     learning_type : jsonData['learning_type'],

    );
  }
}

class AnswerModel {
  final int? id, is_correct, question_id;
  final String title;

  int selectedAnswer = -1;

  AnswerModel({
    required this.id,
    required this.title,
    required this.is_correct,
    required this.question_id,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> jsonData) {
    return AnswerModel(
        id: jsonData['id'],
        title: jsonData['title'],
        is_correct: jsonData['is_correct'],
        question_id: jsonData['question_id']);
  }
}

class Question {
  final List<dynamic> questions;

  Question({required this.questions});
  factory Question.fromJson(Map<String, dynamic> jsonData) {
    return Question(questions: jsonData['question']);
  }
}

class Answer {
  final List<dynamic> answers;

  Answer({required this.answers});
  factory Answer.fromJson(Map<String, dynamic> jsonData) {
    return Answer(answers: jsonData['answers']);
  }
}
