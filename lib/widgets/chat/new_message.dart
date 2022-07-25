import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = "";
  final _controller = TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot<Map<String, dynamic>>? u = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    final username = u["username"];
    FirebaseFirestore.instance.collection("chat").add({
      "text": _enteredMessage,
      "createdAt": Timestamp.now(),
      "userId": user.uid,
      "username": username
    });
    setState(() {
      _enteredMessage = "";
    });
    print(Timestamp.now().toString());
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: "Send a message..."),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          )),
          IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Colors.black54,
          )
        ],
      ),
    );
  }
}
