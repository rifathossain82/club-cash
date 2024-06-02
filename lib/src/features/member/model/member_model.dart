import 'package:cloud_firestore/cloud_firestore.dart';

class MemberModel {
  final String? id;
  final String? name;
  final String? phone;
  final DateTime? timestamp;

  MemberModel({
    this.id,
    this.name,
    this.phone,
    this.timestamp,
  });

  factory MemberModel.fromJson(String id, Map<String, dynamic> json) {
    return MemberModel(
      id: id,
      name: json['name'],
      phone: json['phone'],
      timestamp: json["timestamp"] == null ? null : (json["timestamp"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
    };
  }
}
