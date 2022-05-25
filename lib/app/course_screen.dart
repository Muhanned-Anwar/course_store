import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_store/storage/network/firebase/controllers/fb_fire_store_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_drawer/slide_drawer.dart';

import '../models/course.dart';
import '../models/lesson.dart';
import '../provider/my_course_provider.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late double width;
  late double height;

  List<Course> allCoursers = [
    Course(
        title: 'Business Management',
        subTitle: '',
        imagePath: 'assets/app/app_images/business_management.png',
        author: 'Betty R. Roberts',
        lessonsNumber: '14',
        lessons: []),
    Course(
        title: 'Project Management',
        subTitle: '',
        imagePath: 'assets/app/app_images/project_management.png',
        author: 'Juana K. Powell',
        lessonsNumber: '16',
        lessons: []),
    Course(
        title: 'Diploma Of IT Networking',
        subTitle: '',
        imagePath: 'assets/app/app_images/diploma.png',
        author: 'Gilberto S. Osborne',
        lessonsNumber: '27',
        lessons: []),
    Course(
        title: 'Business Management',
        subTitle: '',
        imagePath: 'assets/app/app_images/business_management.png',
        author: 'Betty R. Roberts',
        lessonsNumber: '14',
        lessons: []),
    Course(
        title: 'Project Management',
        subTitle: '',
        imagePath: 'assets/app/app_images/diploma.png',
        author: 'Juana K. Powell',
        lessonsNumber: '16',
        lessons: []),
    Course(
        title: 'Diploma Of IT Networking',
        subTitle: '',
        imagePath: 'assets/app/app_images/project_management.png',
        author: 'Gilberto S. Osborne',
        lessonsNumber: '27',
        lessons: []),
  ];
  List<Course> myCoursers = [
    Course(
        title: 'Business Management',
        subTitle: '',
        imagePath: 'assets/app/app_images/business_management.png',
        author: 'Betty R. Roberts',
        lessonsNumber: '14',
        lessons: []),
    Course(
        title: 'Project Management',
        subTitle: '',
        imagePath: 'assets/app/app_images/diploma.png',
        author: 'Juana K. Powell',
        lessonsNumber: '16',
        lessons: []),
    Course(
        title: 'Diploma Of IT Networking',
        subTitle: '',
        imagePath: 'assets/app/app_images/project_management.png',
        author: 'Gilberto S. Osborne',
        lessonsNumber: '27',
        lessons: []),
  ];

  int selectCategory = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    print('Width = $width');
    print('Height = $height');

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        backgroundColor: const Color(0xffECB7BF),
        title: const Text(
          'Course',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                SlideDrawer.of(context)?.toggle();
              },
              icon: const Icon(Icons.dehaze_rounded),
            );
          },
        ),
      ),
      drawerEnableOpenDragGesture: false,
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: width / 26.18, vertical: height / 32.145),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.zero,
              height: height / 18.26,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: kElevationToShadow[4],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectCategory = 0;
                          Provider.of<MyCourseProvider>(context, listen: false)
                              .changeIsBuy(isBuy: false);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: selectCategory == 0
                                ? Colors.white
                                : Colors.grey.shade300,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15))),
                        alignment: Alignment.center,
                        child: Text(
                          'ALL COURSES',
                          style: TextStyle(
                            color: selectCategory == 0
                                ? const Color(0xffC99200)
                                : const Color(0xff717171),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectCategory = 1;
                          Provider.of<MyCourseProvider>(context, listen: false)
                              .changeIsBuy(isBuy: true);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: selectCategory == 1
                                ? Colors.white
                                : Colors.grey.shade300,
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        alignment: Alignment.center,
                        child: Text(
                          'MY COURSES',
                          style: TextStyle(
                            color: selectCategory == 1
                                ? const Color(0xffC99200)
                                : const Color(0xff717171),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height / 32.145,
            ),
            SizedBox(
              height: height / 1.385,
              child: StreamBuilder<QuerySnapshot>(
                  stream: selectCategory == 0
                      ? FbFireStoreController().readAllCoursesStream()
                      : FbFireStoreController().readAllCoursesStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData &&
                        snapshot.data!.docs.isNotEmpty) {
                      List<QueryDocumentSnapshot> allCourses =
                          snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: allCourses.length,
                        itemBuilder: (context, index) {
                          return buildContainer(index, allCourses);
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
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildContainer(
      int index, List<QueryDocumentSnapshot> coursers) {
    return GestureDetector(
      onTap: () {
        Provider.of<MyCourseProvider>(context, listen: false).changeCourse(
          course: Course(
            title: coursers[index].get('title').toString(),
            subTitle: coursers[index].get('subTitle').toString(),
            imagePath: coursers[index].get('imagePath').toString(),
            author:  coursers[index].get('author').toString(),
            description:coursers[index].get('description').toString(),
            lessonsNumber:coursers[index].get('lessonsNumber').toString(),
            startOn:coursers[index].get('startOn').toString(),
            endOn:coursers[index].get('endOn').toString(),
            price:coursers[index].get('price').toString(),
            reviews:coursers[index].get('reviews').toString(),
            isBuy: coursers[index].get('isBuy'),
            lessons: [
              Lesson(id: 1, lessonNumber: 1),
            ]
          ),
        );
        Navigator.pushNamed(context, '/course_details_screen');
      },
      child: Container(
        height: height / 9.567,
        margin: EdgeInsetsDirectional.only(bottom: height / 53.57),
        padding: EdgeInsets.symmetric(
            horizontal: width / 56.103, vertical: height / 114.8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: width / 5.61,
              height: height / 11.48,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.network(coursers[index].get('imagePath')),
            ),
            SizedBox(width: width / 32.727),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  coursers[index].get('title'),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'By ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      coursers[index].get('author'),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      coursers[index].get('lessonsNumber').toString(),
                      style: const TextStyle(
                        color: Color(0xffC99200),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const Text(
                      ' Lessons',
                      style: TextStyle(
                        color: Color(0xffC99200),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
