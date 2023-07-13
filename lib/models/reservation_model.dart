import 'package:grid_mobile/models/models.dart';

class ReservationModel {
  String? chargingPointId;
  int? reserveAmount;
  int? spacePickAmount;
  bool? isSelectManual;
  Space? space;
  PaymentModel? payment;

  ReservationModel(
      {this.chargingPointId,
      this.reserveAmount,
      this.spacePickAmount,
      this.isSelectManual,
      this.space,
      this.payment});

  ReservationModel copyWith(
      {String? chargingPointId,
      int? reserveAmount,
      int? spacePickAmount,
      bool? isSelectManual,
      Space? space,
      PaymentModel? payment}) {
    return ReservationModel(
      chargingPointId: chargingPointId ?? this.chargingPointId,
      reserveAmount: reserveAmount ?? this.reserveAmount,
      spacePickAmount: spacePickAmount ?? this.spacePickAmount,
      isSelectManual: isSelectManual ?? this.isSelectManual,
      space: space ?? this.space,
      payment: payment ?? this.payment,
    );
  }

  ReservationModel.fromJson(Map<String, dynamic> json) {
    chargingPointId = json['charging_point_id'];
    reserveAmount = json['reserve_amount'];
    spacePickAmount = json['space_pick_amount'];
    isSelectManual = json['is_select_manual'];
    space = json['space'] != null ? Space.fromJson(json['space']) : null;
    payment =
        json['payment'] != null ? PaymentModel.fromJson(json['payment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['charging_point_id'] = chargingPointId;
    data['reserve_amount'] = reserveAmount;
    data['space_pick_amount'] = spacePickAmount;
    data['is_select_manual'] = isSelectManual;
    if (space != null) {
      data['space'] = space!.toJson();
    }
    if (payment != null) {
      data['payment'] = space!.toJson();
    }
    return data;
  }
}

class Space {
  String? id;
  String? port;

  Space({this.id, this.port});

  Space.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    port = json['port'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['port'] = port;
    return data;
  }
}
