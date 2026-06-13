import 'package:guide_manager/core/enums.dart';
import 'package:guide_manager/features/applications/domain/application.dart';
import 'package:guide_manager/features/excursions/domain/excursion.dart';

abstract interface class ApplicationsRepository {
  Stream<List<Application>> watchMyApplications({required String guideUid});

  Stream<List<Excursion>> watchAvailableExcursions({
    required String guideUid,
    required String guideEmail,
    required GuideLevel guideLevel,
  });

  Future<void> applyToExcursion({
    required Excursion excursion,
    required String guideUid,
    required String guideEmail,
  });
}
