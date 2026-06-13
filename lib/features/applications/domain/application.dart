import 'package:guide_manager/core/enums.dart';

class Application {
  final String guideUid;
  final String guideEmail;
  final ApplicationStatus status;
  final String excursionId;
  final DateTime createdAt;
  final String excursionTitle;
  final DateTime excursionStartDate;
  final int excursionMaxParticipants;

  const Application({
    required this.guideUid,
    required this.guideEmail,
    required this.status,
    required this.createdAt,
    required this.excursionId,
    required this.excursionTitle,
    required this.excursionStartDate,
    required this.excursionMaxParticipants,
  });
}
