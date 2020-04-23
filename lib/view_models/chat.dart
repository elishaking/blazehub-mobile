import 'package:blazehub/actions/chat.dart';
import 'package:blazehub/models/chat.dart';
import 'package:blazehub/models/profile.dart';
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
  final ProfileState profileState;

  ChatViewModel(this._store, {this.chatState, this.profileState})
      : super(_store);

  factory ChatViewModel.create(Store<AppState> store) {
    return ChatViewModel(
      store,
      chatState: store.state.chatState,
      profileState: store.state.profileState,
    );
  }

  void listenForMessages(String chatID) {
    // TODO: dispose this stream
    if (listeningForNewMessages) return;
    messageListener =
        chatService.newMessageAdded(chatID).listen((onData) async {
      final newMessageData = onData.snapshot.value;
      // newMessageData['id'] = onData.snapshot.key;

      final newMessage = Message.fromJSON(newMessageData);

      _store.dispatch(AddMessage(
        {onData.snapshot.key: newMessage},
        chatID: chatID,
      ));

      print(_store.state.chatState.chats[chatID].messages.keys.length);
    });

    listeningForNewMessages = true;
  }

  Future<bool> addMessage(Message message, String chatID) async {
    return chatService.addMessage(message, chatID);
  }

  void cancelMessageListener() {
    if (listeningForNewMessages) {
      messageListener.cancel();

      listeningForNewMessages = false;
    }
  }
}
