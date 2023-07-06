import 'package:grid_mobile/models/marker_model.dart';

class ScannedItem {
  String? string;
  MarkerModel? data;

  ScannedItem({this.string, this.data});

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
