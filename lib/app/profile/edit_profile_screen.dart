import 'dart:io';

import 'package:course_store/storage/network/firebase/controllers/fb_storage_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/Customer.dart';
import '../../res/colours.dart';
import '../../storage/local/prefs/user_preference_controller.dart';
import '../../storage/network/firebase/controllers/fb_fire_store_controller.dart';
import '../../utils/helpers.dart';
import '../../widgets/MyElevatedButton.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with Helpers {
  late double width;
  late double height;

  late TextEditingController _usernameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _phoneTextEditingController;
  late TextEditingController _addressTextEditingController;
  late TextEditingController _genderTextEditingController;
  late TextEditingController _birthDateTextEditingController;

  String? _usernameError;
  String? _emailError;
  String? _phoneError;
  String? _addressError;
  String? _genderError;
  String? _birthDateError;

  ImagePicker? imagePicker;
  XFile? _pickedFile;

  late String profileImage;

  @override
  void initState() {
    super.initState();
    _usernameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _phoneTextEditingController = TextEditingController();
    _addressTextEditingController = TextEditingController();
    _genderTextEditingController = TextEditingController();
    _birthDateTextEditingController = TextEditingController();
    _usernameTextController.text =
        UserPreferenceController().userInformation.username;
    _emailTextController.text =
        UserPreferenceController().userInformation.email;
    _phoneTextEditingController.text =
        UserPreferenceController().userInformation.phoneNumber;
    _addressTextEditingController.text =
        UserPreferenceController().userInformation.address;
    _genderTextEditingController.text =
        UserPreferenceController().userInformation.gender;
    _birthDateTextEditingController.text =
        UserPreferenceController().userInformation.birthDate;

    imagePicker = ImagePicker();
    profileImage = UserPreferenceController().userInformation.profileImage;
  }

  @override
  void dispose() {
    _usernameTextController.dispose();
    _emailTextController.dispose();
    _phoneTextEditingController.dispose();
    _addressTextEditingController.dispose();
    _genderTextEditingController.dispose();
    _birthDateTextEditingController.dispose();
    super.dispose();
  }

  double imageHeight = 803.6363636363636 / 9.34;
  double editTextSize = 803.6363636363636 / 12.36;
  double buttonSize = 803.6363636363636 / 16;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: 18.7),
          child: IconButton(
            color: Colors.grey,
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/main_screen');
            },
            icon: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 15,
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 17, color: Colors.black),
        ),
      ),
      body:RefreshIndicator(
        onRefresh: () async{
          _usernameTextController.text =
              UserPreferenceController().userInformation.username;
          _emailTextController.text =
              UserPreferenceController().userInformation.email;
          _phoneTextEditingController.text =
              UserPreferenceController().userInformation.phoneNumber;
          _addressTextEditingController.text =
              UserPreferenceController().userInformation.address;
          _genderTextEditingController.text =
              UserPreferenceController().userInformation.gender;
          _birthDateTextEditingController.text =
              UserPreferenceController().userInformation.birthDate;
          profileImage = UserPreferenceController().userInformation.profileImage;

        },
        child:  OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              imageHeight = height / 9.34;
              editTextSize = height / 14;
              buttonSize = height / 16;
            } else {
              imageHeight = height / 5;
              editTextSize = height / 6;
              buttonSize = height / 8;
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: width / 15.1),
              child: ListView(
                children: [
                  SizedBox(height: height / 20),
                  GestureDetector(
                    onTap: selectPhotoFromGallery,
                    onLongPress: capturePhotoFromCamera,
                    child: Container(
                      alignment: Alignment.center,
                      width: width / 4.56,
                      height: imageHeight,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            children: [
                              _pickedFile != null
                                  ? Align(
                                alignment: Alignment.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.file(
                                    File(_pickedFile!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                                  : profileImage != ''
                                  ? Align(
                                alignment: Alignment.center,
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(50),
                                  child: Image.network(
                                    UserPreferenceController()
                                        .userInformation
                                        .profileImage,
                                    fit: BoxFit.cover,
                                    width: 86,
                                    height: 86,
                                  ),
                                ),
                              )
                                  : Container(),
                              const Align(
                                alignment: Alignment.center,
                                child: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height / 27.7),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: editTextSize,
                    child: TextField(
                      controller: _usernameTextController,
                      decoration: InputDecoration(
                        label: const Text('Name'),
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
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: editTextSize,
                    child: TextField(
                      controller: _emailTextController,
                      enabled: false,
                      decoration: InputDecoration(
                        label: const Text('Email'),
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
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: editTextSize,
                    child: TextField(
                      controller: _phoneTextEditingController,
                      decoration: InputDecoration(
                        label: const Text('Phone Number'),
                        errorText: _phoneError,
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: editTextSize,
                    child: TextField(
                      controller: _addressTextEditingController,
                      decoration: InputDecoration(
                        label: const Text('Address'),
                        errorText: _addressError,
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colours.primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: editTextSize,
                    child: TextField(
                      controller: _genderTextEditingController,
                      decoration: InputDecoration(
                        label: const Text('Gender'),
                        errorText: _genderError,
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colours.primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: editTextSize,
                    child: TextField(
                      controller: _birthDateTextEditingController,
                      decoration: InputDecoration(
                        label: const Text('BirthDate'),
                        errorText: _birthDateError,
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colours.primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height / 18.689),
                  MyElevatedButton(
                    onPressed: () async => await performUpdateUserInformation(),
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
                    style: TextButton.styleFrom(
                      primary: Colours.primaryColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/change_password_screen');
                    },
                    child: const Text(
                      'Change Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> performUpdateUserInformation() async {
    if (checkData()) {
      await updateUserInformation();
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
    // bool email = checkEmail();
    bool phone = checkPhoneNumber();
    bool address = checkAddress();
    bool gender = checkGender();
    bool birthDate = checkBirthDate();
    setState(() {
      _usernameError = !username ? 'Enter username !' : null;
      // _emailError = !email ? 'Enter email !' : null;
      _phoneError = !phone ? 'Enter phone number!' : null;
      _addressError = !address ? 'Enter Address!' : null;
      _genderError = !gender ? 'Enter Gender' : null;
      _birthDateError = !birthDate ? 'Enter BirthDate!' : null;
    });
    if (username && phone && address && gender && birthDate) {
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

  bool checkPhoneNumber() {
    if (_phoneTextEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool checkAddress() {
    if (_addressTextEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool checkGender() {
    if (_genderTextEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool checkBirthDate() {
    if (_birthDateTextEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<Customer> readData() async {
    Customer customer = Customer();
    customer.username = _usernameTextController.text;
    // customer.email = _emailTextController.text;
    customer.phoneNumber = _phoneTextEditingController.text;
    customer.address = _addressTextEditingController.text;
    customer.gender = _genderTextEditingController.text;
    customer.birthDate = _birthDateTextEditingController.text;
    customer.id = UserPreferenceController().userInformation.id;
    customer.documentId = UserPreferenceController().userInformation.documentId;
    if (_pickedFile != null) {
      customer.profileImage = await uploadImage();
    }
    return customer;
  }

  Future<String> uploadImage() async {
    if (_pickedFile != null) {
      return FbStorageController().uploadProfileImage(
          uploadListener: ({
            message,
            reference,
            required bool status,
            required TaskState taskState,
          }) {
            if (taskState == TaskState.running) {
            } else if (taskState == TaskState.success) {
              showSnackBar(
                  context: context,
                  message: 'Upload image profile successfully');
            } else if (taskState == TaskState.error) {
              showSnackBar(
                  context: context,
                  message: 'Upload image profile Failed',
                  error: true);
            }
          },
          file: File(_pickedFile!.path));
    } else {
      return '';
    }
  }

  Future<void> updateUserInformation() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: Colours.primaryColor,
              ),
            ));

    bool status = await FbFireStoreController()
        .updateUser(context: context, customer: await readData());
    Navigator.pop(context);
    if (status) {
      print(
          'UserPreferenceController().userInformation.profileImage = ${UserPreferenceController().userInformation.profileImage}');
      showSnackBar(context: context, message: 'Update Profile Successfully');
    } else {
      showSnackBar(
          context: context, message: 'Update Profile Failed', error: true);
    }
  }

  Future<void> selectPhotoFromGallery() async {
    XFile? pickedFile =
        await imagePicker!.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  Future<void> capturePhotoFromCamera() async {
    XFile? pickedFile =
        await imagePicker!.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }
}
