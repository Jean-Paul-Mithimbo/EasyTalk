// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_talk/components/chat_bubble.dart';
// import 'package:easy_talk/components/my_textfiel.dart';
// import 'package:easy_talk/services/auth/auth_service.dart';
// import 'package:easy_talk/services/chat/chat_service.dart';
// import 'package:flutter/material.dart';

// class ChatPage extends StatelessWidget {
//   final String receiverEmail;
//   final String receiverID;

//   ChatPage({
//     super.key,
//     required this.receiverEmail,
//     required this.receiverID,
//   });

//   // text controller
//   final TextEditingController _messageController = TextEditingController();
//   // chat et auth service
//   final ChatService _chatService = ChatService();
//   final AuthService _authService = AuthService();
//   // send messages
//   void sendMessage() async {
//     // if there is something inside the textfield
//     if (_messageController.text.isEmpty) {
//       // send the message
//       await _chatService.sendMessage(
//         receiverID,
//         _messageController.text,
//       );

//       // clear textcontroller
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(receiverEmail),
//       ),
//       body: Column(
//         children: [
//           // diaplay all message
//           Expanded(
//             child: _buildMessageList(),
//           ),
//           // use input
//           _buildUserInput()
//         ],
//       ),
//     );
//   }

//   // build message item
//   Widget _buildMessageItem(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     // is current user
//     bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

//     // align message to the right if sender is the current user otherwise left
//     var alignment =
//         isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
//     return Container(
//         alignment: alignment,
//         child: Column(
//           crossAxisAlignment:
//               isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: [
//             ChatBubble(
//               message: data['message'],
//               isCurrentUser: isCurrentUser,
//             )
//           ],
//         ));
//   }

//   // build message input
//   Widget _buildMessageList() {
//     String senderID = _authService.getCurrentUser()!.uid;
//     return StreamBuilder(
//       stream: _chatService.getMessages(receiverID, senderID),
//       builder: (context, snapshot) {
//         // errors
//         if (snapshot.hasError) {
//           return const Text('error');
//         }
//         // loading
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Text('loading..');
//         }
//         // return list view
//         return ListView(
//           children:
//               snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
//         );
//       },
//     );
//   }

//   // // build message items
//   // Widget _buildMessageItem(DocumentSnapshot doc) {
//   //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//   //   return Text(data['message']);
//   // }

//   // build message input
//   Widget _buildUserInput() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 50.0),
//       child: Row(
//         children: [
//           // textfield should take up most of space
//           Expanded(
//             child: MyTextfiel(
//               controller: _messageController,
//               hintText: 'Type message',
//               obscureText: false,
//             ),
//           ),
//           // send bouton
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.green,
//               shape: BoxShape.circle,
//             ),
//             margin: const EdgeInsets.only(right: 25),
//             child: IconButton(
//                 onPressed: sendMessage,
//                 icon: const Icon(
//                   Icons.arrow_upward,
//                   color: Colors.white,
//                 )),
//           )
//         ],
//       ),
//     );
//   }
// }





// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_talk/components/chat_bubble.dart';
// import 'package:easy_talk/components/my_textfiel.dart';
// import 'package:easy_talk/services/auth/auth_service.dart';
// import 'package:easy_talk/services/chat/chat_service.dart';
// import 'package:flutter/material.dart';

// class ChatPage extends StatelessWidget {
//   final String receiverEmail;
//   final String receiverID;

//   ChatPage({
//     super.key,
//     required this.receiverEmail,
//     required this.receiverID,
//   });

//   // Text controller
//   final TextEditingController _messageController = TextEditingController();

//   // Chat et Auth services
//   final ChatService _chatService = ChatService();
//   final AuthService _authService = AuthService();

//   // Fonction pour envoyer un message
//   void sendMessage() async {
//     // Vérifie si le champ de texte n'est pas vide
//     if (_messageController.text.isNotEmpty) {
//       await _chatService.sendMessage(
//         receiverID,
//         _messageController.text,
//       );

//       // Efface le champ après l'envoi
//       _messageController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(receiverEmail),
//       ),
//       body: Column(
//         children: [
//           // Affichage des messages
//           Expanded(
//             child: _buildMessageList(),
//           ),
//           // Champ d'entrée utilisateur
//           _buildUserInput(),
//         ],
//       ),
//     );
//   }

//   // Construction de la liste des messages
//   Widget _buildMessageList() {
//     String senderID = _authService.getCurrentUser()!.uid;

//     return StreamBuilder(
//       stream: _chatService.getMessages(receiverID, senderID),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Center(child: Text('❌ Une erreur est survenue.'));
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text('📭 Aucun message.'));
//         }

//         return ListView(
//           children:
//               snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
//         );
//       },
//     );
//   }

//   // Construction d'un message individuel
//   Widget _buildMessageItem(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

//     return Align(
//       alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: ChatBubble(
//         message: data['message'],
//         isCurrentUser: isCurrentUser,
//       ),
//     );
//   }

//   // Construction du champ de saisie utilisateur
//   Widget _buildUserInput() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 50.0),
//       child: Row(
//         children: [
//           // Champ de texte
//           Expanded(
//             child: MyTextfiel(
//               controller: _messageController,
//               hintText: 'Type message',
//               obscureText: false,
//             ),
//           ),
//           // Bouton d'envoi
//           Container(
//             decoration: const BoxDecoration(
//               color: Colors.green,
//               shape: BoxShape.circle,
//             ),
//             margin: const EdgeInsets.only(right: 25),
//             child: IconButton(
//               onPressed: sendMessage,
//               icon: const Icon(
//                 Icons.arrow_upward,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_talk/components/chat_bubble.dart';
import 'package:easy_talk/components/my_textfiel.dart';
import 'package:easy_talk/services/auth/auth_service.dart';
import 'package:easy_talk/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  // Text controller
  final TextEditingController _messageController = TextEditingController();

  // Chat et Auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // Fonction pour envoyer un message
  void sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text.trim());
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Text(receiverEmail, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildUserInput(),
        ],
      ),
    );
  }

  // Affichage des messages avec effet professionnel
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;

    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('❌ Erreur de chargement.'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              '📭 Aucun message.\nDémarrez la conversation !',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          itemCount: snapshot.data!.docs.length,
          reverse: true,
          itemBuilder: (context, index) {
            return _buildMessageItem(snapshot.data!.docs[index]);
          },
        );
      },
    );
  }

  // Affichage amélioré des messages
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    DateTime timestamp = (data['timestamp'] as Timestamp).toDate();
    String formattedTime = DateFormat('HH:mm').format(timestamp);

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isCurrentUser ? Colors.blueAccent : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(15),
                  topRight: const Radius.circular(15),
                  bottomLeft: isCurrentUser
                      ? const Radius.circular(15)
                      : const Radius.circular(0),
                  bottomRight: isCurrentUser
                      ? const Radius.circular(0)
                      : const Radius.circular(15),
                ),
              ),
              child: Text(
                data['message'],
                style: TextStyle(
                  fontSize: 16,
                  color: isCurrentUser ? Colors.white : Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              formattedTime,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // Champ de saisie utilisateur avec un design amélioré
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: MyTextfiel(
              controller: _messageController,
              hintText: 'Tapez votre message...',
              obscureText: false,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
