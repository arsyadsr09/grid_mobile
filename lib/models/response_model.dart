class ResponseModel {
  bool? status;
  String? notice;
  dynamic data;

  ResponseModel({this.status, this.notice, this.data});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    notice = json['notice'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['notice'] = notice;
    data['data'] = this.data;
    return data;
  }
}
