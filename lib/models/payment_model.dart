class PaymentModel {
  String? refNumber;
  int? total;
  int? amount;
  String? paymentMethod;
  int? tax;
  String? chargingType;
  String? parkingTicket;
  int? createdAt;

  PaymentModel(
      {this.refNumber,
      this.total,
      this.amount,
      this.paymentMethod,
      this.tax,
      this.chargingType,
      this.parkingTicket,
      this.createdAt});

  PaymentModel copyWith(
      {String? refNumber,
      int? total,
      int? amount,
      String? paymentMethod,
      int? tax,
      String? chargingType,
      String? parkingTicket,
      int? createdAt}) {
    return PaymentModel(
      refNumber: refNumber ?? this.refNumber,
      total: total ?? this.total,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      tax: tax ?? this.tax,
      chargingType: chargingType ?? this.chargingType,
      parkingTicket: parkingTicket ?? this.parkingTicket,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  PaymentModel.fromJson(Map<String, dynamic> json) {
    refNumber = json['ref_number'];
    total = json['total'];
    amount = json['amount'];
    paymentMethod = json['payment_method'];
    tax = json['tax'];
    chargingType = json['charging_type'];
    parkingTicket = json['parking_ticket'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ref_number'] = refNumber;
    data['total'] = total;
    data['amount'] = amount;
    data['payment_method'] = paymentMethod;
    data['tax'] = tax;
    data['charging_type'] = chargingType;
    data['parking_ticket'] = parkingTicket;
    data['created_at'] = createdAt;
    return data;
  }
}
