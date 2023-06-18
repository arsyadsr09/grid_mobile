import 'package:geolocator/geolocator.dart';
import 'package:grid_mobile/constants/enum/route_enum.dart';

class MainState {
  MainState({this.myLocation, this.layoutIndexScreen = RouteEnum.home});

  final Position? myLocation;
  final RouteEnum? layoutIndexScreen;

  factory MainState.initial() {
    return MainState(myLocation: null);
  }

  MainState copyWith({
    Position? myLocation,
    RouteEnum? layoutIndexScreen,
  }) {
    return MainState(
      myLocation: myLocation ?? this.myLocation,
      layoutIndexScreen: layoutIndexScreen ?? this.layoutIndexScreen,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainState &&
          runtimeType == other.runtimeType &&
          myLocation == other.myLocation &&
          layoutIndexScreen == other.layoutIndexScreen;

  @override
  int get hashCode => myLocation.hashCode ^ layoutIndexScreen.hashCode;
}
