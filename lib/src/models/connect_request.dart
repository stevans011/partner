// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:partner/src/utils/enums.dart';

class ConnectRequest extends Equatable {
  final String id;
  final String senderId;
  final String receiverId;
  final RequestStatus status;
  final Timestamp createdAt;

  const ConnectRequest({
    required this.id,
    required this.senderId,
    required this.createdAt,
    required this.receiverId,
    required this.status,
  });

  factory ConnectRequest.fromJson(Map<String, dynamic> json) => ConnectRequest(
        id: json['id'],
        senderId: json['senderId'],
        createdAt: json['createdAt'],
        receiverId: json['receiverId'],
        status: json['status'].toString().requestStatus,
      );

  @override
  List<Object?> get props => [id];

  ConnectRequest copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    RequestStatus? status,
    Timestamp? createdAt,
  }) {
    return ConnectRequest(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
