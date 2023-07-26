import 'package:grid_mobile/models/models.dart';

class SetScannedItem {
  final ScannedItem? scannedItem;

  SetScannedItem({this.scannedItem});
}

class SetReservation {
  final ReservationModel? reservation;

  SetReservation({this.reservation});
}

class SetTransactions {
  final List<TransactionModel>? transactions;

  SetTransactions({this.transactions});
}
