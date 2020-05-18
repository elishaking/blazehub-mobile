import 'package:blazehub/models/app.dart';
import 'package:blazehub/reducers/root.dart';
import 'package:redux/redux.dart';

final store = Store<AppState>(
  appStateReducer,
  initialState: AppState.initialState(),
);
