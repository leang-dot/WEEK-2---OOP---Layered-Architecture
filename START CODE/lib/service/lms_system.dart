import '../model/course.dart';
import '../model/course_result.dart';
import '../model/student.dart';
import '../model/teacher.dart';
import '../model/assignment.dart';
import '../model/question.dart';

class LmsSystem {
  final List<Student> students = [];
  final List<Course> courses = [];
  final List<CourseResult> results = [];
  final List<Teacher> teachers = [];
  final List<Assignment> assignments = [];

  void createCourse({required String courseId, required String courseName}) {
    // ! Course shall not exist already
    Course? course = _findCourseOrNull(courseId);
    if (course != null) {
      throw Exception('Course $courseId already exists');
    }

    courses.add(Course(id: courseId, name: courseName));
  }

  void addStudent({required String studentId, required String studentName}) {
    // ! Student shall not exist already
    Student? student = _findStudentOrNull(studentId);
    if (student != null) {
      throw Exception('Student $student already exists');
    }

    students.add(Student(id: studentId, name: studentName));
  }

  void addTeacher({
    required String teacherId,
    required String teacherName,
  }) {
    Teacher? teacher = _findTeacherOrNull(teacherId);

    if (teacher != null) {
      throw Exception('Teacher $teacherId already exists');
    }

    teachers.add(
      Teacher(
        id: teacherId,
        name: teacherName,
      ),
    );
  }

  void addStudentToCourse(
      {required String studentId, required String courseId}) {
    // ! Check both student and course shall exist
    Course? course = _findCourseOrNull(courseId);
    if (course == null) {
      throw Exception('Course $courseId not found');
    }

    Student? student = _findStudentOrNull(studentId);
    if (student == null) {
      throw Exception('Student $studentId not found');
    }

    // ! student shall not already belong to the course
    if (course.studentIds.contains(studentId)) {
      throw Exception('Student already belong to this course');
    }

    course.studentIds.add(studentId);
  }

  void addScore({
    required String courseId,
    required String studentId,
    required double score,
  }) {
    // ! Check both student and course shall exist
    Course? course = _findCourseOrNull(courseId);
    if (course == null) {
      throw Exception('Course $courseId not found');
    }

    // ! student shall  belong to the course
    if (!course.studentIds.contains(studentId)) {
      throw Exception('Student $studentId is not enrolled in the course');
    }

    results.add(
        CourseResult(courseId: courseId, studentId: studentId, score: score));
  }

  void removeStudent({required String studentId}) {
    Student? student = _findStudentOrNull(studentId);
    if (student == null) {
      throw Exception('Student $studentId not found');
    }
    // 1- Remove student from the students list
    students.removeWhere((student) => student.id == studentId);

    // 2- Remove student from each course
    for (final course in courses) {
      course.studentIds.remove(studentId);
    }

    // 3 - Remove all student results
    results.removeWhere((result) => result.studentId == studentId);
  }

  Student? _findStudentOrNull(String studentId) {
    for (Student s in students) {
      if (s.id == studentId) {
        return s;
      }
    }
    return null; // not found
  }

  Course? _findCourseOrNull(String courseId) {
    for (Course s in courses) {
      if (s.id == courseId) {
        return s;
      }
    }
    return null; // not found
  }

  Teacher? _findTeacherOrNull(String teacherId) {
    for (Teacher teacher in teachers) {
      if (teacher.id == teacherId) {
        return teacher;
      }
    }

    return null;
  }

  Assignment? _findAssignmentOrNull(
    String assignmentId,
  ) {
    for (Assignment assignment in assignments) {
      if (assignment.id == assignmentId) {
        return assignment;
      }
    }

    return null;
  }

  void createAssignment({
    required String assignmentId,
    required String title,
  }) {
    Assignment? assignment = _findAssignmentOrNull(assignmentId);

    if (assignment != null) {
      throw Exception(
        'Assignment $assignmentId already exists',
      );
    }

    assignments.add(
      Assignment(
        id: assignmentId,
        title: title,
      ),
    );
  }

   void addAssignmentToCourse({
    required String courseId,
    required String assignmentId,
  }) {
    Course? course = _findCourseOrNull(courseId);

    if (course == null) {
      throw Exception('Course $courseId not found');
    }

    Assignment? assignment = _findAssignmentOrNull(assignmentId);

    if (assignment == null) {
      throw Exception(
        'Assignment $assignmentId not found',
      );
    }

    course.addAssignment(assignment);
  }

   void addQuestionToAssignment({
    required String assignmentId,
    required String questionId,
    required String questionText,
    required int points,
  }) {
    Assignment? assignment = _findAssignmentOrNull(assignmentId);

    if (assignment == null) {
      throw Exception(
        'Assignment $assignmentId not found',
      );
    }

    assignment.addQuestion(
      Question(
        id: questionId,
        text: questionText,
        points: points,
      ),
    );
  }
}
