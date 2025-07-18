import 'package:chaty/components/my_drawer.dart';
import 'package:chaty/components/user_title.dart';
import 'package:chaty/pages/chat_page.dart';
import 'package:chaty/services/auth/auth_service.dart';
import 'package:chaty/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(
      stream: _chatService.getUserStream(),
       builder: (context, snapshot){

        if(snapshot.hasError){
          return const Text("Error");
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading..");
        }
        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
        );

       }
          
       );
  }
Widget _buildUserListItem(
  Map<String, dynamic> userData, BuildContext context){
  if (userData["email"] != _authService.getCurrentUser()!.email) {
    return UserTitle(
text: (userData['email'] ?? 'No Name').toString(),    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            reciveEmail: userData['email'], 
            receiverId: userData['uid'],// Passe l'email au chat
          ),
        ),
      );
    },
  );
  }else{
    return Container(); // Ne pas afficher l'utilisateur actuel
  }
}
}