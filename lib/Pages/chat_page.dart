import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_talk/components/my_textfiel.dart';
import 'package:easy_talk/services/auth/auth_service.dart';
import 'package:easy_talk/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  // text controller
  final TextEditingController _messageController = TextEditingController();
  // chat et auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  // send messages
  void sendMessage() async {
    // if there is something inside the textfield
    if (_messageController.text.isEmpty) {
      // send the message
      await _chatService.sendMessage(
        receiverID,
        _messageController.text,
      );

      // clear textcontroller 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          // diaplay all message
          Expanded(
            child: _buildMessageList(),
          ),
          // use input
          _buildUserInput()
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        // errors
        if (snapshot.hasError) {
          return const Text('error');
        }
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading..');
        }
        // return list view
        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }


  // build message items
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Text(data['message']);
  }

  // build message input
  Widget _buildUserInput() {
    return Row(
      children: [
        // textfield should take up most of space
        Expanded(
          child: MyTextfiel(
            controller: _messageController,
            hintText: 'Type message',
            obscureText: false,
          ),
        ),
        // send bouton
        IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.arrow_upward,
            ))
      ],
    );
  }
}
