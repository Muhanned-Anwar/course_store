import 'package:flutter/material.dart';
import 'package:slide_drawer/slide_drawer.dart';

import '../../storage/local/prefs/user_preference_controller.dart';
import '../../storage/network/firebase/controllers/fb_auth_controller.dart';
import '../../utils/helpers.dart';

class ProfilePersonScreen extends StatefulWidget {
  const ProfilePersonScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePersonScreen> createState() => _ProfilePersonScreenState();
}

class _ProfilePersonScreenState extends State<ProfilePersonScreen>
    with Helpers {
  late double width;
  late double height;

  late String username;
  late String address;
  late String phoneNumber;
  late String birthDate;
  late String gender;
  late String profileImage;


  @override
  void initState() {
    super.initState();
    username = UserPreferenceController().userInformation.username;
    address = UserPreferenceController().userInformation.address;
    phoneNumber = UserPreferenceController().userInformation.phoneNumber;
    birthDate = UserPreferenceController().userInformation.birthDate;
    gender = UserPreferenceController().userInformation.gender;
    profileImage = UserPreferenceController().userInformation.profileImage;
  }

  @override
  void reassemble() {
    super.reassemble();
    username = UserPreferenceController().userInformation.username;
    address = UserPreferenceController().userInformation.address;
    phoneNumber = UserPreferenceController().userInformation.phoneNumber;
    birthDate = UserPreferenceController().userInformation.birthDate;
    gender = UserPreferenceController().userInformation.gender;
  }

  double itemSize =  392.72727272727275 / 6;
  double containerSize =  392.72727272727275 / 0.9;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25))
        ),
        backgroundColor: const Color(0xffECB7BF),
        title: const Text(
          'My Profile',
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
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 5),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pushNamed(
                    context, '/edit_profile_screen');
              },
              icon: const Icon(
                Icons.edit_outlined,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            containerSize = height / 1.5757;
            itemSize = height / 10;
          } else {
            containerSize = height / 0.9;
            itemSize = height / 6;
          }
          return  Container(
            decoration: const BoxDecoration(
            ),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(height: height / 19.6),
                    SizedBox(height: height / 50),
                    CircleAvatar(
                      radius: 45,
                      child: profileImage != ''
                          ? Align(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(50),
                          child: Image.network(
                            profileImage,
                            fit: BoxFit.cover,
                            width: 91,
                            height: 88,
                          ),
                        ),
                      )
                          : Container(),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      username,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    SizedBox(height: height / 73),
                    Container(
                      width: double.infinity,
                      height: containerSize,
                      // height: height / 1.5757,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: itemSize,
                            // height: height / 10,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width / 12.27,
                                ),
                                const Text('Email '),
                                SizedBox(width: width / 19.63),
                                Text(
                                  UserPreferenceController().userInformation.email,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: itemSize,
                            // height: height / 10,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width / 12.27,
                                ),
                                const Text('Phone '),
                                SizedBox(width: width / 19.63),
                                Text(
                                  phoneNumber,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: itemSize,
                            // height: height / 10,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width / 12.27,
                                ),
                                const Text('BirtDate '),
                                SizedBox(width: width / 19.63),
                                Text(
                                  birthDate,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: itemSize,
                            // height: height / 10,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width / 12.27,
                                ),
                                const Text('Gender '),
                                SizedBox(width: width / 19.63),
                                Text(
                                  gender,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.pushNamed(context, '/change_password_screen');
                            },
                            child: SizedBox(
                              width: double.infinity,
                              height: itemSize,
                              // height: height / 10,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width / 12.27,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: height / 27.7,
                                    ),
                                    child: const Text(
                                      'change password',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  const Spacer(flex: 1),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: height / 25,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                      color: Colors.pink,
                                    ),
                                  ),
                                  SizedBox(width: width / 10.9),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await UserPreferenceController().logout();
                              await FbAuthController().signOut(context: context);
                              showSnackBar(
                                  context: context, message: 'Logout Successfully');
                              Navigator.pushReplacementNamed(
                                  context, '/login_screen');
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: itemSize,
                              // height: height / 10,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width / 12.27,
                                  ),
                                  const Icon(Icons.logout),
                                  SizedBox(width: width / 19.63),
                                  const Text(
                                    'Logout',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
