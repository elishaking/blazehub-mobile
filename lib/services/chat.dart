import 'package:blazehub/models/chat.dart';
import 'package:firebase_database/firebase_database.dart';

final now = DateTime.now().millisecondsSinceEpoch;

class ChatService {
  final _dbRef = FirebaseDatabase.instance.reference();

  Stream<Event> newMessageAdded(String chatID) {
    return _dbRef
        .child('chats')
        .child(chatID)
        // .orderByChild('date')
        // .startAt(now)
        .onChildAdded;
  }

  Future<bool> addMessage(Message message, String chatID) async {
    try {
      final messageRef = _dbRef.child('chats').child(chatID).push();
      await messageRef.set(message.toJSON());

      return true;
    } catch (err) {
      print(err);

      return false;
    }
  }
}

final chatService = ChatService();
