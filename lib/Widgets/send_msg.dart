import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendMessage extends StatefulWidget {
  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  _sendMsg() async {
    FocusScope.of(context).unfocus();
    final userId = FirebaseAuth.instance.currentUser;
    final getuserdata = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId.uid)
        .get();

    await FirebaseFirestore.instance.collection("chat").add({
      "text": _textinputuser,
      "timesnow": Timestamp.now(),
      "username": getuserdata["username"],
      "userid": userId.uid,
      "userimage": getuserdata["imageurl"],
    });
    _textcontroller.clear();
    setState(() {
      _textinputuser = "";
    });
  }

  TextEditingController _textcontroller = TextEditingController();
  var _textinputuser = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: _textcontroller,
              onChanged: (value) {
                setState(() {
                  _textinputuser = value;
                  print(_textinputuser);
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: "send message...."),
            )),
            SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue.shade100),
              child: IconButton(
                  color: Theme.of(context).accentColor,
                  onPressed: _textinputuser.trim().isEmpty ? null : _sendMsg,
                  icon: Icon(
                    Icons.send,
                    size: 30,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
