import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/core/enums.dart';
import 'package:guide_manager/features/excursions/domain/excursion.dart';
import 'package:guide_manager/features/excursions/domain/excursions_repository.dart';
import 'package:guide_manager/features/profile/data/profile_repository_impl.dart';

final excursionsRepositoryProvider = Provider<ExcursionsRepository>((ref) {
  return ExcursionsRepositoryImpl();
});

final guideLevelProvider = FutureProvider<GuideLevel?>((ref) async {
  final profileData = await ref.watch(profileDataProvider.future);
  return profileData?.level;
});

final excursionsProvider = FutureProvider.family<List<Excursion>, DateTime>((
  ref,
  date,
) async {
  final repository = ref.watch(excursionsRepositoryProvider);
  final guideLevel = await ref.watch(guideLevelProvider.future);
  if (guideLevel == null) {
    return [];
  }

  return repository.getExcursions(date: date, guideLevel: guideLevel);
});

class ExcursionsRepositoryImpl implements ExcursionsRepository {
  ExcursionsRepositoryImpl({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  Future<List<Excursion>> getExcursions({
    required DateTime date,
    required GuideLevel guideLevel,
  }) async {
    final email = _auth.currentUser?.email;
    if (email == null || email.isEmpty) {
      return [];
    }

    final selectedDate = DateTime(date.year, date.month, date.day);
    final nextDate = selectedDate.add(const Duration(days: 1));

    final snapshot = await _firestore
        .collection('excursions')
        .where('assignedGuides', arrayContains: email)
        .where(
          'startDate',
          isGreaterThanOrEqualTo: Timestamp.fromDate(selectedDate),
          isLessThan: Timestamp.fromDate(nextDate),
        )
        .withConverter<Excursion>(
          fromFirestore: (snapshot, _) {
            final data = snapshot.data();
            if (data == null) {
              throw Exception('Document at ${snapshot.id} is empty');
            }
            return Excursion.fromJson({...data, 'id': snapshot.id});
          },
          toFirestore: (excursion, _) => excursion.toJson(),
        )
        .get();

    final excursions =
        snapshot.docs
            .map((doc) => doc.data())
            .where((excursion) => excursion.requiredLevels.contains(guideLevel))
            .toList()
          ..sort((a, b) => a.startDate.compareTo(b.startDate));

    return excursions;
  }
}
