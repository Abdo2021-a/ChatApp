import 'package:chatapp/Widgets/send_msg.dart';
import 'package:chatapp/Widgets/view_msg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chat "),
        leading: IconButton(
          onPressed: () async {
            FirebaseAuth.instance.signOut();
          },
          icon: Icon(Icons.logout_outlined),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ViewMessages(),
            ),
            SendMessage(),
          ],
        ),
      ),
    );
  }
}
