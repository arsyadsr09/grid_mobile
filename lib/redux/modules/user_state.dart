import 'package:grid_mobile/models/user_model.dart';

class UserState {
  const UserState({
    this.userInfo,
    this.isLogin = false,
    this.credit,
  });

  final UserModel? userInfo;
  final bool isLogin;
  final int? credit;

  factory UserState.initial() {
    return const UserState(userInfo: null, isLogin: false, credit: 0);
  }

  UserState copyWith({UserModel? userInfo, bool? isLogin, int? credit}) {
    return UserState(
      userInfo: userInfo ?? this.userInfo,
      isLogin: isLogin ?? this.isLogin,
      credit: credit ?? this.credit,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserState &&
          runtimeType == other.runtimeType &&
          userInfo == other.userInfo &&
          isLogin == other.isLogin &&
          credit == other.credit;

  @override
  int get hashCode => userInfo.hashCode ^ isLogin.hashCode ^ credit.hashCode;
}
