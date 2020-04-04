import 'package:firebase_database/firebase_database.dart';

final now = DateTime.now().millisecondsSinceEpoch;

class ChatService {
  final _dbRef = FirebaseDatabase.instance.reference();

  Stream<Event> newMessageAdded(String chatID) {
    return _dbRef
        .child('chats')
        .child(chatID)
        .orderByChild('date')
        .startAt(now)
        .onChildAdded;
  }
}

final chatService = ChatService();
