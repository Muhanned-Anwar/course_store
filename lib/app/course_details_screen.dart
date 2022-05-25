import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_store/storage/network/firebase/controllers/fb_fire_store_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../models/lesson.dart';
import '../provider/my_course_provider.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  late double width;
  late double height;

  List<Lesson> lessons = [
    Lesson(id: 1, lessonNumber: 1),
    Lesson(id: 2, lessonNumber: 2, title: 'Basic Intro of Online Network'),
    Lesson(id: 3, lessonNumber: 3, title: 'Information of Online Networking'),
    Lesson(id: 4, lessonNumber: 4, title: 'Information of Tech.Networking'),
    Lesson(id: 5, lessonNumber: 5, title: 'Science Fiction, Fact Network'),
    Lesson(
        id: 6,
        lessonNumber: 6,
        title: 'Diploma of Information Tech. Networking'),
    Lesson(id: 7, lessonNumber: 7, title: 'Dedicated Support Entire Center'),
  ];
  Course course = Course(
      title: 'Diploma Of IT Networking',
      subTitle: '',
      imagePath: 'assets/app/app_images/diploma.png',
      author: 'Gilberto S. Osborne',
      lessonsNumber: '27',
      description: 'Relax and do whatever fits with your '
          'design process. Don’t set a lot of restrictive '
          'hard-and-fast rules. Use filler text where it helps'
          ' your design process, but use real content if '
          'you’ve got it, as long as it doesn’t distract '
          'and slow down your design process use real content '
          'where possible, and where it doesn’t create too much distraction. '
          'Read More...',
      isBuy: false,
      lessons: []);

  Widget readMore() {
    return TextButton(onPressed: () {}, child: const Text('Read More...'));
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    course.isBuy = Provider.of<MyCourseProvider>(context, listen: false).isBuy;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        backgroundColor: const Color(0xffECB7BF),
        title: const Text(
          'Course Details',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                left: width / 26.18,
                right: width / 26.18,
                top: height / 32.145,
              ),
              height: height / 1.46,
              child: ListView(
                children: [
                  Text(
                    Provider.of<MyCourseProvider>(context).course.subTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'By ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        Provider.of<MyCourseProvider>(context).course.author,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(flex: 1),
                      Text(
                        Provider.of<MyCourseProvider>(context)
                            .course
                            .reviews
                            .toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        ' Reviews ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        ' (View All) ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffC99200),
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                  SizedBox(height: height / 114.8),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        const Text(
                          'Start On ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          Provider.of<MyCourseProvider>(context).course.startOn,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(flex: 1),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: const VerticalDivider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                        ),
                        const Spacer(flex: 1),
                        Text(
                          Provider.of<MyCourseProvider>(context)
                              .course
                              .lessonsNumber
                              .toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          ' Lessons ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(flex: 12),
                      ],
                    ),
                  ),
                  Visibility(
                    visible:
                        Provider.of<MyCourseProvider>(context).course.isBuy,
                    child: Row(
                      children: [
                        Text(
                          '${Provider.of<MyCourseProvider>(context).course.price.toString()}0 KWD',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffC99200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height / 32.145),
                  SizedBox(
                    height: height / 4.297,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About this Course',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: height / 73.05),
                        Text(
                          Provider.of<MyCourseProvider>(context)
                              .course
                              .description,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height / 30),
                  SizedBox(
                    height: height,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const Text(
                          'Course',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: height / 80,
                        ),
                        Container(
                          height: height,
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FbFireStoreController()
                                  .readAllLessonsStream(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasData &&
                                    snapshot.data!.docs.isNotEmpty) {
                                  List<QueryDocumentSnapshot> allLessons =
                                      snapshot.data!.docs;
                                  return ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: lessons.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: height / 10.1726,
                                        margin: EdgeInsetsDirectional.only(
                                            bottom: height / 53.57),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: kElevationToShadow[4],
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(width: width / 19.63),
                                            Text(
                                              'Lesson 0${allLessons[index].get('lessonNumber')}:',
                                              style: const TextStyle(
                                                color: Color(0xffC99200),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: width / 23),
                                            SizedBox(
                                              width: width / 2.28,
                                              child: Text(allLessons[index]
                                                  .get('title')),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.play_circle_outline,
                                                size: 36,
                                                color: Color(0xffECB7BF),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(Icons.warning, size: 80),
                                        Text(
                                          'NOT EXIST ANY QUESTION',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: Provider.of<MyCourseProvider>(context).course.isBuy,
            child: Container(
              height: height / 10,
              padding: EdgeInsets.symmetric(
                vertical: height / 53.57,
                horizontal: width / 26.18,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: kElevationToShadow[4],
              ),
              child: Stack(
                children: [
                  TextField(
                    cursorColor: const Color(0xffECB7BF),
                    decoration: InputDecoration(
                      // contentPadding: const EdgeInsets.all(20),
                      hintText: 'Email Address',
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1,
                          )),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        minimumSize: Size(height / 16, width / 3.38),
                        primary: const Color(0xffECB7BF),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'ACTIVE',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            replacement: Container(
              width: double.infinity,
              height: height / 10,
              padding: EdgeInsets.symmetric(
                  vertical: height / 53.57, horizontal: width / 26.18),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: kElevationToShadow[4],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(345, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  primary: const Color(0xffECB7BF),
                ),
                onPressed: () {},
                child: const Text(
                  'ADD REVIEW',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
