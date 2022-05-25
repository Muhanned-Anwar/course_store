import 'package:course_store/app/products_screen.dart';
import 'package:course_store/app/profile/profile_person_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_drawer/slide_drawer.dart';

import '../drawer/drawer_screen.dart';
import '../provider/main_position_provider.dart';
import 'cart_screen.dart';
import 'course_screen.dart';
import 'home_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<Widget> screens = [
    const HomeScreen(),
    const CourseScreen(),
    const ProductsScreen(),
    const CartScreen(),
    const ProfilePersonScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SlideDrawer(
      child: screens[Provider.of<MainPositionProvider>(context).position],
      drawer:  const DrawerScreen()
    );
  }
}

