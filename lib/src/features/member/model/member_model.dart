class MemberModel {
  final String? id;
  final String? name;
  final String? phone;

  MemberModel({
    this.id,
    this.name,
    this.phone,
  });

  factory MemberModel.fromJson(String id, Map<String, dynamic> json) {
    return MemberModel(
      id: id,
      name: json['name'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
    };
  }
}
