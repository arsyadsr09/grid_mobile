import 'package:redux/redux.dart';

import '../actions/user_action.dart';
import '../modules/user_state.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, SetUserInfo>(_setUserInfoState),
  TypedReducer<UserState, SetCredit>(_setCreditState),
]);

UserState _setUserInfoState(UserState? state, SetUserInfo payload) {
  return state!
      .copyWith(userInfo: payload.userInfo, isLogin: payload.userInfo != null);
}

UserState _setCreditState(UserState? state, SetCredit payload) {
  return state!.copyWith(credit: payload.credit);
}
