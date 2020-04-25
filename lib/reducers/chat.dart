import 'package:blazehub/actions/chat.dart';
import 'package:blazehub/models/chat.dart';

ChatState chatReducer(ChatState state, action) {
  switch (action.runtimeType) {
    case AddMessage:
      final addMessageAction = action as AddMessage;

      return state.copyWithMessage(
        addMessageAction.chatID,
        addMessageAction.payload,
      );

    default:
      return state;
  }
}
