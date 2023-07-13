import 'package:redux/redux.dart';

import '../actions/payments_action.dart';
import '../modules/payments_state.dart';

final scannerReducer = combineReducers<PaymentsState>([
  TypedReducer<PaymentsState, SetScannedItem>(_setScannedItemState),
  TypedReducer<PaymentsState, SetReservation>(_setReservationState),
]);

PaymentsState _setScannedItemState(
    PaymentsState? state, SetScannedItem payload) {
  return state!.copyWith(scannedItem: payload.scannedItem);
}

PaymentsState _setReservationState(
    PaymentsState? state, SetReservation payload) {
  return state!.copyWith(reservation: payload.reservation);
}
