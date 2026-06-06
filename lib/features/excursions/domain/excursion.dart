import 'package:freezed_annotation/freezed_annotation.dart';

part 'excursion.freezed.dart';

@freezed
abstract class Excursion with _$Excursion {
  const factory Excursion({
    required String id,
    required String title,
    required DateTime startsDate,
    required DateTime endDate,
    required String route,
    required String meetingPlace,
    required bool hasSpots,
    required int requiredGuides,
    required bool hasLunch,
    required bool hasMasterclass,
    required GuideLevel requiredLevel,
    required String companyId,
    required List<String> assignedGuides,
    required int maxParticipants,
    required String excursionType,
    required PaymentStatus paymentStatus,
  }) = _Excursion;
}

enum GuideLevel { junior, middle, senior }
enum PaymentStatus { paid, unpaid }
