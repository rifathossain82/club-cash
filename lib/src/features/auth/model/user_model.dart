class UserModel {
  final String id;
  final String username;
  final String phone;

  UserModel({
    required this.id,
    required this.username,
    required this.phone,
  });

  factory UserModel.fromJson(String id, Map<String, dynamic> json) {
    return UserModel(
      id: id,
      username: json['username'],
      phone: json['phone'],
    );
  }
}
