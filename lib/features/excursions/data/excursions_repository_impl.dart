import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/features/excursions/domain/excursion.dart';
import 'package:guide_manager/features/excursions/domain/excursions_repository.dart';

final excursionsRepositoryProvider = Provider<ExcursionsRepository>((ref) {
  return ExcursionsRepositoryImpl();
});

class ExcursionsRepositoryImpl implements ExcursionsRepository {
  ExcursionsRepositoryImpl({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  Future<List<Excursion>> getExcursions() async {
    final email = _auth.currentUser?.email;
    if (email == null || email.isEmpty) {
      return [];
    }
    try {
      final snapshot = await _firestore
          .collection('excursions')
          .where('assignedGuides', arrayContains: email)
          .withConverter<Excursion>(
            fromFirestore: (snapshot, _) {
              final data = snapshot.data();
              if (data == null) throw Exception('Document at ${snapshot.id} is empty');
              return Excursion.fromJson(data);
            },
            toFirestore: (excursion, _) => excursion.toJson(),
          ).get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      rethrow;
    }
  }
}
