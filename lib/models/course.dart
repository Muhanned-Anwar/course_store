import 'package:course_store/models/lesson.dart';

class Course {
  int? id;
  String title;
  String subTitle;
  String imagePath;
  String lessonsNumber;
  String reviews;
  String author;
  String startOn;
  String endOn;
  String price;
  String description;
  bool isBuy;
  List<Lesson> lessons;

  Course({
    this.id,
    required this.title,
    required this.subTitle,
    required this.imagePath,
    this.lessonsNumber = '0',
    this.author = '',
    this.startOn = '05 Feb 2020',
    this.endOn = '05 Mar 2022',
    this.price = '75.00',
    this.description = '',
    this.reviews = '36',
    this.isBuy = false,
    required this.lessons,
  });
}
