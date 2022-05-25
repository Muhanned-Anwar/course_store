import 'package:course_store/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/main_position_provider.dart';
import '../storage/local/prefs/user_preference_controller.dart';
import '../storage/network/firebase/controllers/fb_auth_controller.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> with Helpers {
  late double width;
  late double height;
  late String profileImage;
  late String username;

  @override
  void initState() {
    super.initState();
    profileImage = UserPreferenceController().userInformation.profileImage;
    username = UserPreferenceController().userInformation.username;

  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(
                          flex: 3,
                        ),
                        Container(
                          width: width / 3.5,
                          height: height / 7.175,
                          margin: EdgeInsets.only(top: height / 9),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              profileImage,
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 0, left: 50),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 33.48),
                     Align(
                      alignment: Alignment.center,
                      child: Text(
                        username,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height / 18.264),
              Column(
                children: [
                  // Home
                  Divider(height: 1, color: Colors.grey.shade300),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Provider.of<MainPositionProvider>(context, listen: false)
                          .changePosition(position: 0);
                      Navigator.pushReplacementNamed(context, '/main_screen');
                    },
                    child: Row(
                      children: [
                        const SizedBox(width: 45),
                        Image.asset(
                          'assets/app/drawer_images/home.png',
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'Home',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),

                  // Course
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Provider.of<MainPositionProvider>(context, listen: false)
                          .changePosition(position: 1);
                      Navigator.pushReplacementNamed(context, '/main_screen');
                    },
                    child: Row(
                      children: [
                        const SizedBox(width: 45),
                        Image.asset(
                          'assets/app/drawer_images/course.png',
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'Course',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),

                  // News
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/profile_screen');
                    },
                    child: Row(
                      children: [
                        const SizedBox(width: 45),
                        Image.asset(
                          'assets/app/drawer_images/news.png',
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'News',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),

                  // Products
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Provider.of<MainPositionProvider>(context, listen: false)
                          .changePosition(position: 2);
                      Navigator.pushReplacementNamed(context, '/main_screen');
                    },
                    child: Row(
                      children: [
                        const SizedBox(width: 45),
                        Image.asset(
                          'assets/app/drawer_images/product.png',
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'Products',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),

                  // Carts
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/product_cart_screen');
                    },
                    child: Row(
                      children: [
                        const SizedBox(width: 45),
                        Image.asset(
                          'assets/app/drawer_images/cart.png',
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'Carts',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),

                  // My Profile
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Provider.of<MainPositionProvider>(context, listen: false)
                          .changePosition(position: 4);
                      Navigator.pushReplacementNamed(context, '/main_screen');
                    },
                    child: Row(
                      children: [
                        const SizedBox(width: 45),
                        Image.asset(
                          'assets/app/drawer_images/profile.png',
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'My Profile',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),

                  // Settings
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/my_address_screen');
                    },
                    child: Row(
                      children: [
                        const SizedBox(width: 47),
                        Image.asset(
                          'assets/app/drawer_images/settings.png',
                        ),
                        const SizedBox(width: 25),
                        const Text(
                          'Settings',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),

                  // Logout
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () async {
                      await UserPreferenceController().logout();
                      await FbAuthController().signOut(context: context);
                      showSnackBar(
                          context: context, message: 'Logout Successfully');
                      Navigator.pushReplacementNamed(context, '/login_screen');
                    },
                    child: Row(
                      children: [
                        const SizedBox(width: 45),
                        Image.asset(
                          'assets/app/drawer_images/logout.png',
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'Logout',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffECB7BF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/change_password_screen');
                },
                child: const Text(
                  'Change Password',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              // Spacer(flex: 3,),
            ],
          ),
        )
      ],
    );
  }
}
