import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/core/enums.dart';
import 'package:guide_manager/features/applications/data/application.dart';
import 'package:guide_manager/features/applications/domain/applications_repository.dart';
import 'package:guide_manager/features/excursions/domain/excursion.dart';
import 'package:guide_manager/features/profile/data/profile_repository_impl.dart';

final myApplicationsProvider = StreamProvider<List<Excursion>>((ref) {
  final repository = ref.watch(applicationsRepositoryProvider);
  final email = FirebaseAuth.instance.currentUser?.email;
  if (email == null) {
    return Stream.value(const <Excursion>[]);
  }
  return repository.watchMyApplications(guideEmail: email);
});

final availableExcursionsProvider = StreamProvider<List<Excursion>>(
  (ref) async* {
    final repository = ref.watch(applicationsRepositoryProvider);
    final email = FirebaseAuth.instance.currentUser?.email;

    if (email == null) {
      yield const <Excursion>[];
      return;
    }

    final profileData = await ref.watch(profileDataProvider.future);
    final level = profileData?.level;

    if (level == null) {
      yield const <Excursion>[];
      return;
    }

    yield* repository.watchAvailableExcursions(
      guideEmail: email,
      guideLevel: level,
    );
  },
);

final applicationsRepositoryProvider = Provider<ApplicationsRepository>((ref) {
  return ApplicationsRepositoryImpl();
});

class ApplicationsRepositoryImpl implements ApplicationsRepository {
  ApplicationsRepositoryImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<void> applyToExcursion({
    required String excursionId,
    required String guideEmail,
  }) async {
    final application = Application(
      email: guideEmail,
      status: ApplicationStatus.pending,
      createdAt: DateTime.now(),
      excursionId: excursionId,
    );
    await _firestore
        .collection('excursions')
        .doc(excursionId)
        .collection('applications')
        .doc(guideEmail)
        .set(application.toJson());
  }

  @override
  Stream<List<Excursion>> watchAvailableExcursions({
    required String guideEmail,
    required GuideLevel guideLevel,
  }) {
    return _firestore
        .collection('excursions')
        .where('hasSpots', isEqualTo: true)
        .where('requiredLevels', arrayContains: guideLevel.nameEng)
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
        .snapshots()
        .asyncMap((snapshot) async {
          final excursions = <Excursion>[];

          for (final document in snapshot.docs) {
            final excursion = document.data();
            if (excursion.assignedGuides.contains(guideEmail)) {
              continue;
            }

            final application = await document.reference
                .collection('applications')
                .doc(guideEmail)
                .get();
            if (application.exists) {
              continue;
            }

            final isBlacklisted = await _isGuideBlacklisted(
              companyId: excursion.companyId,
              guideEmail: guideEmail,
            );
            if (isBlacklisted) {
              continue;
            }

            excursions.add(excursion);
          }

          excursions.sort((a, b) => a.startDate.compareTo(b.startDate));
          return excursions;
        });
  }

  @override
  Stream<List<Excursion>> watchMyApplications({required String guideEmail}) {
    return _firestore
        .collectionGroup('applications')
        .where('email', isEqualTo: guideEmail)
        .snapshots()
        .asyncMap((snapshot) async {
          final excursions = await Future.wait(
            snapshot.docs.map(_excursionFromApplication),
          );

          return excursions.whereType<Excursion>().toList()..sort(
            (a, b) =>
                b.application!.createdAt.compareTo(a.application!.createdAt),
          );
        });
  }

  Future<Excursion?> _excursionFromApplication(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) async {
    final excursionReference = document.reference.parent.parent;
    if (excursionReference == null) {
      return null;
    }

    final applicationData = Map<String, dynamic>.from(document.data());
    applicationData['excursionId'] ??= excursionReference.id;

    final excursionSnapshot = await excursionReference.get();
    final excursionData = excursionSnapshot.data();
    if (excursionData == null) {
      return null;
    }

    return Excursion.fromJson(
      excursionData,
    ).copyWith(application: Application.fromJson(applicationData));
  }

  Future<bool> _isGuideBlacklisted({
    required String companyId,
    required String guideEmail,
  }) async {
    if (companyId.isEmpty) {
      return false;
    }
    final company = await _firestore
        .collection('companies')
        .doc(companyId)
        .get();
    final banList = company.data()?['banList'] as List<dynamic>? ?? [];
    return banList.contains(guideEmail);
  }
}
