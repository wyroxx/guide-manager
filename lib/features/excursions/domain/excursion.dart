import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guide_manager/features/excursions/data/timestamp_converter.dart';

part 'excursion.freezed.dart';
part 'excursion.g.dart';

@freezed
abstract class Excursion with _$Excursion {
  const factory Excursion({
    required String title,
    @TimestampConverter() required DateTime startsDate,
    @TimestampConverter() required DateTime endDate,
    required String route,
    required String meetingPlace,
    required bool hasSpots,
    required int requiredGuides,
    required bool hasLunch,
    required bool hasMasterclass,
    required List<GuideLevel> requiredLevels,
    required String companyId,
    required List<String> assignedGuides,
    required int maxParticipants,
    required String excursionType,
    required PaymentStatus paymentStatus,
  }) = _Excursion;

  factory Excursion.fromJson(Map<String, dynamic> json) =>
      _$ExcursionFromJson(json);
}

enum GuideLevel { junior, middle, senior }
enum PaymentStatus { paid, unpaid }
