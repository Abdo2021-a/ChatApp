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
        title: Text("chat Screen"),
        leading: IconButton(
          onPressed: () async {
            FirebaseAuth.instance.signOut();
          },
          icon: Icon(Icons.logout_outlined),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chat/RqTLtgBcLVOdp0HiziyJ/message")
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            Center(
              child: CircularProgressIndicator(),
            );
          }
          final thelist = snapshot.data.docs;

          return ListView.builder(
              itemCount: thelist.length,
              itemBuilder: (context, index) {
                return Container(
                    padding: EdgeInsets.all(20),
                    child: Text(thelist[index]["text"]));
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection("chat/RqTLtgBcLVOdp0HiziyJ/message")
                .add({"text": "ahla msa aleko"});
          },
          child: Icon(Icons.add)),
    );
  }
}
