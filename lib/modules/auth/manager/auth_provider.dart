import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_4pm/core/models/user_model.dart';
import 'package:todo_4pm/core/service/firebase_functions.dart';

import '../../layout/layout.dart';

class AuthProvider extends ChangeNotifier {
  // Controllers for form inputs
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Variables to manage authentication state
  UserCredential? userCredential;  // Make this nullable
  UserModel? user;
  bool isSecure = true;

  // Toggle password visibility
  void changeSecure() {
    isSecure = !isSecure;
    notifyListeners();
  }

  // Function to create a new account
  Future<void> signUp(BuildContext context) async {
    try {
      UserCredential credential = await FireBaseFunctions.createAccount(
          emailController.text,
          passwordController.text,
          nameController.text,
          phoneController.text);
      if (credential.user != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, LayoutScreen.routeName, (route) => false);
        final snackBar = SnackBar(
          elevation: 0,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Account Created',
            message: "Welcome, ${nameController.text}",
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        // Clear input fields after successful sign up
        nameController.clear();
        phoneController.clear();
        emailController.clear();
        passwordController.clear();
      }
    } catch (e) {
      final snackBar = SnackBar(
        elevation: 0,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error!',
          message: "Failed to create account. Please try again.",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

    notifyListeners();
  }

  // Function to login an existing user
  Future<void> login(BuildContext context) async {
    try {
      userCredential = await FireBaseFunctions.login(
          emailController.text, passwordController.text);
      if (userCredential?.user != null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LayoutScreen.routeName,
              (route) => false,
        );
        user = await FireBaseFunctions.getUser();
        final snackBar = SnackBar(
          elevation: 0,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Welcome',
            message: "Welcome back ${user!.name}",
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        // Clear input fields after successful login
        emailController.clear();
        passwordController.clear();
      }
    } catch (e) {
      final snackBar = SnackBar(
        elevation: 0,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Oh no!',
          message: "Email or Password is incorrect",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

    notifyListeners();
  }
}
