import 'package:guide_manager/core/enums.dart';
import 'package:guide_manager/features/excursions/domain/excursion.dart';

abstract interface class ExcursionsRepository {
  Future<List<Excursion>> getExcursions({
    required DateTime date,
    required GuideLevel guideLevel,
  });
}
