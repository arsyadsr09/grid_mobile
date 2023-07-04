class MarkerModel {
  String? id;
  String? name;
  String? address;
  double? rating;
  List<Reviews>? reviews;
  List<int>? chargingPorts;

  MarkerModel(
      {this.id,
      this.name,
      this.address,
      this.rating,
      this.reviews,
      this.chargingPorts});

  MarkerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    rating = json['rating'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    chargingPorts = json['charging_ports'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['rating'] = rating;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    data['charging_ports'] = chargingPorts;
    return data;
  }
}

class Reviews {
  String? userId;
  String? userName;
  String? message;

  Reviews({this.userId, this.userName, this.message});

  Reviews.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['message'] = message;
    return data;
  }
}
