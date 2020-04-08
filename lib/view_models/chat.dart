import 'package:blazehub/actions/chat.dart';
import 'package:blazehub/models/chat.dart';
import 'package:blazehub/services/chat.dart';
import 'package:redux/redux.dart';

import 'package:blazehub/view_models/friend.dart';
import 'package:blazehub/models/app.dart';

var messageStream;
bool listeningForNewMessages = false;
var messageListener;

class ChatViewModel extends FriendViewModel {
  final Store<AppState> _store;
  final ChatState chatState;

  ChatViewModel(this._store, {this.chatState}) : super(_store);

  factory ChatViewModel.create(Store<AppState> store) {
    return ChatViewModel(
      store,
      chatState: store.state.chatState,
    );
  }

  void listenForMessages(String chatID) {
    // TODO: dispose this stream
    if (listeningForNewMessages) return;
    messageListener =
        chatService.newMessageAdded(chatID).listen((onData) async {
      // print(onData.snapshot.value);
      final newMessageData = onData.snapshot.value;
      // newMessageData['id'] = onData.snapshot.key;

      final newMessage = Message.fromJSON(newMessageData);

      _store.dispatch(AddMessage(
        {onData.snapshot.key: newMessage},
        chatID: chatID,
      ));

      print(_store.state.chatState.chats.keys.length);
    });

    listeningForNewMessages = true;
  }
}
