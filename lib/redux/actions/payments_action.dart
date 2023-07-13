import 'package:grid_mobile/models/models.dart';
import 'package:grid_mobile/models/scanned_item_model.dart';

class SetScannedItem {
  final ScannedItem? scannedItem;

  SetScannedItem({this.scannedItem});
}

class SetReservation {
  final ReservationModel? reservation;

  SetReservation({this.reservation});
}
