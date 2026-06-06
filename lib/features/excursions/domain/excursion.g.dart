// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'excursion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Excursion _$ExcursionFromJson(Map<String, dynamic> json) => _Excursion(
  title: json['title'] as String,
  startsDate: const TimestampConverter().fromJson(
    json['startsDate'] as Timestamp,
  ),
  endDate: const TimestampConverter().fromJson(json['endDate'] as Timestamp),
  route: json['route'] as String,
  meetingPlace: json['meetingPlace'] as String,
  hasSpots: json['hasSpots'] as bool,
  requiredGuides: (json['requiredGuides'] as num).toInt(),
  hasLunch: json['hasLunch'] as bool,
  hasMasterclass: json['hasMasterclass'] as bool,
  requiredLevels: (json['requiredLevels'] as List<dynamic>)
      .map((e) => $enumDecode(_$GuideLevelEnumMap, e))
      .toList(),
  companyId: json['companyId'] as String,
  assignedGuides: (json['assignedGuides'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  maxParticipants: (json['maxParticipants'] as num).toInt(),
  excursionType: json['excursionType'] as String,
  paymentStatus: $enumDecode(_$PaymentStatusEnumMap, json['paymentStatus']),
);

Map<String, dynamic> _$ExcursionToJson(_Excursion instance) =>
    <String, dynamic>{
      'title': instance.title,
      'startsDate': const TimestampConverter().toJson(instance.startsDate),
      'endDate': const TimestampConverter().toJson(instance.endDate),
      'route': instance.route,
      'meetingPlace': instance.meetingPlace,
      'hasSpots': instance.hasSpots,
      'requiredGuides': instance.requiredGuides,
      'hasLunch': instance.hasLunch,
      'hasMasterclass': instance.hasMasterclass,
      'requiredLevels': instance.requiredLevels
          .map((e) => _$GuideLevelEnumMap[e]!)
          .toList(),
      'companyId': instance.companyId,
      'assignedGuides': instance.assignedGuides,
      'maxParticipants': instance.maxParticipants,
      'excursionType': instance.excursionType,
      'paymentStatus': _$PaymentStatusEnumMap[instance.paymentStatus]!,
    };

const _$GuideLevelEnumMap = {
  GuideLevel.junior: 'junior',
  GuideLevel.middle: 'middle',
  GuideLevel.senior: 'senior',
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.paid: 'paid',
  PaymentStatus.unpaid: 'unpaid',
};
