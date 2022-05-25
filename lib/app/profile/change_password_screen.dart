import 'package:flutter/material.dart';

import '../../res/colours.dart';
import '../../storage/local/prefs/user_preference_controller.dart';
import '../../storage/network/firebase/controllers/fb_auth_controller.dart';
import '../../utils/helpers.dart';
import '../../widgets/MyElevatedButton.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with Helpers {
  late double width;
  late double height;

  late TextEditingController _oldPasswordTextEditingController;
  late TextEditingController _newPasswordTextEditingController;
  late TextEditingController _confirmNewPasswordTextEditingController;

  String? _oldPasswordError;
  String? _newPasswordError;
  String? _confirmNewPasswordError;

  @override
  void initState() {
    super.initState();
    _oldPasswordTextEditingController = TextEditingController();
    _newPasswordTextEditingController = TextEditingController();
    _confirmNewPasswordTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordTextEditingController.dispose();
    _newPasswordTextEditingController.dispose();
    _confirmNewPasswordTextEditingController.dispose();
    super.dispose();
  }

  double buttonSize = 803.6363636363636 / 16;

  double? _progressValue = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        backgroundColor: const Color(0xffECB7BF),
        title: const Text(
          'Change Password',
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
        backgroundColor: Colors.white,
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            buttonSize = height / 16;
          } else {
            buttonSize = height / 8;
          }

          return Container(
            width: double.infinity,
            color: Colors.white,
            child: ListView(
              children: [
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: width / 10.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LinearProgressIndicator(
                        value: _progressValue,
                        backgroundColor: Colors.transparent,
                        color: Colours.primaryColor,
                      ),
                      SizedBox(height: height / 17.858),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: width / 20),
                        child: Text(
                          'Enter your new password below.',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: height / 17.858),
                      TextField(
                        controller: _oldPasswordTextEditingController,
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: Colours.primaryColor,
                        decoration: InputDecoration(
                          hintText: 'Old Password',
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colours.primaryColor),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          errorText: _oldPasswordError,
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height / 40.6),
                      TextField(
                        controller: _newPasswordTextEditingController,
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: Colours.primaryColor,
                        decoration: InputDecoration(
                          hintText: 'New Password',
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colours.primaryColor),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          errorText: _newPasswordError,
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height / 40.6),
                      TextField(
                        controller: _confirmNewPasswordTextEditingController,
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: Colours.primaryColor,
                        decoration: InputDecoration(
                          hintText: 'Confirm New Password',
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colours.primaryColor),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          errorText: _confirmNewPasswordError,
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height / 12.3),
                      MyElevatedButton(
                        onPressed: () async => await performChangePassword(),
                        child: const Text(
                          'SAVE',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        height: buttonSize,
                        width: width / 1.57,
                        borderRadiusGeometry: BorderRadius.circular(10),
                        marginHorizontal: width / 8.72,
                        borderSide: BorderSide(color: Colors.pink.shade100),
                        gradient: const LinearGradient(
                          colors: [
                         Colours.primaryColor,
                         Colours.primaryColor,
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/forgot_password_screen');
                        },
                        child: const Text(
                          'forgot password!',
                          style: TextStyle(color: Colours.primaryColor,fontWeight: FontWeight.bold,fontSize: 18),
                        ),
                      ),
                      SizedBox(height: height / 40.6),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> performChangePassword() async {
    if (checkData()) {
      await changePassword();
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
    bool oldPassword = checkOldPassword();
    bool newPassword = checkNewPassword();
    bool confirmNewPassword = checkConfirmPassword();

    setState(() {
      _oldPasswordError = !oldPassword ? 'Enter old password !' : null;
      _newPasswordError = !newPassword ? 'Enter new password !' : null;
      _confirmNewPasswordError =
          !confirmNewPassword ? 'Enter confirm new password !' : null;
    });
    if (oldPassword && newPassword && confirmNewPassword) {
      return true;
    } else {
      return false;
    }
  }

  bool checkOldPassword() {
    if (_oldPasswordTextEditingController.text.isNotEmpty) {
      if (_oldPasswordTextEditingController.text.length >= 4) {
        print(
            'UserPreferenceController().userInformation.password = ${UserPreferenceController().userInformation.password}');
        if (UserPreferenceController().userInformation.password ==
            _oldPasswordTextEditingController.text) {
          return true;
        } else {
          showSnackBar(
              context: context,
              message: 'Wrong old password!',
              error: true,
              time: 1);
          return false;
        }
      } else {
        showSnackBar(
            context: context,
            message: 'Enter correct old password!',
            error: true,
            time: 1);
        return false;
      }
    } else {
      return false;
    }
  }

  bool checkNewPassword() {
    if (_newPasswordTextEditingController.text.isNotEmpty) {
      if (_newPasswordTextEditingController.text.length >= 6) {
        return true;
      } else {
        showSnackBar(
            context: context,
            message: 'Enter correct new password!',
            error: true,
            time: 1);
        return false;
      }
    } else {
      return false;
    }
  }

  bool checkConfirmPassword() {
    if (_confirmNewPasswordTextEditingController.text.isNotEmpty) {
      if (_confirmNewPasswordTextEditingController.text.length >= 6) {
        if (_confirmNewPasswordTextEditingController.text ==
            _newPasswordTextEditingController.text) {
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
            message: 'Enter correct new password!',
            error: true,
            time: 1);
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> changePassword() async {
    _changeProgressValue(value: null);
    showDialog(context: context, builder: (context) => const Center());
    bool status = await FbAuthController().changePassword(
        newPassword: _newPasswordTextEditingController.text, context: context);
    _changeProgressValue(value: status ? 1 : 0);
    if (status) {
      Navigator.pop(context);
      showSnackBar(context: context, message: 'Change password Successfully');
    } else {
      Navigator.pop(context);
      showSnackBar(
          context: context, message: 'Failed Change Password', error: true);
    }
  }

  void _changeProgressValue({required double? value}) {
    setState(() {
      _progressValue = value;
    });
  }
}
