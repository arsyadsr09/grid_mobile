import '../../models/models.dart';

class PaymentsState {
  const PaymentsState({
    this.scannedItem,
    this.reservation,
    this.transactions,
  });

  final ScannedItem? scannedItem;
  final ReservationModel? reservation;
  final List<TransactionModel>? transactions;

  factory PaymentsState.initial() {
    return const PaymentsState(
        scannedItem: null,
        reservation: null,
        transactions: []);
  }

  PaymentsState copyWith(
      {ScannedItem? scannedItem,
      ReservationModel? reservation,
      List<TransactionModel>? transactions}) {
    return PaymentsState(
      scannedItem: scannedItem ?? this.scannedItem,
      reservation: reservation ?? this.reservation,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentsState &&
          runtimeType == other.runtimeType &&
          scannedItem == other.scannedItem &&
          reservation == other.reservation &&
          transactions == other.transactions;

  @override
  int get hashCode =>
      scannedItem.hashCode ^
      reservation.hashCode ^
      transactions.hashCode;
}
