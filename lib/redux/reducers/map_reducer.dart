import 'package:grid_mobile/redux/actions/map_action.dart';
import 'package:redux/redux.dart';

import '../modules/map_state.dart';

final mapReducer = combineReducers<MapState>([
  TypedReducer<MapState, SetSelectedMarker>(_setSelectedMarkerState),
]);

MapState _setSelectedMarkerState(MapState? state, SetSelectedMarker payload) {
  return state!.copyWith(selectedMarker: payload.selectedMarker);
}
