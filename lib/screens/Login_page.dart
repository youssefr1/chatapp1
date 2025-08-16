import 'package:chatapp/constants.dart';
import 'package:chatapp/helper/show_snack_bar.dart';
import 'package:chatapp/screens/Login_page.dart';
import 'package:chatapp/screens/chat_page.dart';
import 'package:chatapp/screens/cubits/login_cubit.dart';
import 'package:chatapp/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widjets/custom_buttom.dart';
import '../widjets/custom_textfeild.dart';


class LoginPage extends StatelessWidget {
  String? password;
  String? email;
  GlobalKey<FormState> formKey = GlobalKey();
  static String id = 'LoginPage';

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
  listener: (context, state) {
     if(state is LoginLoading){
       isLoading = true;
     }
     else if(state is LoginSuccess){
       isLoading = false;
       Navigator.pushNamed(context, ChatPage.id);
     }
     else if(state is LoginFailure){
       isLoading = false;
       showSnackBar(context, state.errMessage);
     }
  },
  child: ModalProgressHUD(
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
                  Image.asset('assets/images/whatsapp.png', height: 140),
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
                        BlocProvider.of<LoginCubit>(context).loginAuth(email: email!, password: password!);
                      } else {
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
