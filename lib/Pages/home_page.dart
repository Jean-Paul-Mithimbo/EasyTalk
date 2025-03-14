// import 'package:easy_talk/Pages/chat_page.dart';
// import 'package:easy_talk/components/user_tile.dart';
// import 'package:easy_talk/services/auth/auth_service.dart';
// import 'package:easy_talk/components/my_drawer.dart';
// import 'package:easy_talk/services/chat/chat_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   HomePage({super.key});

// //  chat & auth services
//   final AuthService _authService = AuthService();
//   final ChatService _chatService = ChatService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       drawer: const MyDrawer(),
//       body: _buildUserList(),
//     );
//   }

//   // build a list of users for the current logged in user
//   Widget _buildUserList() {
//     return StreamBuilder(
//         stream: _chatService.getUsersStream(),
//         builder: (context, snapshop) {
//           // error
//           if (snapshop.hasError) {
//             return const Text('Error');
//           }
//           //loading
//           if (snapshop.connectionState == ConnectionState.waiting) {
//             return const Text('Loading..');
//           }
//           // return List view
//           return ListView(
//             children: snapshop.data!
//                 .map<Widget>((userData) => _buidUserListItem(userData, context))
//                 .toList(),
//           );
//         });
//   }

//   // build individual list tile for user
//   Widget _buidUserListItem(
//       Map<String, dynamic> userData, BuildContext context) {
//     // display all users except current user
//     if (userData["email"] != _authService.getCurrentUser()!.email) {
//       return UserTile(
//         text: userData["email"],
//         onTap: () {
//           // tapped on a user -> go to chat page

//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ChatPage(
//                   receiverEmail: userData["email"],
//                   receiverID: userData['uid'],
//                 ),
//               ));
//         },
//       );
//     }else{
//       return Container(
       
//       );
//     }
//   }
// }


import 'package:easy_talk/Pages/chat_page.dart';
import 'package:easy_talk/components/user_tile.dart';
import 'package:easy_talk/services/auth/auth_service.dart';
import 'package:easy_talk/components/my_drawer.dart';
import 'package:easy_talk/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Chat & Auth services
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

  // Construction de la liste des utilisateurs
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // Gestion des erreurs
        if (snapshot.hasError) {
          return const Center(
            child: Text('❌ Une erreur est survenue', style: TextStyle(fontSize: 16)),
          );
        }
        // En attente de chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // Si aucun utilisateur trouvé
        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('🚀 Aucun utilisateur trouvé.', style: TextStyle(fontSize: 16)),
          );
        }
        // Affichage de la liste des utilisateurs
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  // Construction d'un élément de la liste
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    // Ne pas afficher l'utilisateur connecté lui-même
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          // Aller à la page de chat
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData['uid'],
              ),
            ),
          );
        },
      );
    } else {
      return const SizedBox.shrink(); // Renvoie un widget vide
    }
  }
}
