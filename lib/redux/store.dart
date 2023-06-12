import 'package:redux/redux.dart';

import 'app_reducers.dart';
import 'app_state.dart';

Future<Store<AppState>> createStore() async {
  return Store(appReducer,
      initialState: AppState.initial(), distinct: true, middleware: []
      // [LoggingMiddleware.printer()]
      );
}
