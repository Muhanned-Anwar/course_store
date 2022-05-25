import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../../models/Customer.dart';
import '../../../../utils/helpers.dart';
import '../../../local/prefs/user_preference_controller.dart';
import 'fb_fire_store_controller.dart';

typedef UserAuthStatus = void Function({required bool loggedIn});

class FbAuthController with Helpers {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      print(
          '------------------------------------------------------- after user credentail');

      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          print(
              '------------------------------------------------------- befor read user');
          User? user = _firebaseAuth.currentUser;
          if (user != null) {
            await UserPreferenceController().saveUserInformation(
              customer: await FbFireStoreController().readUser(
                id: user.uid.toString(),
              ),
              password: password,
              email: email,
            );
            print(
                '------------------------------------------------------- after read user');
          }
          return true;
        } else {
          await signOut(context: context);
          showSnackBar(
              context: context,
              message: 'Verify email to login into the app!',
              error: true);
          return false;
        }
      }
      return false;
    } on FirebaseAuthException catch (exception) {
      _controlException(context, exception);
    } catch (exception) {
      //
    }

    return false;
  }

  bool loggedIn() => _firebaseAuth.currentUser != null;

  StreamSubscription<User?> checkUserStatus(UserAuthStatus userAuthStatus) {
    return _firebaseAuth.authStateChanges().listen((event) {
      userAuthStatus(loggedIn: event != null);
    });
  }

  Future<bool> createAccount({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      // user?.updateDisplayName(name);
      Customer customer = Customer();
      // customer.email = email;
      // customer.password = password;
      customer.username = name;
      customer.id = user?.uid ?? '';

      // Create collection users in fireStore for save user information
      if (await FbFireStoreController().createUser(customer: customer)) {
        showSnackBar(context: context, message: 'Saved SuccessFully');
      } else {
        showSnackBar(context: context, message: 'Saved Failed', error: true);
      }
      if (userCredential.user != null) {
        userCredential.user?.sendEmailVerification();
        return true;
      }
    } on FirebaseAuthException catch (exception) {
      _controlException(context, exception);
    } catch (exception) {
      //
    }
    return false;
  }

  Future<void> signOut({required BuildContext context}) async {
    await _firebaseAuth.signOut();
  }

  // Not Used At Now
  Future<bool> updateUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      User? currentUser = _firebaseAuth.currentUser;
      currentUser?.updateEmail(email);
      currentUser?.updatePassword(password);
      return true;
    } on FirebaseAuthException catch (exception) {
      _controlException(context, exception);
    } catch (exception) {
      //
    }
    return false;
  }

  Future<bool> changePassword({
    required BuildContext context,
    required String newPassword,
  }) async {
    User? currentUser = _firebaseAuth.currentUser;
    try {
      await currentUser?.updatePassword(newPassword);
      return true;
    } on FirebaseAuthException catch (exception) {
      _controlException(context, exception);
    } catch (exception) {
      print('Exception = $exception');
    }
    return false;
  }

  Future<bool> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (exception) {
      _controlException(context, exception);
    } catch (exception) {
      print('Exception = $exception');
    }

    return false;
  }

  void _controlException(
      BuildContext context, FirebaseAuthException exception) {
    showSnackBar(
        context: context,
        message: exception.message ?? 'Something Error!',
        error: true);
    switch (exception.code) {
      case 'invalid-email':
        break;
      case 'user-disabled':
        break;
      case 'user-not-found':
        break;
      case 'wrong-password':
        break;
    }
  }
}
