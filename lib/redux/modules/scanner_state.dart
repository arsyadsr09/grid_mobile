import 'package:grid_mobile/models/scanned_item_model.dart';

class ScannerState {
  const ScannerState({this.scannedItem});

  final ScannedItem? scannedItem;

  factory ScannerState.initial() {
    return const ScannerState(scannedItem: null);
  }

  ScannerState copyWith({ScannedItem? scannedItem}) {
    return ScannerState(
      scannedItem: scannedItem ?? this.scannedItem,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScannerState &&
          runtimeType == other.runtimeType &&
          scannedItem == other.scannedItem;

  @override
  int get hashCode => scannedItem.hashCode;
}
