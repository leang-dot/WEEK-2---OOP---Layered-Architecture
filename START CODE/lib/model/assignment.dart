import 'question.dart';

class Assignment {
  final String id;
  final String title;

  final List<Question> questions = [];

  Assignment({
    required this.id,
    required this.title,
  });

  void addQuestion(Question question) {
    questions.add(question);
  }
}
