import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_store/models/demo.dart';
import 'package:course_store/storage/network/firebase/controllers/fb_fire_store_controller.dart';
import 'package:flutter/material.dart';
import 'package:slide_drawer/slide_drawer.dart';

import '../models/course.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double width;
  late double height;

  List<Demo> demos = [
    Demo(
      id: 0,
      title: 'Photoshop',
      subTitle: 'How to Add lightning effect in photos',
      imagePath: 'assets/app/app_images/our_demos.png',
    ),
    Demo(
      id: 1,
      title: 'Photoshop',
      subTitle: 'How to Add lightning effect in photos',
      imagePath: 'assets/app/app_images/our_demos.png',
    ),
    Demo(
      id: 2,
      title: 'Photoshop',
      subTitle: 'How to Add lightning effect in photos',
      imagePath: 'assets/app/app_images/our_demos.png',
    ),
  ];
  List<Course> freeCourses = [
    Course(
        id: 0,
        title: 'Arts and Humanities',
        subTitle: '',
        imagePath: 'assets/app/app_images/freeCourse1.png',
        lessons: []),
    Course(
        id: 1,
        title: 'Computer Science',
        subTitle: '',
        imagePath: 'assets/app/app_images/freeCourse2.png',
        lessons: []),
    Course(
        id: 2,
        title: 'Economics and Finance',
        subTitle: '',
        imagePath: 'assets/app/app_images/freeCourse3.png',
        lessons: []),
  ];
  List<Course> paidCourses = [
    Course(
        id: 0,
        title: 'Social Media Marketing',
        subTitle: '',
        imagePath: 'assets/app/app_images/paidCourse1.png',
        lessons: []),
    Course(
        id: 1,
        title: 'Social Media Influencer',
        subTitle: '',
        imagePath: 'assets/app/app_images/paidCourse2.png',
        lessons: []),
    Course(
        id: 2,
        title: 'Biology & The Scienti..',
        subTitle: '',
        imagePath: 'assets/app/app_images/paidCourse3.png',
        lessons: []),
  ];

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
          'Home',
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
        margin: EdgeInsetsDirectional.only(
          start: width / 26.18,
          top: height / 36.5289,
        ),
        child: ListView(
          children: [
            // Demos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Checkout Our Demos',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                      size: 18,
                    ))
              ],
            ),
            SizedBox(
              height: height / 5,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FbFireStoreController().readOurDemosStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData &&
                        snapshot.data!.docs.isNotEmpty) {
                      List<QueryDocumentSnapshot> allDemos =
                          snapshot.data!.docs;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return demoItem(context, index, allDemos);
                        },
                        itemCount: allDemos.length,
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
            SizedBox(
              height: height / 27.7,
            ),

            // Free Courses
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Our Free Courses',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 5.74,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FbFireStoreController().readAllCoursesStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData &&
                        snapshot.data!.docs.isNotEmpty) {
                      List<QueryDocumentSnapshot> allCourses =
                          snapshot.data!.docs;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return freeCourseItem(context, index, allCourses);
                        },
                        itemCount: allCourses.length,
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

            const SizedBox(
              height: 10,
            ),
            // Paid Courses
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Our Paid Courses',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                      size: 18,
                    ))
              ],
            ),
            SizedBox(
              height: height / 5.74,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FbFireStoreController().readAllCoursesStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData &&
                        snapshot.data!.docs.isNotEmpty) {
                      List<QueryDocumentSnapshot> allCourses =
                          snapshot.data!.docs;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return paidCourseItem(context, index, allCourses);
                        },
                        itemCount: allCourses.length,
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
      ),
    );
  }

  Container demoItem(
      BuildContext context, int index, List<QueryDocumentSnapshot> allDemos) {
    return Container(
      margin: const EdgeInsetsDirectional.only(end: 10),
      width: width / 1.3,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: allDemos[index].get('demo_image') != null
                ? Image.network(
                    allDemos[index].get('demo_image'),
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  )
                : const Center(
                    child: Text('Something went wrong'),
                  ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: [Colors.transparent, Colors.transparent, Colors.black],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  allDemos[index].get('demo_description'),
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  allDemos[index].get('demo_title'),
                  style: TextStyle(color: Colors.grey.shade100, fontSize: 13),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container freeCourseItem(
      BuildContext context, int index, List<QueryDocumentSnapshot> allCourses) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: width / 26.18, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: kElevationToShadow[1],
      ),
      width: width / 2.99,
      height: height / 5.74,
      child: Column(
        children: [
          Container(
            height: height / 11.16,
            child: Image.network(allCourses[index].get('imagePath')),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width / 19.63),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Text(
                allCourses[index].get('title'),
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xffC99200),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container paidCourseItem(
      BuildContext context, int index, List<QueryDocumentSnapshot> allCourses) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: width / 26.18, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: kElevationToShadow[1],
      ),
      width: width / 2.99,
      height: height / 5.74,
      child: Column(
        children: [
          Container(
            height: height / 11.16,
            child: Image.network(allCourses[index].get('imagePath')),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: width / 19.63),
              alignment: Alignment.center,
              child: Text(
                allCourses[index].get('title'),
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xffC99200),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
