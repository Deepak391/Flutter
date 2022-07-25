import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userName;
  const MessageBubble(
      {Key? key,
      required this.message,
      required this.isMe,
      required this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.grey[300] : Color(0xFF242B2E),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
              ),
            ),
            width: 140,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isMe ? Color(0xFF242B2E) : Color(0xFFCAD5E2),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(message,
                    style: TextStyle(
                      color: isMe ? Color(0xFF242B2E) : Color(0xFFCAD5E2),
                    )),
              ],
            ),
          ),
        ]);
  }
}
