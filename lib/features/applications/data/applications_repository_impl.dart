import 'package:guide_manager/core/enums.dart';
import 'package:guide_manager/features/applications/data/application.dart';
import 'package:guide_manager/features/applications/domain/applications_repository.dart';
import 'package:guide_manager/features/excursions/domain/excursion.dart';

class ApplicationsRepositoryImpl implements ApplicationsRepository {
  @override
  Future<void> applyToExcursion({required String excursionId, required String guideEmail}) {
    // TODO: implement applyToExcursion
    throw UnimplementedError();
  }

  @override
  Stream<List<Excursion>> watchAvailableExcursions({required String guideEmail, required GuideLevel guideLevel}) {
    // TODO: implement watchAvailableExcursions
    throw UnimplementedError();
  }

  @override
  Stream<List<Application>> watchMyApplications({required String guideEmail}) {
    // TODO: implement watchMyApplications
    throw UnimplementedError();
  }
  
}
