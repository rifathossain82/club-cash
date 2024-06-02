import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String? id;
  final DateTime? datetime;
  final Member? member;
  final num? amount;
  final String? paymentMethod;
  final String? reason;
  final String? remarks;
  final String? type;
  final DateTime? timestamp;

  TransactionModel({
    this.id,
    this.datetime,
    this.member,
    this.amount,
    this.paymentMethod,
    this.reason,
    this.remarks,
    this.type,
    this.timestamp,
  });

  factory TransactionModel.fromJson(String id, Map<String, dynamic> json) {
    return TransactionModel(
      id: id,
      datetime: json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
      member: json['member'] == null ? null : Member.fromJson(json['member']),
      amount: json['amount'] ?? 0,
      paymentMethod: json['paymentMethod'],
      reason: json['reason'],
      remarks: json['remarks'],
      type: json['type'],
      timestamp: json["timestamp"] == null
          ? null
          : (json["timestamp"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'datetime': datetime?.toIso8601String(),
      'member': member?.toJson(),
      'amount': amount,
      'paymentMethod': paymentMethod,
      'reason': reason,
      'remarks': remarks,
      'type': type,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
    };
  }

  TransactionModel copyWith({
    String? id,
    DateTime? datetime,
    Member? member,
    num? amount,
    String? paymentMethod,
    String? reason,
    String? remarks,
    String? type,
    DateTime? timestamp,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      datetime: datetime ?? this.datetime,
      member: member ?? this.member,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      reason: reason ?? this.reason,
      remarks: remarks ?? this.remarks,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class Member {
  final String? id;
  final String? name;

  Member({
    this.id,
    this.name,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
