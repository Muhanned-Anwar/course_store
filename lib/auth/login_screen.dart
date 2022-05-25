import 'package:flutter/material.dart';

import '../storage/network/firebase/controllers/fb_auth_controller.dart';
import '../utils/helpers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers{
  late double width;
  late double height;

  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _emailTextController.text = 'mohannedanwarflutter@gmail.com';
    // _emailTextController.text = 'mohannedanwarflutter@gmail.com';
    _passwordTextController.text = '123456789';
    // _passwordTextController.text = '0599596716';
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
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
            SizedBox(height: height / 5),
            Image.asset('assets/logo.png'),
            SizedBox(height: height / 15),
            TextField(
              controller: _emailTextController,
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
            TextField(
              controller: _passwordTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                contentPadding: const EdgeInsets.all(20),
                hintText: 'Password',
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
                errorText: _passwordError,
                errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.red.shade300,
                    width: 2,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forget_password_screen');
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                    color: Color(0xFFB89117),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.pink.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.symmetric(vertical: 17),
              ),
              onPressed: ()async => await performLogin(),
              child: const Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: height / 5),
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

  void _changeProgressValue({required double? value}) {
    setState(() {
      _progressValue = value;
    });
  }

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
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
    bool password = checkPassword();
    setState(() {
      _emailError = !mobile ? 'Enter email !' : null;
      _passwordError = !password ? 'Enter password !' : null;
    });
    if (mobile && password) {
      return true;
    } else {
      return false;
    }
  }

  bool checkEmail() {
    if (_emailTextController.text.isNotEmpty) {
      if (_emailTextController.text.contains("@")) {
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

  bool checkPassword() {
    if (_passwordTextController.text.isNotEmpty) {
      if (_passwordTextController.text.length >= 4) {
        return true;
      } else {
        showSnackBar(
            context: context,
            message: 'Enter correct password!',
            error: true,
            time: 1);
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> login() async {
    _changeProgressValue(value: null);
    showDialog(
      context: context,
      builder: (context) => const Center(),
    );
    bool status = await FbAuthController().signIn(
      context: context,
      email: _emailTextController.text.trim(),
      password: _passwordTextController.text,
    );
    _changeProgressValue(value: status ? 1 : 0);

    if (status) {
      showSnackBar(context: context, message: 'Login Successfully');
      Navigator.pushReplacementNamed(context, '/main_screen');
    }else{
      Navigator.pop(context);
    }
  }

}
