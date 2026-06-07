import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/features/profile/domain/profile_data.dart';
import 'package:guide_manager/features/profile/domain/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl();
});

final profileDataProvider = FutureProvider<ProfileData?>((ref) async {
  final repository = ref.watch(profileRepositoryProvider);
  return repository.getProfileData();
});

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  @override
  Future<ProfileData?> getProfileData() async {
    final email = _auth.currentUser?.email;

    if (email == null || email.isEmpty) {
      throw Exception('Пользователь не авторизован');
    }

    final snapshot = await _firestore
        .collection('guides')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    final doc = snapshot.docs.first;

    return ProfileData.fromJson(<String, dynamic>{...doc.data(), 'id': doc.id});
  }
}
