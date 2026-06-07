import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guide_manager/core/enums.dart';

part 'profile_data.freezed.dart';
part 'profile_data.g.dart';

@freezed
abstract class ProfileData with _$ProfileData {
  const factory ProfileData({
    required String id,
    required String name,
    required String email,
    required String phone,
    required GuideLevel level,
    required int toursCount,
    required String bio,
    required String avatar,
    required String telegramAlias,
  }) = _ProfileData;

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);
}
