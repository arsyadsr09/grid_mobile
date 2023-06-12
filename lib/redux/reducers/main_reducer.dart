import 'package:redux/redux.dart';

import '../actions/main_action.dart';
import '../modules/main_state.dart';

final mainReducer = combineReducers<MainState>([
  TypedReducer<MainState, SetThemesMap>(_setThemesMapMainState),
]);

MainState _setThemesMapMainState(MainState? state, SetThemesMap payload) {
  return state!.copyWith(themesMap: payload.themesMap);
}
