import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelcommunity/screens/home_screen.dart';
import 'package:travelcommunity/screens/signup_screen.dart';
import 'package:travelcommunity/utils/helper_functions.dart';
import 'package:travelcommunity/widgets/custom_auth_button.dart';
import 'package:travelcommunity/widgets/custom_auth_image.dart';
import 'package:travelcommunity/widgets/custom_auth_navigator.dart';
import 'package:travelcommunity/widgets/custom_auth_text.dart';
import 'package:travelcommunity/widgets/custom_auth_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  void login() async {
    String email = emailController.text.trim();
    String pwd = pwdController.text.trim();

    if (email.isNotEmpty && pwd.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      FirebaseAuth auth = FirebaseAuth.instance;

      try {
        await auth.signInWithEmailAndPassword(
          email: email,
          password: pwd,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        String errorMsg = 'Something went wrong';
        switch (e.code) {
          case 'user-not-found':
            errorMsg = 'No user found with this email';
            break;
          case 'wrong-password':
            errorMsg = 'Incorrect password';
            break;
          case 'invalid-email':
            errorMsg = 'Invalid email address';
            break;
        }
        HelperFunctions.customSnackBar(
          context: context,
          text: errorMsg,
          bgColor: Colors.orange,
        );
      } finally {
        if (!mounted) return;
        setState(() => isLoading = false);
      }
    } else {
      HelperFunctions.customSnackBar(
        context: context,
        text: 'Please fill all fields',
        bgColor: Colors.orange,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAuthImage(url: 'images/login.png'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAuthText(text: 'Login'),
                  SizedBox(height: 15),
                  CustomAuthTextfield(
                    keyboadrType: TextInputType.emailAddress,
                    text: 'Email',
                    controller: emailController,
                  ),
                  SizedBox(height: 15),
                  CustomAuthTextfield(
                    obscureText: true,
                    text: 'Password',
                    controller: pwdController,
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  CustomAuthButton(
                    onTap: isLoading ? null : login,
                    child: isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Text(
                            'Sign in',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  SizedBox(height: 25),
                  CustomAuthNavigator(
                    text1: "Don't",
                    text2: 'Signup',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
