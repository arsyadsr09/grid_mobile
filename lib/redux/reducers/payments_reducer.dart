import 'package:redux/redux.dart';

import '../actions/payments_action.dart';
import '../modules/payments_state.dart';

final scannerReducer = combineReducers<PaymentsState>([
  TypedReducer<PaymentsState, SetScannedItem>(_setScannedItemState),
  TypedReducer<PaymentsState, SetReservation>(_setReservationState),
  TypedReducer<PaymentsState, SetTransactions>(_setTransactionsState),
]);

PaymentsState _setScannedItemState(
    PaymentsState? state, SetScannedItem payload) {
  return state!.copyWith(scannedItem: payload.scannedItem);
}

PaymentsState _setReservationState(
    PaymentsState? state, SetReservation payload) {
  return state!.copyWith(reservation: payload.reservation);
}

PaymentsState _setTransactionsState(
    PaymentsState? state, SetTransactions payload) {
  return state!.copyWith(transactions: payload.transactions);
}
