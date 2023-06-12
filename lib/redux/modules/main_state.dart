import 'dart:io';

class MainState {
  MainState({this.themesMap});

  final List? themesMap;

  factory MainState.initial() {
    return MainState(themesMap: []);
  }

  MainState copyWith(
      {List? themesMap,
      List? offlineMaps,
      List? groups,
      List? element,
      List? layers,
      List? elementInputList,
      double? unitSize,
      String? menuSelected,
      Map<String, dynamic>? trackingData,
      List<File>? trackingImage,
      List<Map<String, dynamic>>? groupDrawmap,
      Map? selectedGroup,
      Map? mapType,
      Map? directionStart,
      Map? directionEnd,
      Map? selectedLayer,
      Map? selectedOfflineMap}) {
    return MainState(
      themesMap: themesMap ?? this.themesMap,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainState &&
          runtimeType == other.runtimeType &&
          themesMap == other.themesMap ;

  @override
  int get hashCode =>
      themesMap.hashCode ;
}
