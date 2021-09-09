import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'msg_bubble.dart';

class ViewMessages extends StatefulWidget {
  @override
  _ViewMessagesState createState() => _ViewMessagesState();
}

class _ViewMessagesState extends State<ViewMessages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .orderBy("timesnow", descending: true)
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final userid = FirebaseAuth.instance.currentUser;
          return ListView.builder(
              reverse: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (ctx, index) {
                return Container(
                  padding: EdgeInsets.all(15),
                  child: MsgBubble(
                    isme: snapshot.data.docs[index]["userid"] == userid.uid,
                    userimage: snapshot.data.docs[index]["userimage"],
                    message: snapshot.data.docs[index]["text"],
                    username: snapshot.data.docs[index]["username"],
                  ),
                );
              });
        },
      ),
    );
  }
}
