import 'package:redux/redux.dart';

import '../actions/main_action.dart';
import '../modules/main_state.dart';

final mainReducer = combineReducers<MainState>([
  TypedReducer<MainState, SetMyLocation>(_setMyLocationState),
  TypedReducer<MainState, SetLayoutIndexScreen>(_setLayoutIndexScreenState),
]);

MainState _setMyLocationState(MainState? state, SetMyLocation payload) {
  return state!.copyWith(myLocation: payload.myLocation);
}

MainState _setLayoutIndexScreenState(MainState? state, SetLayoutIndexScreen payload) {
  return state!.copyWith(layoutIndexScreen: payload.layoutIndexScreen);
}
