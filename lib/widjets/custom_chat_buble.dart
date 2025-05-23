import 'package:chatapp/model/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
   ChatBuble({
    super.key, this.messageVar
  });
  final Message? messageVar ;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(

          padding: EdgeInsets.only(left: 12,top: 16,bottom: 16,right: 12),
          margin: EdgeInsets.all(10),

          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(32),topRight:Radius.circular(32),
                  bottomLeft:Radius.circular(32)),
              color: Colors.blueGrey
          ),
          child:Text(messageVar!.message,style: TextStyle(fontSize: 18,color: Colors.white),)
      ),
    );
  }
}
class ChatBubleResponse extends StatelessWidget {
  ChatBubleResponse({
    super.key, this.messageVar
  });
  final Message? messageVar ;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(

          padding: EdgeInsets.only(left: 12,top: 16,bottom: 16,right: 12),
          margin: EdgeInsets.all(10),

          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(32),topRight:Radius.circular(32),
                  bottomRight:Radius.circular(32)),
              color: Colors.green
          ),
          child:Text(messageVar!.message,style: TextStyle(fontSize: 18,color: Colors.white),)
      ),
    );
  }
}