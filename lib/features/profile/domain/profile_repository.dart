import 'package:guide_manager/features/profile/domain/profile_data.dart';

abstract interface class ProfileRepository {
  Stream<ProfileData?> watchProfileData();
}
