import 'package:bloc_chat/firebase/fb_auth.dart';
import 'package:bloc_chat/firebase/fb_store.dart';
import 'package:bloc_chat/model/message.dart';
import 'package:bloc_chat/util/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget/message_text.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with Helper {
  var currentUser = FirebaseAuth.instance.currentUser!.email!;

  late TextEditingController text;

  @override
  void initState() {
    // TODO: implement initState
    text = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Chat Screen',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                FbAuth().logOut();
                Navigator.pushReplacementNamed(context, '/login_screen');
              },
              icon: const Icon(Icons.login_outlined))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot<Message>>(
              stream: FbFirestore().readMessage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => MessageText(
                      text: snapshot.data!.docs[index].data().text,
                      sender: snapshot.data!.docs[index].data().sender,
                      isME: currentUser ==
                          snapshot.data!.docs[index].data().sender,
                    ),
                    itemCount: snapshot.data!.docs.length,
                  );
                } else {
                  return const Center(
                    child: Text('error'),
                  );
                }
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: text,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async => await performSend(),
                    child: Text(
                      'send',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void>performSend()async{
    if(checkData()){
      await send();
      text.clear();
    }
  }
  bool checkData() {
    if (text.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Uou must write message', error: true);
    return false;
  }
  Future<void>send()async{
    await FbFirestore().createMessage(message: message);
  }
  Message get message{
    Message message = Message();
    message.text = text.text;
    message.sender = currentUser;
    message.time = Timestamp.fromDate(DateTime.now());
    return message ;
  }
}
