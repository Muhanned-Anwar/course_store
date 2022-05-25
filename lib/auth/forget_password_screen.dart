import 'package:course_store/utils/helpers.dart';
import 'package:flutter/material.dart';

import '../storage/network/firebase/controllers/fb_auth_controller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with Helpers {
  late double width;
  late double height;

  late TextEditingController _emailTextEditingController;
  String? _emailError;

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    super.dispose();
  }

  double? _progressValue = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: width / 7),
        child: ListView(
          children: [
            SizedBox(height: height / 20),
            Image.asset('assets/forgot.png'),
            SizedBox(height: height / 60),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Forgot your password?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: height / 75),
            Container(
              alignment: Alignment.center,
              child: const Text(
                ' Enter your registered email address below to receive your password reset instructions!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: height / 20),
            TextField(
              controller: _emailTextEditingController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                contentPadding: const EdgeInsets.all(20),
                hintText: 'Email Address',
                hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay'),
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
                  ),
                ),
                errorText: _emailError,
                errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.red.shade300,
                    width: 2,
                  ),
                ),
              ),
            ),
            SizedBox(height: height / 75),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.pink.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.symmetric(vertical: 17),
              ),
              onPressed: () async => performForgetPassword(),
              child: const Text(
                'SEND',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: height / 7),
            Container(
              alignment: Alignment.centerRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlayfairDisplay',
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register_screen');
                      },
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PlayfairDisplay',
                          color: Color(0xFFB89117),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performForgetPassword() async {
    if (checkData()) {
      await resetPassword();
    }
  }

  bool checkData() {
    if (checkFieldError()) {
      return true;
    } else {
      showSnackBar(
          context: context,
          message: 'Enter required data!',
          error: true,
          time: 1);
      return false;
    }
  }

  bool checkFieldError() {
    bool mobile = checkEmail();
    setState(() {
      _emailError = !mobile ? 'Enter email !' : null;
    });
    if (mobile) {
      return true;
    } else {
      return false;
    }
  }

  bool checkEmail() {
    if (_emailTextEditingController.text.isNotEmpty) {
      if (_emailTextEditingController.text.contains("@")) {
        return true;
      } else {
        showSnackBar(
            context: context,
            message: 'Enter correct email!',
            error: true,
            time: 1);
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> resetPassword() async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: Colors.pink,
          value: _progressValue,
        ),
      ),
    );
    _changeProgressValue(value: null);

    bool status = await FbAuthController().resetPassword(
        email: _emailTextEditingController.text.trim(), context: context);

    _changeProgressValue(value: status ? 1 : 0);

    if (status) {
      Navigator.pop(context);
      Navigator.pop(context);
      showSnackBar(context: context, message: 'Password Reset Email Sent');
    } else {
      Navigator.pop(context);
      // Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  void _changeProgressValue({required double? value}) {
    setState(() {
      _progressValue = value;
    });
  }
}
