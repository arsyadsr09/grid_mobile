import 'package:grid_mobile/redux/reducers/map_reducer.dart';

import 'app_state.dart';
import 'reducers/main_reducer.dart';
import 'reducers/payments_reducer.dart';
import 'reducers/user_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    mainState: mainReducer(state.mainState, action),
    userState: userReducer(state.userState, action),
    mapState: mapReducer(state.mapState, action),
    paymentsState: scannerReducer(state.paymentsState, action),
  );
}
