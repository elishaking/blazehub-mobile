import 'package:blazehub/view_models/friend.dart';
import 'package:redux/redux.dart';

import 'package:blazehub/models/app.dart';

class MenuViewModel extends FriendViewModel {
  Store<AppState> _store;

  MenuViewModel(this._store) : super(_store);

  factory MenuViewModel.create(store) {
    return MenuViewModel(store);
  }
}
