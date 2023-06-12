import 'package:flutter/material.dart';

import 'modules/main_state.dart';
import 'modules/user_state.dart';

@immutable
class AppState {
  final MainState mainState;
  final UserState userState;

  const AppState({
    required this.mainState,
    required this.userState,
  });

  factory AppState.initial() {
    return AppState(
      mainState: MainState.initial(),
      userState: UserState.initial(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          mainState == other.mainState &&
          userState == other.userState;

  @override
  int get hashCode => mainState.hashCode ^ userState.hashCode;
}
