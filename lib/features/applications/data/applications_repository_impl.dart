import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/core/enums.dart';
import 'package:guide_manager/core/logging/app_logger.dart';
import 'package:guide_manager/features/applications/data/application.dart';
import 'package:guide_manager/features/applications/domain/applications_repository.dart';
import 'package:guide_manager/features/excursions/domain/excursion.dart';
import 'package:guide_manager/features/profile/data/profile_repository_impl.dart';

final myApplicationsProvider = StreamProvider<List<Excursion>>((ref) {
  final repository = ref.watch(applicationsRepositoryProvider);
  final logger = ref.watch(appLoggerProvider);
  final email = FirebaseAuth.instance.currentUser?.email;
  if (email == null) {
    return Stream.value(const <Excursion>[]);
  }
  return repository.watchMyApplications(guideEmail: email).handleError((
    Object error,
    StackTrace stackTrace,
  ) {
    logger.error(
      'Applications',
      'Failed to watch guide applications',
      error: error,
      stackTrace: stackTrace,
    );
    Error.throwWithStackTrace(error, stackTrace);
  });
});

final availableExcursionsProvider = StreamProvider<List<Excursion>>((
  ref,
) async* {
  final repository = ref.watch(applicationsRepositoryProvider);
  final logger = ref.watch(appLoggerProvider);
  final email = FirebaseAuth.instance.currentUser?.email;

  if (email == null) {
    yield const <Excursion>[];
    return;
  }

  try {
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
  } catch (error, stackTrace) {
    logger.error(
      'Applications',
      'Failed to watch available excursions',
      error: error,
      stackTrace: stackTrace,
    );
    rethrow;
  }
});

final applicationsRepositoryProvider = Provider<ApplicationsRepository>((ref) {
  return ApplicationsRepositoryImpl(ref.watch(appLoggerProvider));
});

class ApplicationsRepositoryImpl implements ApplicationsRepository {
  ApplicationsRepositoryImpl(this._logger, {FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;
  final AppLogger _logger;

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
        .set({
          ...application.toJson(),
          'createdAt': FieldValue.serverTimestamp(),
        });
    _logger.info('Applications', 'Application submitted for $excursionId');
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
            return Excursion.fromJson({...data, 'id': snapshot.id});
          },
          toFirestore: (excursion, _) => excursion.toJson(),
        )
        .snapshots()
        .asyncMap((snapshot) async {
          final relatedData = await Future.wait([
            _loadAppliedExcursionIds(guideEmail),
            _loadBlacklistedCompanyIds(guideEmail),
          ]);
          final appliedExcursionIds = relatedData.first;
          final blacklistedCompanyIds = relatedData.last;

          final excursions = snapshot.docs
              .map((document) => document.data())
              .where(
                (excursion) =>
                    !excursion.assignedGuides.contains(guideEmail) &&
                    !appliedExcursionIds.contains(excursion.id) &&
                    !blacklistedCompanyIds.contains(excursion.companyId),
              )
              .toList();

          excursions.sort((a, b) => a.startDate.compareTo(b.startDate));
          _logger.debug(
            'Applications',
            'Loaded ${excursions.length} available excursions',
          );
          return excursions;
        });
  }

  Future<Set<String>> _loadAppliedExcursionIds(String guideEmail) async {
    try {
      final snapshot = await _firestore
          .collectionGroup('applications')
          .where('email', isEqualTo: guideEmail)
          .get();

      return snapshot.docs
          .map((document) => document.reference.parent.parent?.id)
          .whereType<String>()
          .toSet();
    } catch (error, stackTrace) {
      _logger.error(
        'Applications',
        'Failed to query application collection group',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<Set<String>> _loadBlacklistedCompanyIds(String guideEmail) async {
    try {
      final snapshot = await _firestore
          .collection('companies')
          .where('banList', arrayContains: guideEmail)
          .get();

      return snapshot.docs.map((document) => document.id).toSet();
    } catch (error, stackTrace) {
      _logger.error(
        'Applications',
        'Failed to query blacklisted companies',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
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

          final result = excursions.whereType<Excursion>().toList()
            ..sort((a, b) {
              final applicationA = a.application!;
              final applicationB = b.application!;

              final statusCompare = applicationA.status.priority.compareTo(
                applicationB.status.priority,
              );

              if (statusCompare != 0) {
                return statusCompare;
              }

              return applicationB.createdAt.compareTo(applicationA.createdAt);
            });
          _logger.debug(
            'Applications',
            'Loaded ${result.length} guide applications',
          );
          return result;
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

    return Excursion.fromJson({
      ...excursionData,
      'id': excursionReference.id,
    }).copyWith(application: Application.fromJson(applicationData));
  }
}
