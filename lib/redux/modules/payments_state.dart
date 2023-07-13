import '../../models/models.dart';

class PaymentsState {
  const PaymentsState({this.scannedItem, this.reservation});

  final ScannedItem? scannedItem;
  final ReservationModel? reservation;

  factory PaymentsState.initial() {
    return const PaymentsState(scannedItem: null, reservation: null);
  }

  PaymentsState copyWith(
      {ScannedItem? scannedItem, ReservationModel? reservation}) {
    return PaymentsState(
      scannedItem: scannedItem ?? this.scannedItem,
      reservation: reservation ?? this.reservation,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentsState &&
          runtimeType == other.runtimeType &&
          scannedItem == other.scannedItem &&
          reservation == other.reservation;

  @override
  int get hashCode => scannedItem.hashCode ^ reservation.hashCode;
}
