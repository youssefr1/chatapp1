import 'package:chatapp/constants.dart';
import 'package:chatapp/helper/show_snack_bar.dart';
import 'package:chatapp/screens/Login_page.dart';
import 'package:chatapp/screens/chat_page.dart';
import 'package:chatapp/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widjets/custom_buttom.dart';
import '../widjets/custom_textfeild.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? password;

  String? email;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Color(0xFF25D366),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: kPrimaryColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(height: 50),
                  Image.asset(klogo, height: 140),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'What\'s Me',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 150),
                  Row(
                    children: [
                      Text(
                        'Login ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  CustomFormTextfeild(
                    onchange: (data) {
                      email = data;
                    },
                    hintText: 'Email Address',
                    obscureText: false,
                  ),

                  SizedBox(height: 20),
                  CustomFormTextfeild(
                    onchange: (data) {
                      password = data;
                    },
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  CustomButtom(
                    ontap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        formKey.currentState!.save();
                        try {
                          await loginAuth();
                          showSnackBar(context, 'Login successful');
                          Navigator.pushNamed(
                            context,
                            ChatPage.id,
                            arguments: email,
                          );
                          // Navigate to next page if needed
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(
                              context,
                              'No user found for that email.',
                            );
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(
                              context,
                              'Incorrect password.',
                            );
                          } else if (e.code == 'invalid-email') {
                            showSnackBar(
                              context,
                              'Invalid email address.',
                            );
                          } else {
                            showSnackBar(
                              context,
                              'Authentication failed. Please try again.',
                            );
                          }
                        } catch (e) {
                          showSnackBar(
                            context,
                            'An error occurred. Please try again.',
                          );
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                    text: 'Login',
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account ?  ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            RegisterPage.id,
                          );
                        },
                        child: Text(
                          'Regester',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginAuth() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email!,
          password: password!,
        );
  }
}
