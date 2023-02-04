import 'package:bloc_chat/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FbFirestore {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> createMessage({required Message message}) async {
    return await _firebaseFirestore
        .collection('chat')
        .add(message.toMap())
        .then((value) => true)
        .catchError((onError) => false);
  }

  Stream<QuerySnapshot<Message>> readMessage() async* {
    yield* _firebaseFirestore
        .collection('chat')
        .orderBy('time')
        .withConverter<Message>(
            fromFirestore: (snapshot, options) =>
                Message.fromMap(snapshot.data()!),
            toFirestore: (value, options) => Message().toMap())
        .snapshots();
  }
}
