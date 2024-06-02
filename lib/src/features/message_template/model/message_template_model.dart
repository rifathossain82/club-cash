import 'package:cloud_firestore/cloud_firestore.dart';

class MessageTemplateModel {
  final String? id;
  final String? title;
  final String? message;
  final DateTime? timestamp;

  MessageTemplateModel({
    this.id,
    this.title,
    this.message,
    this.timestamp,
  });

  factory MessageTemplateModel.fromJson(String? id, Map<String, dynamic> json) {
    return MessageTemplateModel(
      id: id,
      title: json['title'],
      message: json['message'],
      timestamp: json['timestamp'] != null
          ? (json['timestamp'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
    };
  }
}
