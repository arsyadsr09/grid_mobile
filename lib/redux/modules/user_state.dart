import 'package:grid_mobile/models/user_model.dart';

class UserState {
  const UserState({this.userInfo, this.isLogin = false});

  final UserModel? userInfo;
  final bool isLogin;

  factory UserState.initial() {
    return const UserState(userInfo: null);
  }

  UserState copyWith({UserModel? userInfo, bool isLogin = false}) {
    return UserState(
      userInfo: userInfo ?? this.userInfo,
      isLogin: isLogin,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserState &&
          runtimeType == other.runtimeType &&
          userInfo == other.userInfo &&
          isLogin == other.isLogin;

  @override
  int get hashCode => userInfo.hashCode ^ isLogin.hashCode;
}
