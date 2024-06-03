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
      // To perform search we need to store nameSubstrings,
      // but it's not needed in model, so we ignore it.
      'nameSubstrings': generateSubstrings(name ?? ''),
      'name': name,
      'phone': phone,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
    };
  }


  List<String> generateSubstrings(String name) {
    List<String> substrings = [];
    name = name.toLowerCase();

    for (int i = 0; i < name.length; i++) {
      for (int j = i + 1; j <= name.length; j++) {
        substrings.add(name.substring(i, j));
      }
    }
    return substrings;
  }
}
