import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_manager/core/enums.dart';

class Application {
  final String email;
  final ApplicationStatus status;
  final String excursionId;
  final DateTime createdAt;

  const Application({
    required this.email,
    required this.status,
    required this.createdAt,
    required this.excursionId,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'status': status.statusEng,
    'excursionId': excursionId,
    'createdAt': Timestamp.fromDate(createdAt),
  };

  factory Application.fromJson(Map<String, dynamic> json) => Application(
    email: json['email'] as String,
    status: ApplicationStatus.fromString(json['status'] as String),
    excursionId: json['excursionId'] as String,
    createdAt: (json['createdAt'] as Timestamp).toDate(),
  );
}
