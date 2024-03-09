import 'package:equatable/equatable.dart';
import 'package:partner/src/models/connect_request.dart';

class Partner extends Equatable {
  final String id;
  final String dob;
  final String username;
  final String phone;

  final ConnectRequest? connectRequest;

  const Partner({
    required this.id,
    required this.dob,
    required this.username,
    required this.phone,
    this.connectRequest,
  });

  const Partner.initial({
    this.id = "",
    this.dob = "",
    this.username = "",
    this.phone = "",
    this.connectRequest,
  });

  factory Partner.fromJson(Map<String, dynamic> json) => Partner(
        id: json['id'],
        dob: json['dob'],
        username: json['username'],
        phone: json['phone'],
      );

  @override
  List<Object?> get props => [id];

  Partner copyWith({
    String? id,
    String? dob,
    String? username,
    String? phone,
  }) {
    return Partner(
      id: id ?? this.id,
      dob: dob ?? this.dob,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      connectRequest: connectRequest,
    );
  }

  // Copy request if already has request between
  Partner copyWithRequest(ConnectRequest request) {
    return Partner(
      id: id,
      dob: dob,
      username: username,
      phone: phone,
      connectRequest: request,
    );
  }
}
