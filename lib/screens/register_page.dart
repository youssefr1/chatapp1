import 'package:chatapp/constants.dart';
import 'package:chatapp/helper/show_snack_bar.dart';
import 'package:chatapp/screens/Login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widjets/custom_buttom.dart';
import '../widjets/custom_textfeild.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  static String id = 'SignUpPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

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
                  Image.asset(
                    klogo,
                    height: 140,
                  ),
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
                        'REGISTER',
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
                        isLoading = true;
                        setState(() {});
                        formKey.currentState!.save();
                        try {
                          await regesterUser();
                          showSnackBar(
                            context,
                            'Successfully Registered',
                          );
                          Navigator.pushNamed(context, 'LoginPage');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(context, 'Weak Password');
                          } else if (e.code ==
                              'email-already-in-use') {
                            showSnackBar(
                              context,
                              'Email already in use',
                            );
                          } else if (e.code == 'invalid-email') {
                            showSnackBar(
                              context,
                              'invalid email format ',
                            );
                          } else {
                            showSnackBar(
                              context,
                              'Error: ${e.message}',
                            );
                          }
                        } catch (e) {
                          showSnackBar(context, 'There was an error');
                        }
                      }
                      isLoading = false;
                      setState(() {});
                    },
                    text: 'REGISTER',
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account ? ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login',
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

  Future<void> regesterUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );
  }
}
