
class UserModel {
  int? userId;
  String? photo;
  String? firstName;
  String? lastName;
  String email;
  UserModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.photo,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) => UserModel(
        email: data["email"],
        userId: data['user_id'],
        firstName: data['first_name'],
        lastName: data['last_name'],
        photo: data['photo'],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "photo": photo,
      };

  UserModel copy({
    int? userId,
    String? firstName,
    String? lastName,
    String? photo,
    String? email,
  }) =>
      UserModel(
        userId: userId ?? this.userId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        photo: photo ?? this.photo,
        email: this.email,
      );

  factory UserModel.fromJsonString(Map<String, dynamic> data) => UserModel(
        email: data["email"],
        userId: data['user_id'],
        firstName: data['first_name'],
        lastName: data['last_name'],
        photo: data['photo'],
      );

  Map<String, dynamic> toJsonString() => {
        "email": email,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "photo": photo,
      };
}
