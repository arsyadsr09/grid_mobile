class UserModel {
  String? id;
  String? email;
  String? displayName;
  String? serverAuthCode;
  String? photoURL;
  String? firstName;
  String? lastName;
  String? phone;
  int? roleId;
  String? idHash;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.email,
      this.displayName,
      this.serverAuthCode,
      this.photoURL,
      this.firstName,
      this.lastName,
      this.phone,
      this.roleId,
      this.idHash,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    displayName = json['display_name'];
    serverAuthCode = json['server_auth_code'];
    photoURL = json['photo_URL'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    roleId = json['role_id'];
    idHash = json['id_hash'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['display_name'] = displayName;
    data['server_auth_code'] = serverAuthCode;
    data['photo_URL'] = photoURL;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['role_id'] = roleId;
    data['id_hash'] = idHash;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
