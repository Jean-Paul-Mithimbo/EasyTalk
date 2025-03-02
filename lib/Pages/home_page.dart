import 'package:easy_talk/Pages/chat_page.dart';
import 'package:easy_talk/components/user_tile.dart';
import 'package:easy_talk/services/auth/auth_service.dart';
import 'package:easy_talk/components/my_drawer.dart';
import 'package:easy_talk/services/chat/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

//  chat & auth services
  final AuthService _authService = AuthService();
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  // build a list of users for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshop) {
          // error
          if (snapshop.hasError) {
            return const Text('Error');
          }
          //loading
          if (snapshop.connectionState == ConnectionState.waiting) {
            return const Text('Loading..');
          }
          // return List view
          return ListView(
            children: snapshop.data!
                .map<Widget>((userData) => _buidUserListItem(userData,context))
                .toList(),
          );
        });
  }

  // build individual list tile for user
  Widget _buidUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all users except current user
    return UserTile(
      text: userData["email"],
      onTap: () {
        // tapped on a user -> go to chat page

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
              ),
            ));
      },
    );
  }
}
