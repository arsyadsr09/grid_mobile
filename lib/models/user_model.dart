class UserModel {
  String? id;
  String? email;
  String? displayName;
  String? serverAuthCode;
  String? photoURL;

  UserModel(
      {this.id,
      this.email,
      this.displayName,
      this.serverAuthCode,
      this.photoURL});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    displayName = json['displayName'];
    serverAuthCode = json['serverAuthCode'];
    photoURL = json['photoURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['displayName'] = displayName;
    data['serverAuthCode'] = serverAuthCode;
    data['photoURL'] = photoURL;
    return data;
  }
}