import 'package:course_store/utils/helpers.dart';
import 'package:flutter/material.dart';

import '../storage/network/firebase/controllers/fb_auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  late double width;
  late double height;

  late TextEditingController _usernameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _confirmPasswordTextController;

  String? _usernameError;

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  List<DropdownMenuItem> citiesItem = [];

  @override
  void initState() {
    super.initState();
    _usernameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmPasswordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
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
            SizedBox(height: height / 7),
            Image.asset('assets/logo.png'),
            SizedBox(height: height / 15),
            TextField(
              controller: _usernameTextController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outline),
                contentPadding: const EdgeInsets.all(20),
                hintText: 'User name',
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
                errorText: _usernameError,
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
              controller: _emailTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                contentPadding: const EdgeInsets.all(20),
                hintText: 'Email Address',
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
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
              keyboardType: TextInputType.visiblePassword,
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
            SizedBox(height: height / 75),
            TextField(
              controller: _confirmPasswordTextController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                contentPadding: const EdgeInsets.all(20),
                hintText: ' Confirm Password',
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
                errorText: _confirmPasswordError,
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
              onPressed: () async => performSignUp(),
              child: const Text(
                'REGISTER',
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
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlayfairDisplay',
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login_screen');
                      },
                      child: const Text(
                        'Login Now',
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

  Future<void> performSignUp() async {
    if (checkData()) {
      await signUp();
    }
  }

  bool checkData() {
    if (checkFieldError()) {
      return true;
    }
    showSnackBar(
        context: context, message: 'Enter required data', error: true, time: 1);
    return false;
  }

  bool checkFieldError() {
    bool username = checkUsername();
    bool email = checkEmail();
    bool password = checkPassword();
    bool confirmPassword = checkConfirmPassword();

    setState(() {
      _usernameError = !username ? 'Enter username !' : null;
      _emailError = !email ? 'Enter email !' : null;
      _passwordError = !password ? 'Enter password !' : null;
      _confirmPasswordError =
          !confirmPassword ? 'Enter confirm password !' : null;
    });
    if (username && email && password && confirmPassword) {
      return true;
    } else {
      return false;
    }
  }

  bool checkUsername() {
    if (_usernameTextController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool checkEmail() {
    if (_emailTextController.text.isNotEmpty) {
      if (_emailTextController.text.contains('@')) {
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

  bool checkConfirmPassword() {
    if (_confirmPasswordTextController.text.isNotEmpty) {
      if (_confirmPasswordTextController.text.length >= 4) {
        if (_confirmPasswordTextController.text ==
            _passwordTextController.text) {
          return true;
        } else {
          showSnackBar(
              context: context,
              message: 'Two password are not equaled!',
              error: true,
              time: 1);
          return false;
        }
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

  Future<void> signUp() async {
    _changeProgressValue(value: null);
    showDialog(
      context: context,
      builder: (context) => Center(
        child: LinearProgressIndicator(
          value: _progressValue,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
    bool status = await FbAuthController().createAccount(
      context: context,
      email: _emailTextController.text.trim(),
      password: _passwordTextController.text,
      name: _usernameTextController.text,
    );
    _changeProgressValue(value: status ? 1 : 0);
    Navigator.pop(context);
    if (status) {
      showSnackBar(context: context, message: 'Sign Up Successfully');
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
  }
}
