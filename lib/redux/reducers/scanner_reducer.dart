import 'package:redux/redux.dart';

import '../actions/scanner_action.dart';
import '../modules/scanner_state.dart';

final scannerReducer = combineReducers<ScannerState>([
  TypedReducer<ScannerState, SetScannedItem>(_setScannedItemState),
]);

ScannerState _setScannedItemState(ScannerState? state, SetScannedItem payload) {
  return state!.copyWith(scannedItem: payload.scannedItem);
}
