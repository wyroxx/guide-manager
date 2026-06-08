import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/core/enums.dart';
import 'package:guide_manager/features/excursions/domain/excursion.dart';
import 'package:guide_manager/features/excursions/domain/excursions_repository.dart';

final excursionsRepositoryProvider = Provider<ExcursionsRepository>((ref) {
  return ExcursionsRepositoryImpl();
});

final excursionsProvider = FutureProvider.family<List<Excursion>, DateTime>((
  ref,
  date,
) async {
  final repository = ref.watch(excursionsRepositoryProvider);
  return repository.getExcursions(date);
});

class ExcursionsRepositoryImpl implements ExcursionsRepository {
  ExcursionsRepositoryImpl({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  Future<List<Excursion>> getExcursions(DateTime date) async {
    final email = _auth.currentUser?.email;
    if (email == null || email.isEmpty) {
      return [];
    }

    final level = await _getGuideLevel(email);
    if (level == null) {
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
            return Excursion.fromJson(data);
          },
          toFirestore: (excursion, _) => excursion.toJson(),
        )
        .get();

    final excursions =
        snapshot.docs
            .map((doc) => doc.data())
            .where((excursion) => excursion.requiredLevels.contains(level))
            .toList()
          ..sort((a, b) => a.startsDate.compareTo(b.startsDate));

    return excursions;
  }

  Future<GuideLevel?> _getGuideLevel(String email) async {
    final snapshot = await _firestore
        .collection('guides')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    final String level = snapshot.docs.first.data()['level'];
    return GuideLevel.fromString(level);
  }
}
