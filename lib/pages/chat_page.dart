import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget{
  final String reciveEmail;

  const ChatPage({
    super.key,
    required this.reciveEmail,
  });

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(reciveEmail),
      )
    );
  }
}