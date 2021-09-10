import 'package:flutter/material.dart';

class MsgBubble extends StatelessWidget {
  String message;
  bool isme;
  String username;
  String userimage;
  MsgBubble({this.message, this.isme, this.username, this.userimage});

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.end,
      crossAxisAlignment:
          isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: message.length > 0 && message.length <= 11
              ? 210
              : message.length >= 12 && message.length <= 15
                  ? 250
                  : message.length >= 16 && message.length <= 17
                      ? 270
                      : message.length >= 18 && message.length <= 20
                          ? 300
                          : message.length >= 21 && message.length <= 26
                              ? 360
                              : message.length >= 27 && message.length <= 30
                                  ? 380
                                  : null,
          child: isme
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(45),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.blue.shade200),
                  child: ListTile(
                    subtitle: Text(
                      message,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    trailing: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(userimage),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            username,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(45),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.teal.shade200),
                  child: ListTile(
                    subtitle: Text(
                      message,
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(userimage),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            username,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
