import 'package:flutter/material.dart';

class CustomFormTextfeild extends StatelessWidget {
   CustomFormTextfeild({this.obscureText ,this.onchange, required this.hintText,});
final String hintText;
Function(String)? onchange;
  bool? obscureText = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }

      },
      onChanged:onchange ,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(color:Colors.white,fontFamily: 'Pacifico'),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white,width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white,width: 3),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
