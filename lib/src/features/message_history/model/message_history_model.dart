import 'package:cloud_firestore/cloud_firestore.dart';

class MessageHistoryModel {
  final String? id;
  final String? message;
  final DateTime? timestamp;

  MessageHistoryModel({
    this.id,
    this.message,
    this.timestamp,
  });

  factory MessageHistoryModel.fromJson(String? id, Map<String, dynamic> json) {
    return MessageHistoryModel(
      id: id,
      message: json['message'],
      timestamp: json['timestamp'] != null
          ? (json['timestamp'] as Timestamp).toDate()
          : null,
    );
  }

  /// Don't want to store id, so ignore it.
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
    };
  }
}
