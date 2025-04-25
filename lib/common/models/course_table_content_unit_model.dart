class CourseTableContentUnitModel {
  final int id;
  final String title;
  final String? timeString;
  final bool isChapter;
  final bool isFree;

  CourseTableContentUnitModel({
    required this.id,
    required this.title,
    this.timeString,
    required this.isChapter,
    required this.isFree,
  });
}
