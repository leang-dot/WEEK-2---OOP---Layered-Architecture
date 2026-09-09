class CourseResult {
  final String courseId;
  final String studentId;
  final double score;

  CourseResult({required this.courseId, required this.studentId, required this.score});

  String get grade {
    if (score >= 90) {
      return 'A';
    } else if (score >= 80) {
      return 'B';
    } else if (score >= 70) {
      return 'C';
    } else if (score >= 60) {
      return 'D';
    } else {
      return 'F';
    }
  }
}
