import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/core/logging/app_logger.dart';
import 'package:guide_manager/features/profile/domain/profile_data.dart';
import 'package:guide_manager/features/profile/domain/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(ref.watch(appLoggerProvider));
});

final profileDataProvider = FutureProvider<ProfileData?>((ref) async {
  final repository = ref.watch(profileRepositoryProvider);
  final logger = ref.watch(appLoggerProvider);

  try {
    return await repository.getProfileData();
  } catch (error, stackTrace) {
    logger.error(
      'Profile',
      'Failed to load profile',
      error: error,
      stackTrace: stackTrace,
    );
    rethrow;
  }
});

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(
    this._logger, {
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  }) : _auth = auth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final AppLogger _logger;

  @override
  Future<ProfileData?> getProfileData() async {
    final email = _auth.currentUser?.email;

    if (email == null || email.isEmpty) {
      throw Exception('Пользователь не авторизован');
    }

    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Пользователь не авторизован');
    }

    final doc = await _firestore.collection('guides').doc(user.uid).get();

    if (!doc.exists) {
      _logger.warning('Profile', 'Guide document does not exist');
      return null;
    }

    final data = doc.data();
    if (data == null || data['email'] != email) {
      _logger.warning('Profile', 'Guide document has invalid ownership data');
      return null;
    }

    _logger.debug('Profile', 'Profile loaded successfully');
    return ProfileData.fromJson(<String, dynamic>{...data, 'id': doc.id});
  }
}
