import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
   CustomButtom({this.ontap, required this.text});
final String text;
VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 40,
        child: Center(child: Text(text,style: TextStyle(fontSize: 20,fontFamily: 'Pacifico'),)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
