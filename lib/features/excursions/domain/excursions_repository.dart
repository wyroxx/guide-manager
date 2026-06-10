import 'package:guide_manager/core/enums.dart';
import 'package:guide_manager/features/excursions/domain/excursion.dart';

abstract interface class ExcursionsRepository {
  Stream<List<Excursion>> watchExcursions({
    required DateTime date,
    required GuideLevel guideLevel,
  });
}
