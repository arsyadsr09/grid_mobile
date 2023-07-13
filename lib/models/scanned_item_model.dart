import 'package:grid_mobile/models/marker_model.dart';
import 'package:grid_mobile/models/payment_model.dart';

class ScannedItem {
  String? string;
  MarkerModel? data;
  PaymentModel? payment;

  ScannedItem({this.string, this.data, this.payment});

  ScannedItem copyWith(
      {String? string, PaymentModel? payment, MarkerModel? data}) {
    return ScannedItem(
      string: string ?? this.string,
      payment: payment ?? this.payment,
      data: data ?? this.data,
    );
  }

  ScannedItem.fromJson(Map<String, dynamic> json) {
    string = json['string'];
    data = MarkerModel.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['string'] = string;
    data['data'] = data;
    return data;
  }
}
