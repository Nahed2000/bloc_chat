import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  late String text;

  late String sender;

  late Timestamp time;

  Message();

  Message.fromMap(Map<String, dynamic> map) {
    text = map['text'];
    time = map['time'];
    sender = map['sender'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['text'] = text;
    map['sender'] = sender;
    map['time'] = time;
    return map;
  }
}
