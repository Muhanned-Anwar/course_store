import 'dart:async';

import 'package:course_store/storage/network/firebase/controllers/fb_auth_controller.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  late StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
          () {
        _streamSubscription = FbAuthController().checkUserStatus(({required bool loggedIn}) {
          String route = loggedIn ? '/main_screen' : '/login_screen';
          Navigator.pushReplacementNamed(context, route);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
