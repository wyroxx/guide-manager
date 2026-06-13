import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_manager/core/enums.dart';
import 'package:guide_manager/features/applications/domain/application.dart';

abstract final class ApplicationDto {
  static Map<String, dynamic> toJson(Application application) => {
    'guideUid': application.guideUid,
    'guideEmail': application.guideEmail,
    'status': application.status.statusEng,
    'excursionId': application.excursionId,
    'createdAt': Timestamp.fromDate(application.createdAt),
    'excursionTitle': application.excursionTitle,
    'excursionStartDate': Timestamp.fromDate(application.excursionStartDate),
    'excursionMaxParticipants': application.excursionMaxParticipants,
  };

  static Application fromJson(Map<String, dynamic> json) {
    final createdAt = json['createdAt'] as Timestamp?;

    return Application(
      guideUid: json['guideUid'] as String,
      guideEmail: json['guideEmail'] as String,
      status: ApplicationStatus.fromString(json['status'] as String),
      excursionId: json['excursionId'] as String,
      createdAt: createdAt?.toDate() ?? DateTime.now(),
      excursionTitle: json['excursionTitle'] as String,
      excursionStartDate: (json['excursionStartDate'] as Timestamp).toDate(),
      excursionMaxParticipants: (json['excursionMaxParticipants'] as num)
          .toInt(),
    );
  }
}
