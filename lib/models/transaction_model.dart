class TransactionModel {
  String? datetime;
  String? idHash;
  int? creditIdr;
  double? creditKwh;
  String? type;

  TransactionModel(
      {this.datetime,
      this.idHash,
      this.creditIdr,
      this.creditKwh,
      this.type});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    datetime = json['datetime'];
    idHash = json['id_hash'];
    creditIdr = json['credit_idr'];
    creditKwh = json['credit_kwh'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['datetime'] = datetime;
    data['id_hash'] = idHash;
    data['credit_idr'] = creditIdr;
    data['credit_kwh'] = creditKwh;
    data['type'] = type;
    return data;
  }
}
