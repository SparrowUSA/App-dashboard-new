class StudyResource {
  final String uni;
  final String subject;
  final String upwrite;
  final String url;

  StudyResource({required this.uni, required this.subject, required this.upwrite, required this.url});
}

class ExamDate {
  final String uni;
  final String subject;
  final String title;
  final DateTime date;

  ExamDate({required this.uni, required this.subject, required this.title, required this.date});
}
