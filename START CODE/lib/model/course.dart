import 'assignment.dart';

class Course {
  final String id;
  final String name;
  String? teacherId;

  final List<String> studentIds = [];
  final List<Assignment> assignments = [];

  Course({required this.id, required this.name});

  void addStudent(String studentId) {
    studentIds.add(studentId);
  }

  void addAssignment(Assignment assignment) {
    assignments.add(assignment);
  }
}
