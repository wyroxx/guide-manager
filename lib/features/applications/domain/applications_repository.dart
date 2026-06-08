import 'package:guide_manager/core/enums.dart';
import 'package:guide_manager/features/applications/data/application.dart';
import 'package:guide_manager/features/excursions/domain/excursion.dart';

abstract interface class ApplicationsRepository {
  Stream<List<Application>> watchMyApplications({
    required String guideEmail,
  });

  Stream<List<Excursion>> watchAvailableExcursions({
    required String guideEmail,
    required GuideLevel guideLevel,
  });

  Future<void> applyToExcursion({
    required String excursionId,
    required String guideEmail,
  });
}
