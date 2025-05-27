import 'package:chaty/components/chat_bubble.dart';
import 'package:chaty/components/my_textfeild.dart';
import 'package:chaty/services/auth/auth_service.dart';
import 'package:chaty/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget{
  final String reciveEmail;
  final String receiverId;

   ChatPage({
    super.key,
    required this.reciveEmail,
    required this.receiverId,
  });

  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  
  void sendMessage() async{
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        receiverId,
       _messageController.text,
      );
      _messageController.clear();
    }
  } 
  // Placeholder for AuthService

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(reciveEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildUserInput()
        ],
      ),
    );
  
  }



Widget _buildMessageList() {
  String senderId = _authService.getCurrentUser()!.uid;
  return StreamBuilder(
    stream: _chatService.getMessages(receiverId, senderId),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return const Text("Error");
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text("Loading..");
      }
      
      return ListView(
        children: snapshot.data!.docs
            .map<Widget>((doc) => _buildMessageItem(doc))
            .toList(),
      );
    },
  );
}
  Widget _buildMessageItem(DocumentSnapshot doc) {
   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;
    
    var alignment = isCurrentUser ? Alignment.centerRight: Alignment.centerLeft;
    
    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: 
        isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["message"], isCurrentUser: isCurrentUser)
        ],
      ),
    );
    
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom:50.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextfeild(
              controller: _messageController,
                hintText: 'Type a message',
                obscureText: false,
              ),
            ),
          
          Container(
            decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
            margin: const EdgeInsets.only(right: 25.0),
            child: IconButton(
              icon: Icon(Icons.arrow_upward, color: Colors.white,),
              onPressed: sendMessage,
            ),
          ),
        ],
      ),
    );
    
  }
}