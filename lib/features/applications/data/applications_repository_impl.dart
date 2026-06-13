import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/core/enums.dart';
import 'package:guide_manager/core/logging/app_logger.dart';
import 'package:guide_manager/features/applications/data/application_dto.dart';
import 'package:guide_manager/features/applications/domain/application.dart';
import 'package:guide_manager/features/applications/domain/applications_repository.dart';
import 'package:guide_manager/features/excursions/domain/excursion.dart';
import 'package:guide_manager/features/profile/data/profile_repository_impl.dart';

final myApplicationsProvider = StreamProvider<List<Application>>((ref) {
  final repository = ref.watch(applicationsRepositoryProvider);
  final logger = ref.watch(appLoggerProvider);
  final guideUid = FirebaseAuth.instance.currentUser?.uid;
  if (guideUid == null) {
    return Stream.value(const <Application>[]);
  }
  return repository.watchMyApplications(guideUid: guideUid).handleError((
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
  final user = FirebaseAuth.instance.currentUser;
  final email = user?.email;

  if (user == null || email == null) {
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
      guideUid: user.uid,
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
    required Excursion excursion,
    required String guideUid,
    required String guideEmail,
  }) async {
    final application = Application(
      guideUid: guideUid,
      guideEmail: guideEmail,
      status: ApplicationStatus.pending,
      createdAt: DateTime.now(),
      excursionId: excursion.id,
      excursionTitle: excursion.title,
      excursionStartDate: excursion.startDate,
      excursionMaxParticipants: excursion.maxParticipants,
    );
    final applicationReference = _firestore
        .collection('excursions')
        .doc(excursion.id)
        .collection('applications')
        .doc(guideUid);

    await _firestore.runTransaction((transaction) async {
      final existingApplication = await transaction.get(applicationReference);
      if (existingApplication.exists) {
        _logger.info(
          'Applications',
          'Application already exists for ${excursion.id}',
        );
        return;
      }

      transaction.set(applicationReference, {
        ...ApplicationDto.toJson(application),
        'createdAt': FieldValue.serverTimestamp(),
      });
    });
    _logger.info('Applications', 'Application submitted for ${excursion.id}');
  }

  @override
  Stream<List<Excursion>> watchAvailableExcursions({
    required String guideUid,
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
            _loadAppliedExcursionIds(guideUid),
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

  Future<Set<String>> _loadAppliedExcursionIds(String guideUid) async {
    try {
      final snapshot = await _firestore
          .collectionGroup('applications')
          .where('guideUid', isEqualTo: guideUid)
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
  Stream<List<Application>> watchMyApplications({required String guideUid}) {
    return _firestore
        .collectionGroup('applications')
        .where('guideUid', isEqualTo: guideUid)
        .snapshots()
        .map((snapshot) {
          final applications = <Application>[];
          for (final document in snapshot.docs) {
            final excursionId = document.reference.parent.parent?.id;
            if (excursionId == null) {
              continue;
            }

            final applicationData = Map<String, dynamic>.from(document.data());
            applicationData['excursionId'] ??= excursionId;
            applications.add(ApplicationDto.fromJson(applicationData));
          }

          applications.sort((a, b) {
            final statusCompare = a.status.priority.compareTo(
              b.status.priority,
            );
            if (statusCompare != 0) {
              return statusCompare;
            }
            return b.createdAt.compareTo(a.createdAt);
          });
          _logger.debug(
            'Applications',
            'Loaded ${applications.length} guide applications',
          );
          return applications;
        });
  }
}
