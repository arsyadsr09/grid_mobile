class TransactionModel {
  String? id;
  int? datetime;
  String? type;
  int? value;
  String? info;

  TransactionModel({this.id, this.datetime, this.type, this.value, this.info});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    datetime = json['datetime'];
    type = json['type'];
    value = json['value'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['datetime'] = datetime;
    data['type'] = type;
    data['value'] = value;
    data['info'] = info;
    return data;
  }
}
