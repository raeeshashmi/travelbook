import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelcommunity/screens/home_screen.dart';
import 'package:travelcommunity/screens/login_screen.dart';
import 'package:travelcommunity/utils/helper_functions.dart';
import 'package:travelcommunity/widgets/custom_auth_button.dart';
import 'package:travelcommunity/widgets/custom_auth_image.dart';
import 'package:travelcommunity/widgets/custom_auth_navigator.dart';
import 'package:travelcommunity/widgets/custom_auth_text.dart';
import 'package:travelcommunity/widgets/custom_auth_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  void signup() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String pwd = pwdController.text.trim();

    if (name.isNotEmpty && email.isNotEmpty && pwd.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      FirebaseAuth auth = FirebaseAuth.instance;

      try {
        await auth.createUserWithEmailAndPassword(
          email: email,
          password: pwd,
        );

        Map<String, dynamic> data = {
          'name': name,
          'email': email,
          'image':
              'https://iudrtzlfoonghkyqkzty.supabase.co/storage/v1/object/public/images//unnamed.webp',
        };

        await FirebaseFirestore.instance.collection('users').add(data);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        String errorText = '';
        switch (e.code) {
          case 'weak-password':
            errorText = 'Password provided is too weak';
            break;
          case 'invalid-email':
            errorText = 'Invalid email address';
            break;
          case 'email-already-in-use':
            errorText = 'An account already exists with this email';
            break;
          default:
            errorText = 'Signup failed: ${e.message}';
        }

        HelperFunctions.customSnackBar(
          context: context,
          text: errorText,
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
            CustomAuthImage(url: 'images/signup.png'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAuthText(text: 'Signup'),
                  CustomAuthTextfield(
                    text: 'Name',
                    controller: nameController,
                  ),
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
                  CustomAuthButton(
                    onTap: isLoading ? null : signup,
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
                            'Sign up',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  SizedBox(height: 15),
                  CustomAuthNavigator(
                    text1: "Already",
                    text2: 'Signin',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
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
