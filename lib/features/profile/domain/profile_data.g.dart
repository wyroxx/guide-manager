// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => _ProfileData(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  level: $enumDecode(_$GuideLevelEnumMap, json['level']),
  toursCount: (json['toursCount'] as num).toInt(),
  bio: json['bio'] as String,
  avatar: json['avatar'] as String,
  telegramAlias: json['telegramAlias'] as String,
);

Map<String, dynamic> _$ProfileDataToJson(_ProfileData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'level': _$GuideLevelEnumMap[instance.level]!,
      'toursCount': instance.toursCount,
      'bio': instance.bio,
      'avatar': instance.avatar,
      'telegramAlias': instance.telegramAlias,
    };

const _$GuideLevelEnumMap = {
  GuideLevel.trainee: 'trainee',
  GuideLevel.junior: 'junior',
  GuideLevel.middle: 'middle',
  GuideLevel.senior: 'senior',
};
