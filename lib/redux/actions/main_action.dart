import 'package:geolocator/geolocator.dart';
import 'package:grid_mobile/constants/enum/route_enum.dart';

class SetMyLocation {
  final Position? myLocation;

  SetMyLocation({this.myLocation});
}

class SetLayoutIndexScreen {
  final RouteEnum? layoutIndexScreen;

  SetLayoutIndexScreen({this.layoutIndexScreen});
}

class SetLoading {
  final bool isLoading;

  SetLoading({this.isLoading = false});
}
