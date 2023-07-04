import '../../models/models.dart';

class MapState {
  const MapState({this.selectedMarker});

  final MarkerModel? selectedMarker;

  factory MapState.initial() {
    return const MapState(selectedMarker: null);
  }

  MapState copyWith({MarkerModel? selectedMarker}) {
    return MapState(
      selectedMarker: selectedMarker ?? this.selectedMarker,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapState &&
          runtimeType == other.runtimeType &&
          selectedMarker == other.selectedMarker;

  @override
  int get hashCode => selectedMarker.hashCode;
}
