import 'package:flutter/material.dart';
import 'package:grid_mobile/redux/modules/map_state.dart';

import 'modules/main_state.dart';
import 'modules/user_state.dart';

@immutable
class AppState {
  final MainState mainState;
  final UserState userState;
  final MapState mapState;

  const AppState({
    required this.mainState,
    required this.userState,
    required this.mapState,
  });

  factory AppState.initial() {
    return AppState(
        mainState: MainState.initial(),
        userState: UserState.initial(),
        mapState: MapState.initial());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          mainState == other.mainState &&
          userState == other.userState &&
          mapState == other.mapState;

  @override
  int get hashCode =>
      mainState.hashCode ^ userState.hashCode ^ mapState.hashCode;
}
